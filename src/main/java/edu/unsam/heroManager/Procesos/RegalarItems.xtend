package edu.unsam.heroManager.Procesos

import org.eclipse.xtend.lib.annotations.Accessors

import edu.unsam.heroManager.ItemSimple

@Accessors
class RegalarItems extends Proceso {
	int anoDeAntiguedadParaRecibirItem = 0
	ItemSimple item

	override doExecute() {
		val individuosQueRecibenRegalo = repoSi.elementos//.filter[it.aniosActivos >= anoDeAntiguedadParaRecibirItem]
		individuosQueRecibenRegalo.forEach[individuo|individuo.agregarItem(item)]
	}

}
