package edu.unsam.heroManager

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional

interface TipoDeIndividuo {
	def Double efectividad(SuperIndividuo superIndividuo)
}

@Transactional
@Observable
@Accessors
class Heroe implements TipoDeIndividuo {
	String tipo="Heroe"
	
	override toString() {
      tipo
 	}	
	
	private new() {
	}

	static Heroe instance

	static def getInstance() {
		if (instance === null) {
			instance = new Heroe()
		}
		instance
	}

	override Double efectividad(SuperIndividuo superIndividuo) {
		var Double efectividadBase = (superIndividuo.poderDeAtaque + superIndividuo.poderDeDefensa) *
			(superIndividuo.experiencia / 10)
		if (superIndividuo.esSenior) {
			efectividadBase + (superIndividuo.poderDeAtaque * 0.2)
		} else {
			efectividadBase
		}
	}
}

@Transactional
@Observable
@Accessors
class AntiHeroe implements TipoDeIndividuo {
	String tipo="AntiHeroe"
	
	override toString() {
      	tipo
 	}
	
	private new() {
	}

	static AntiHeroe instance

	static def getInstance() {
		if (instance === null) {
		instance = new AntiHeroe()
		}
		instance
	}

	override Double efectividad(SuperIndividuo superIndividuo) {
		var Double efectividadBase = ((superIndividuo.poderDeAtaque * 1.5) + (superIndividuo.poderDeDefensa) ) *
			superIndividuo.experiencia / 20

		if (superIndividuo.experiencia > 100) {
			efectividadBase * 1.25
		} else {
			efectividadBase

		}
	}
	
	
	
	
}
@Transactional
@Observable
@Accessors
class Villano implements TipoDeIndividuo {
	String tipo="Villano"
	
	override toString() {
		tipo
 	}
	
	private new() {
	}

	static Villano instance

	static def getInstance() {
		if (instance === null) {
			instance = new Villano()
		}
		instance
	}

	override efectividad(SuperIndividuo superIndividuo) {
		(superIndividuo.poderDeAtaque * 2) + superIndividuo.poderDeDefensa
	}


}
 @Accessors
class Indefinido implements TipoDeIndividuo {
	String tipo="Indefinido"
	
	override toString() {
		tipo
 	}
	
	private new() {
	}

	static Indefinido instance

	static def getInstance() {
		if (instance === null) {
			instance = new Indefinido()
		}
		instance
	}

	override efectividad(SuperIndividuo superIndividuo) {
		0.0
	}
}
