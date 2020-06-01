package edu.unsam.heroManager

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDate
import java.time.temporal.ChronoUnit
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import java.util.HashSet
import java.util.ArrayList
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import org.uqbar.commons.model.exceptions.UserException
import com.fasterxml.jackson.annotation.JsonProperty

@Observable
@Accessors
@Transactional
class SuperIndividuo implements Entidad {

	String id
	String nombre
	String apellido
	String apodo
	String photoUrl
	String email
	@JsonIgnore String password
	int victorias
	int empates
	int derrotas
	int fuerza = 0
	int resistencia
	@JsonIgnore Double dinero = 0.0
	@JsonIgnore Set<SuperIndividuo> enemigos = new HashSet<SuperIndividuo>
	@JsonIgnore List<Item> items = new ArrayList<Item>
	@JsonIgnore List<Mejora> mejoras = new ArrayList<Mejora>
	@JsonIgnore Set<SuperIndividuo> amigos = new HashSet<SuperIndividuo>
	@JsonIgnore Point baseDeOps
	@JsonIgnore LocalDate fechaInicio
	@JsonIgnore TipoDeIndividuo tipoDeIndividuo = Indefinido.getInstance
	@JsonIgnore List<Notificacion> notificaciones = new ArrayList<Notificacion>
	@JsonIgnore List<Mensaje> mensajes = new ArrayList<Mensaje>

	override validar() {
		if (nombre === null) {
			throw new UserException("Debe ingresar nombre")
		}
		if (apellido === null) {
			throw new UserException("Debe ingresar apellido del superIndiviudo")
		}
		if (apodo === null) {
			throw new UserException("Debe ingresar apodo del superIndividuo")
		}
	}

	override toString() {
		apodo
	}

	def aniosActivos() {
		if (fechaInicio===null){
			return 0
		}
		(ChronoUnit.DAYS.between(fechaInicio, LocalDate.now) / 365).intValue()
	}
	@JsonProperty("experiencia")
	def experiencia() {
		var double empates = this.empates			
		var double derrotasyDerrotas = this.derrotas + this.victorias
		this.aniosActivos + derrotasyDerrotas / 2 + empates / 4
	}
	@JsonProperty("poderDeAtaque")
	def Double poderDeAtaque() {
		this.fuerza + this.poderDeItemMasPoderoso + this.sumaVeintePorcItemsExeptoMasPoderoso()
	}
	@JsonProperty("tipo")
	def tipoDeIndividuoString() {
		tipoDeIndividuo.toString
	}

	def Double poderDeItemMasPoderoso() {
		if (items.empty) {
			0.0
		} else {
			this.itemsOrdenadosDeMasPoderosoAMenor.head().poderDeAtaque
		}
	}

	def itemsOrdenadosDeMasPoderosoAMenor() {
		items.sortBy[-poderDeAtaque]
	}

	def Double sumaVeintePorcItemsExeptoMasPoderoso() {
		this.itemsOrdenadosDeMasPoderosoAMenor.tail().fold(0.0, [total, item|item.poderDeAtaque + total]) * 0.2
	}

	def agregarItem(Item nuevoItem) {
		items.add(nuevoItem)

	}
	@JsonProperty("efectividad")
	def Double efectividad() {
		if (items.empty) {
			0.0
		} else {

			tipoDeIndividuo.efectividad(this)
		}
	}

	def Double poderDeDefensa() {
		resistencia + (items.fold(0.0, [total, item|item.resistencia + total])) / items.size()
	}

	def boolean esSenior() {
		(this.aniosActivos >= 5 && (this.totalDeBatallas) > 100) || this.experiencia > 50
	}

	def totalDeBatallas() {
		victorias + derrotas + empates
	}

	def boolean tienePastaDeLider() {
		this.esSenior && (victorias - derrotas / this.totalDeBatallas) >= 0.1
	}

	def Double chancesDeContrarrestarUnaAmenaza(Amenaza amenaza) {
		(this.efectividad / (this.efectividad + amenaza.nivelDeAmenaza)) * 100
	}

	def comprarMejora(Mejora mejora) {
		if ((dinero >= 0) && (dinero <= mejora.precio))
			throw new RuntimeException("Dinero insuficiente para compar la mejora")
		mejoras.add(mejora)
		dinero = dinero - mejora.precio
	}

	def aplicarMejora(ItemSimple item, Mejora mejora) {
		if (!mejoras.contains(mejora))
			throw new RuntimeException("La mejora no esta comprada")
		mejora.aplicar(item)
		mejoras.remove(item)
	}

	def costoDeCombatirUnaAmenaza(Amenaza amenaza) {
		var Double costoBase = (amenaza.nivelDeAmenaza + baseDeOps.distance(amenaza.ubicacion)) / this.efectividad
		if (cantidadDeEnemigosEnUnAtaque(amenaza) == 0) {
			costoBase
		} else {
			costoBase * 1.2
		}
	}

	def agregarEnemigo(SuperIndividuo enemigo) {
		if (enemigo== this){throw new RuntimeException("No puede ser enemigo de si mismo")}
		enemigos.add(enemigo)
	}

	def cantidadDeEnemigosEnUnAtaque(Amenaza amenaza) {
		if (enemigos.empty) {
			0
		} else {
			enemigos.filter[amenaza.involucrados.contains(it)].size
		}
	}

	def esVillano() {
		tipoDeIndividuo instanceof Villano
	}

	def esHeroe() {
		tipoDeIndividuo instanceof Heroe
	}

	def agregarAmigo(SuperIndividuo amigo) {
		amigos.add(amigo)
	}

	def esMiAmigo(SuperIndividuo amigo) {
		amigos.contains(amigo)
	}

	def verdaderosAmigos(SuperIndividuo individuo) {
		(this.esMiAmigo(individuo) && individuo.esMiAmigo(this))
	}

	def borrarAmigos() {
		amigos.clear
	}

	def setTipoDeIndividuo(TipoDeIndividuo tipoNuevo) {
		tipoDeIndividuo = tipoNuevo
		notificar
	}

	def agregarDerrota() {
		derrotas += 1
		notificar
	}

	def agregarVictoria() {
		victorias += 1
		notificar
	}

	def notificar() {
		notificaciones.forEach(notificacion|notificacion.notificar(this))
	}

	def recibirMensaje(Mensaje msg) {
		mensajes.add(msg)
	}

	def balanceRatio() {
		Math.abs(poderDeDefensa - poderDeAtaque)
	}
	def getAmigos(){
		amigos.toList
	}
	def getEnemigos(){
		enemigos.toList
	}
	
	def eliminarEnemigo(SuperIndividuo enemigoAEliminar) {
		enemigos.removeIf(a|a.id == enemigoAEliminar.id )
	}
	
	def eliminarAmigo(SuperIndividuo amigoAEliminar) {
		amigos.removeIf(a|a.id == amigoAEliminar.id )
	}
	
}
