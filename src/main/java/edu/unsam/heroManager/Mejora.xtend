package edu.unsam.heroManager

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Mejora {

	Double porcentajeDanio 
	Double porcentajeResis 
	Double porcentajeAlcance 
	Double precio


	def aplicar(ItemSimple item) {
		item.setAlcance (item.alcance *(porcentajeAlcance / 100) + 1)
		item.setDanio (item.danio*(porcentajeDanio / 100) + 1)
		item.setResistencia(item.resistencia * (porcentajeResis / 100) + 1)
	}

}
