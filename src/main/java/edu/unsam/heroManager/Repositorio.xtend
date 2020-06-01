package edu.unsam.heroManager

import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional

interface Entidad {

	def String getId()

	def void setId(String id)

	def void validar()
}

abstract class Repositorio<T extends Entidad> {
	@Accessors protected Set<T> elementos = new HashSet<T>
	protected int ultimoId = 0

	def void create(T elementoNuevo) {
		// elementoNuevo.validar
		if (elementoNuevo.getId !== null && elementoNuevo.getId !== "") {
			elementos.add(elementoNuevo)
		} else {
			ultimoId++
			elementoNuevo.setId(getTipo + Integer.toString(ultimoId))
			if (this.searchById(elementoNuevo.getId) === null) {
				elementos.add(elementoNuevo)
			} else {
				this.create(elementoNuevo)
			}
		}
	}

	def void delete(T elemento) {
		elementos.remove(elemento)
	}

	def void update(T elementoNuevo) {
		//elementoNuevo.validar
		if(elementoNuevo.getId !== null)
			this.delete(searchById(elementoNuevo.getId))
		this.create(elementoNuevo)
	}

	def searchById(String id) {
		elementos.findFirst[it.id.contains(id)]
	}

	def String getTipo()

	def cantidadRegistrados() {
		elementos.size()
	}
}

@Transactional
@Observable
@Accessors
class RepoSuperIndividuo extends Repositorio<SuperIndividuo> {
	String tipo = "SI"

	private new() {
	}

	static RepoSuperIndividuo instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoSuperIndividuo()
		}
		instance
	}

	def search(String value) {
		elementos.filter[it.getNombre.contains(value) || it.getApellido.contains(value) || it.apodo.contains(value)]
	}

	def getSuperIndividuosTipoHeroe() {
		elementos.filter[individuo|individuo.esHeroe]
	}

	def defensorMasIndicado(Amenaza amenaza) {
		val listaIndividuosCandidatos = this.superIndividuosTipoHeroe.filter(
			si |
				si.chancesDeContrarrestarUnaAmenaza(amenaza) > 60
		)
		if (listaIndividuosCandidatos.empty) {
			this.superIndividuosTipoHeroe.sortBy[-it.chancesDeContrarrestarUnaAmenaza(amenaza)].head
		} else {
			listaIndividuosCandidatos.sortBy[it.costoDeCombatirUnaAmenaza(amenaza)].head

		}
	}

	def agregarAmigo(SuperIndividuo destino, SuperIndividuo amigoNuevo) {
		destino.agregarAmigo(searchById(amigoNuevo.id))
	}

	def agregarEnemigo(SuperIndividuo destino, SuperIndividuo enemigoNuevo) {
		destino.agregarEnemigo(searchById(enemigoNuevo.id))
	}

	def eliminarAmigo(SuperIndividuo destino, SuperIndividuo amigoEliminar) {
		destino.eliminarAmigo(searchById(amigoEliminar.id))
	}

	def eliminarEnemigo(SuperIndividuo destino, SuperIndividuo enemigoEliminar) {
		destino.eliminarEnemigo(searchById(enemigoEliminar.id))
	}

	def posiblesRelaciones(List<SuperIndividuo> relaciones, SuperIndividuo individuoEliminar) {
		val listaFiltrada = elementos.filter( a|true ).toList
		relaciones.forEach(individuo|listaFiltrada.removeIf(candElim|candElim.id == individuo.id))
		listaFiltrada.remove(searchById(individuoEliminar.id))
		listaFiltrada.toList
	}

	def elementosQueNoEstanEnLaLista(List<SuperIndividuo> individuos) {
		if(individuos.get(0)===null){ elementos}
		else{
		elementos.filter[a|!individuos.exists[b|a.id==b.id]].toList}//TODO reveer
	}

	def superIndividuoMasEfectivo() {
		elementos.sortBy[-efectividad].head
	}

	def porcentajeDeSeniors() {
		val cantidadIndividuosSenior = elementos.filter[individuo|individuo.esSenior].size()
		(100 * cantidadIndividuosSenior) / cantidadRegistrados
	}

	def searchUserByLoginData(SuperIndividuo loginData) {
		val userALogear = elementos.findFirst(si|si.apodo == loginData.apodo)
		if (userALogear === null) {
			throw new Exception("No existe ningun superindividuo con ese username")
		}
		if (userALogear.password != loginData.password) {
			throw new Exception("Password incorrecto")
		}
		userALogear
	}
	def elementosNoVillanos(){
		val lista=elementos.filter( a|true ).toList//genera copia
		lista.removeIf(individuo|individuo.esVillano)
		lista
	}
}

@Transactional
@Observable
@Accessors
class RepoItem extends Repositorio<Item> {
	String tipo = "I"

	private new() {
	}

	static RepoItem instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoItem()
		}
		instance
	}

	def search(String value) {
		elementos.filter[it.getNombre.contains(value) || it.getDescripcion.contains(value)]
	}

}

@Accessors
class RepoEquipo extends Repositorio<Equipo> {
	String tipo = "E"

	static RepoEquipo instance

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new RepoEquipo()
		}
		instance
	}
	
	def search(String value) {
		elementos.filter[it.getNombre.contains(value) || it.getIntegrantes.exists(si|si.getApodo.contains(value))]
	}
	
	def defensorMasIndicado(Amenaza amenaza) {
		val listaIndividuosCandidatos = getElementos.filter(si|si.chancesDeContrarrestarUnaAmenaza(amenaza) > 60)
		if (listaIndividuosCandidatos.empty) {
			this.getElementos.sortBy[-it.chancesDeContrarrestarUnaAmenaza(amenaza)].head
		} else {
			listaIndividuosCandidatos.sortBy[it.costoDeCombatirUnaAmenaza(amenaza)].head

		}
	}

	def porcentajeDeEquiposLLenos() {
		val equipollenos = elementos.filter[equipo|equipo.equipoEstaLleno].size()
		(100 * equipollenos) / cantidadRegistrados
	}

	def equipoMasPoderoso() {
		elementos.sortBy[-poderGrupal].head
	}
	
	def searchBySuperIndividuo(String individuo){
		elementos.filter[equipo|equipo.esParteDelEquipo(individuo)].toList
	}
}

class RepoAmenaza extends Repositorio<Amenaza> {
	@Accessors String tipo = "A"

	private new() {
	}

	static RepoAmenaza instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoAmenaza()
		}
		instance
	}
}
