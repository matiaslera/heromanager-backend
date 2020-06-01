package edu.unsam.heroManager.Procesos

import edu.unsam.heroManager.RepoItem
import edu.unsam.heroManager.RepoSuperIndividuo
import edu.unsam.heroManager.RepoEquipo
import java.util.List

abstract class Proceso {
	protected RepoEquipo repoEq = RepoEquipo.instance
	protected RepoSuperIndividuo repoSi =  RepoSuperIndividuo.instance
	protected RepoItem repoI = RepoItem.instance

	def void doExecute()

}


class ProcesosDeAdministracion {
	List<Proceso> procesos = newArrayList

	def agregarOperaciones(Proceso proceso) {

		procesos.add(proceso)
	}

	def realizarOperaciones() {
		procesos.forEach [ intruccion |
			intruccion.doExecute()
		]
		procesos.clear
	}

}
