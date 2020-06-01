package edu.unsam.heroManager

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.geodds.Point

@Accessors
abstract class Amenaza implements Entidad{
	
	String Id
	val List<SuperIndividuo> involucrados = newArrayList
	int cantidadPersonasEnPeligro
	Point ubicacion

	def Double magnitud()

	def nivelDeAmenaza() {
		cantidadPersonasEnPeligro * this.magnitud
	}
	
	override validar() {
	}
}

@Accessors
class DesastreNatural extends Amenaza {

	Double superficieAfectada
	Double potencia
	
	override Double magnitud() { potencia + superficieAfectada * 10 }	

}

@Accessors
class Ataque extends Amenaza {

	def agregarInvolucrado(SuperIndividuo superIndividuo) {
		if (superIndividuo.esVillano) {
			involucrados.add(superIndividuo)
		}
	}

	override Double magnitud() {
		involucrados.fold(0.0, [total, involucrado|involucrado.poderDeAtaque + total])
	}

}
