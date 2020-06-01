package edu.unsam.heroManager

interface Notificacion {
	def void notificar(SuperIndividuo individuo)

	public static int AMENAZADO = 0
}

class NotificacionDerrotas implements Notificacion {
	int limiteDerrotas

	override notificar(SuperIndividuo individuo) {
		if (individuo.getDerrotas > limiteDerrotas)
			individuo.enemigos.forEach( enemigo |
				enemigo.recibirMensaje(new Mensaje(individuo, "Supere el limite de derrotas"))
			)
	}

}

class NotificacionVictorias implements Notificacion {

	override notificar(SuperIndividuo individuo) {
		val amigosSuperadosEnVictorias = individuo.getAmigos.filter(amigo|amigo.getVictorias < individuo.getVictorias)
		amigosSuperadosEnVictorias.forEach(amigo|amigo.recibirMensaje(new Mensaje(individuo, "Te Supere en victorias")))
	}

}

class NotificacionCambioDeTipo implements Notificacion {
	val TipoDeIndividuo tipoOriginal
	val RepoEquipo todosLosEquipos

	new(TipoDeIndividuo _tipoOriginal, RepoEquipo _todosLosEquipos) {
		tipoOriginal =  _tipoOriginal
		todosLosEquipos = _todosLosEquipos
	}

	override notificar(SuperIndividuo individuo) {
		if (individuo.tipoDeIndividuo != tipoOriginal) {
			individuo.getAmigos.forEach(amigo|amigo.recibirMensaje(new Mensaje(individuo, "Cambio mi tipo")))
			val companierosDeEquipo = todosLosEquipos.search(individuo.getApodo).map[equipo|equipo.todosLosIntegrantes].flatten
			companierosDeEquipo.forEach(copañeroEquipo|copañeroEquipo.recibirMensaje(new Mensaje(individuo, "Cambio mi tipo")))
		}
	}
}

class Mensaje {
	SuperIndividuo from 
	String mensaje

	new(SuperIndividuo _from, String _mensaje) {
		from = _from
		mensaje = _mensaje
	}
	
	def getMensaje(){
		from.nombre + " "+mensaje
	}
}
