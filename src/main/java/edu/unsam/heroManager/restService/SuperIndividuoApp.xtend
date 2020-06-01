package edu.unsam.heroManager.restService

import org.uqbar.xtrest.api.XTRest

class SuperIndividuoApp {
	
	def static void main(String[] args) {
		GenObjects.addToRepo
		XTRest.startInstance (16000,new LoginController(), 
			new RelacionesController(),
			new PerfilCompletoController(),
			new ItemsController(),
			new EquipoController()
		)
		
	}
}