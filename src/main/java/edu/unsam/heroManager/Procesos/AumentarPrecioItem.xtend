package edu.unsam.heroManager.Procesos

import edu.unsam.heroManager.Item
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class AumentarPrecioItem extends Proceso {

	Double porcentajeAumento

	override doExecute() {
		repoI.elementos.forEach(item|aumentarPrecio(item))
	}
	
	def aumentarPrecio(Item item) {
		item.precio=item.getPrecio*porcentajeAumento
	}

}
