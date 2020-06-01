package edu.unsam.heroManager.Procesos

import edu.unsam.heroManager.Equipo

class EliminarVillanosDeEquipo extends Proceso {

	override doExecute() {
			repoEq.elementos.forEach[removerVillanosDeEqiupo(it)]

	}
	def removerVillanosDeEqiupo(Equipo equipo) {
		val integrantesAEliminar = equipo.integrantes.filter(individuo|individuo.esVillano())
		equipo.integrantes.removeAll(integrantesAEliminar)
	}
	
	
}