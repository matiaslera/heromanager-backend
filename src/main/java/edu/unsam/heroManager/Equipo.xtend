package edu.unsam.heroManager

import java.util.HashSet
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import org.uqbar.commons.model.exceptions.UserException
import com.fasterxml.jackson.annotation.JsonProperty

@Observable
@Accessors
@Transactional
class Equipo implements Entidad {
	String id 
	String nombre 
	Set<SuperIndividuo> integrantes = new HashSet<SuperIndividuo>
	SuperIndividuo lider
	SuperIndividuo owner

	override validar() {
		if (nombre === null) {
			throw new UserException("Debe ingresar nombre")
		}
	}
	override toString() {
		nombre
	}
	

	def agregarMiembro(SuperIndividuo miembroNuevo) {
		if (miembroNuevo.esVillano()) {
			throw new UserException("El tipo de SuperIndividuo no puede ser villano")
		}
		if (equipoEstaLleno) {
			throw new UserException("El equipo esta lleno")
		}
		integrantes.add(miembroNuevo)
	}

	def integrantesSenior() {
		integrantes.filter[esSenior]
	}

	def IntegrantesNoSenior() {
		integrantes.filter[!esSenior]
	}

	def Double poderGrupal() {

		if (lider.tienePastaDeLider)
			this.tienePastaElSuperIndividuo * (this.amistadEnElEquip * 0.05) + this.tienePastaElSuperIndividuo
		else
			this.noTienePastaElSuperIndividuo * (this.amistadEnElEquip * 0.05) + this.noTienePastaElSuperIndividuo
	}

	def tienePastaElSuperIndividuo() {
		lider.efectividad + 0.8 * integrantesSenior.fold(0.0, [ total, integrante |
			total + integrante.efectividad
		]) + 0.5 * IntegrantesNoSenior.fold(0.0, [total, integrante|total + integrante.poderDeAtaque])
	}

	def noTienePastaElSuperIndividuo() {
		lider.efectividad + 0.4 * integrantes.fold(0.0, [ total, integrante |
			total + integrante.efectividad * (this.amistadEnElEquip * 0.05)
		])
	}

	def chancesDeContrarrestarUnaAmenaza(Amenaza amenaza) {
		(this.poderGrupal / (this.poderGrupal + amenaza.nivelDeAmenaza)) * 100
	}

	def costoDeCombatirUnaAmenaza(Amenaza amenaza) {
		(poderGrupal + distanciaEntreBaseMasLejanaYAmenaza(amenaza) ) * (cantidadEnemigosInvolucrados(amenaza) / 10 + 1)
	}

	def cantidadEnemigosInvolucrados(Amenaza amenaza) {
		this.todosLosIntegrantes.fold(0.0, [ total, integrante |
			total + integrante.cantidadDeEnemigosEnUnAtaque(amenaza)
		])

	}

	def baseMasLejana(Amenaza amenaza) {
		integrantes.maxBy[getBaseDeOps.distance(amenaza.ubicacion)].getBaseDeOps
	}

	def distanciaEntreBaseMasLejanaYAmenaza(Amenaza amenaza) {
		baseMasLejana(amenaza).distance(amenaza.ubicacion)
	}

	def todosLosIntegrantes() {
		(integrantes + #{lider}).toList
	}

	def amistadEnElEquip() {
		this.todosLosIntegrantes.fold(0.0, [total, individuo|total + cantidadDeAmigosDelEquipo(individuo)])
	}

	def cantidadDeAmigosDelEquipo(SuperIndividuo individuo) {
		var listaEquipo = this.todosLosIntegrantes.filter(ind|ind != individuo)
		listaEquipo.fold(0.0, [acum, SuperIndividuo|if(individuo.esMiAmigo(SuperIndividuo)) acum + 1 else acum])
	}

	def equipoEstaLleno() {
		todosLosIntegrantes.size >= 10
	}
	@JsonProperty("posiblesIntegrantes")
	def superIndividuosQuePudenPertenecerAlEquipo() {
		val lista = RepoSuperIndividuo.getInstance().elementosQueNoEstanEnLaLista(todosLosIntegrantes)
		lista.removeIf(individuo|individuo.esVillano)
		lista
	}

	def eliminarUnIntegrante(SuperIndividuo superIndividuo) {
		if(lider.id==superIndividuo.id && esOwner(superIndividuo.id)){
			owner=integrantes.get(0)
			cambiarLider(integrantes.get(0))
		}
		if(esOwner(superIndividuo.id)){
			owner=lider
		}
		if(lider.id==superIndividuo.id){
			cambiarLider(integrantes.get(0))
		}
		integrantes.removeIf(individuo|individuo.id == superIndividuo.id)
	}
	def cambiarLider(SuperIndividuo superIndividuo){
		lider=superIndividuo
		if(integrantes.exists(individuo|individuo==superIndividuo)){
			integrantes.remove(superIndividuo)
		}
	}
	def esParteDelEquipo(String individuoId){
		esOwner(individuoId) || esParteDeLosInegrantes(individuoId)
	}
	
	def esParteDeLosInegrantes(String individuoId) {
		todosLosIntegrantes.exists[pers|pers.id == individuoId]
	}
	
	def esOwner(String individuoId) {
		owner.id == individuoId
	}
	
}



