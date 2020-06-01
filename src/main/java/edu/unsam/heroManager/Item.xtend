package edu.unsam.heroManager

import com.fasterxml.jackson.annotation.JsonProperty
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.exceptions.UserException

@Accessors
@TransactionalAndObservable
abstract class Item implements Entidad {

	String id
	String nombre 
	String descripcion 
	Double alcance
	Double danio
	Double peso
	Double resistencia
	Boolean sobrenatural
	Double precio
	String photoUrl

	def Double poderDeAtaque()
}
@TransactionalAndObservable
class ItemSimple extends Item {
	@JsonProperty("poderDeAtaque")
	override poderDeAtaque() {
		var poder = danio + (alcance * 0.2) - (peso * 0.1)
		if (sobrenatural) {
			poder * 1.5
		} else {
			poder
		}
	}

	override void validar() {
		if (nombre  === null) {
			throw new UserException("Debe ingresar nombre")
		}

		if (alcance === null) {
			throw new UserException("Debe ingresar un numero")
		}
		if (danio === null) {
			throw new UserException("Debe ingresar danio")
		}
		if (peso === null) {
			throw new UserException("Debe ingresar peso")
		}
		if (resistencia === null) {
			throw new UserException("Debe ingresar resistencia")
		}
		if (precio === null) {
			throw new UserException("Debe ingresar precio")
		}
	}

}
@TransactionalAndObservable
class ItemCompuesto extends ItemSimple {
	List<Item> items = newArrayList

	def sobrenatural() {
		items.exists([item|item.sobrenatural])
	}

	def agregarItem(ItemSimple _item) {
		items.add(_item)
	}

	override getResistencia() {
		(items.sortBy([-resistencia])).head.resistencia
	}

	override poderDeAtaque() {
		items.fold(0.0, [acu, item|acu + item.poderDeAtaque])
	}

}
