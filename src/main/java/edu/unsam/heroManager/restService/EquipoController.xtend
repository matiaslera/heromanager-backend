package edu.unsam.heroManager.restService

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import edu.unsam.heroManager.Equipo
import edu.unsam.heroManager.RepoEquipo
import edu.unsam.heroManager.RepoSuperIndividuo
import edu.unsam.heroManager.SuperIndividuo
import java.util.List
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class EquipoController {
	extension JSONUtils = new JSONUtils
	RepoSuperIndividuo repoSuperIndividuo = RepoSuperIndividuo.getInstance
	RepoEquipo repoEquipo = RepoEquipo.getInstance

	@Get("/equipos/:id")
	def Result todosLosEquipos() {
		try {
			val equipos = repoEquipo.searchBySuperIndividuo(id)
			ok(EquipoSerializer.toJson(equipos))
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Get("/equipo_completo/:id")
	def Result equipoCompleto() {
		try {
			if(id=="null"){
				return ok(new Equipo().toJson)
			}
			val equipo = repoEquipo.searchById(id)
			ok(equipo.toJson)
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Put("/crear_equipo")
	def Result crearEquipo(@Body String body) {
		altaUpdateEquipo(altaEquipo, body)
	}

	@Put("/actualizar_equipo")
	def Result actualizarEquipo(@Body String body) {
		altaUpdateEquipo(modificacionEquipo, body)
	}

	@Delete("/eliminar_equipo/:id")
	def Result eliminarEquipo() {
		try {
			val equipo = repoEquipo.searchById(id)
			repoEquipo.delete(equipo)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Delete("/abandonar_equipo/:idEquipo/:idIndividuo")
	def Result abandonarEquipo() {
		aplicarCambio(abandonarEquipo, idEquipo, idIndividuo)
	}

	def abandonarEquipo() {
		[Equipo equipo, SuperIndividuo individuo|equipo.eliminarUnIntegrante(individuo)]
	}

	def modificacionEquipo() {
		[Equipo equipo|repoEquipo.update(equipo)]
	}

	def altaEquipo() {
		[Equipo equipo|repoEquipo.create(equipo)]
	}

	def altaUpdateEquipo((Equipo)=>void aBlock, String body) {
		try {
			val equipo = body.fromJson(Equipo)
			aBlock.apply(equipo)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	def Result jsonListaIndividuos((Equipo)=>List<SuperIndividuo> aBlock, String id) {
		try {
			val equipo = repoEquipo.searchById(id)
			val listaIntegrantes = aBlock.apply(equipo)
			if (listaIntegrantes === null) {
				throw new Exception("No se encontro el Equipo")
			}
			return ok(SuperIndividuoSerializer.toJson(listaIntegrantes))

		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	def Result aplicarCambio((Equipo, SuperIndividuo)=>boolean aBlock, String idEquipo, String idIndividuo) {
		try {
			val equipoAModificar = repoEquipo.searchById(idEquipo)
			val integranteAModificar = repoSuperIndividuo.searchById(idIndividuo)
			aBlock.apply(equipoAModificar, integranteAModificar)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
}
