package edu.unsam.heroManager.restService

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import edu.unsam.heroManager.RepoSuperIndividuo
import edu.unsam.heroManager.SuperIndividuo
import java.util.List
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class RelacionesController {

	extension JSONUtils = new JSONUtils
	RepoSuperIndividuo repoSuperIndividuo = RepoSuperIndividuo.getInstance
	
	@Get("/amigos/:id")
	def getAmigos() {
		jsonListaIndividuos(obtenerListaAmigos(), id)
	}

	@Get("/enemigos/:id")
	def Result getEnemigos() {
		jsonListaIndividuos(obtenerListaEnemigos(), id)
	}

	@Get("/amigos_no_agregados/:id")
	def getAmigosSinAgregar() {
		jsonListaIndividuos(obtenerListaNoAgregados(obtenerListaAmigos()), id)
	}

	@Get("/enemigos_no_agregados/:id")
	def Result getEnemigosSinAgregar() {
		jsonListaIndividuos(obtenerListaNoAgregados(obtenerListaEnemigos()), id)
	}

	@Put('/agregar_amigo/:id')
	def Result agregarAmigo(@Body String body) {
		aplicarCambio(agregarAmigo, id, body)
	}

	@Put('/agregar_enemigo/:id')
	def Result agregarEnemigo(@Body String body) {
		aplicarCambio(agregarEnemigo, id, body)
	}

	@Put('/eliminar_amigo/:id')
	def Result eliminarAmigo(@Body String body) {
		aplicarCambio(eliminarAmigo, id, body)
	}

	@Put('/eliminar_enemigo/:id')
	def Result eliminarEnemigo(@Body String body) {
		aplicarCambio(eliminarEnemigo, id, body)
	}

	// bloque para obtener la lista de amigos
	def obtenerListaAmigos() {
		[SuperIndividuo individuo|individuo.getAmigos]
	}

	// bloque para obtener la lista de amigos
	def obtenerListaEnemigos() {
		[SuperIndividuo individuo|individuo.getEnemigos]
	}

	// recible un bloque para obtener lista de amigos o enemigos
	// en base a eso obtiene la lista de individuos sin agregar
	def obtenerListaNoAgregados((SuperIndividuo)=>List<SuperIndividuo> aBlock) {
		[SuperIndividuo individuo|repoSuperIndividuo.posiblesRelaciones(aBlock.apply(individuo),individuo)]
	}

	def agregarAmigo() {
		[SuperIndividuo individuo, SuperIndividuo amigoNuevo|repoSuperIndividuo.agregarAmigo(individuo,amigoNuevo)]
	}

	def agregarEnemigo() {
		[SuperIndividuo individuo, SuperIndividuo enemigoNuevo|repoSuperIndividuo.agregarEnemigo(individuo,enemigoNuevo)]
	}

	def eliminarAmigo() {
		[SuperIndividuo individuo, SuperIndividuo amigoAEliminar|repoSuperIndividuo.eliminarAmigo(individuo,amigoAEliminar)]
	}

	def eliminarEnemigo() {
		[SuperIndividuo individuo, SuperIndividuo enemigoAEliminar|repoSuperIndividuo.eliminarEnemigo(individuo,enemigoAEliminar)]
	}

	def Result jsonListaIndividuos((SuperIndividuo)=>List<SuperIndividuo> aBlock, String id) {
		try {
			val individuo = repoSuperIndividuo.searchById(id)
			val listaAmigosIndividuos = aBlock.apply(individuo)
			if (listaAmigosIndividuos === null) {
				throw new Exception("No se encontro el Super Individuo")
			}
			ok(SuperIndividuoSerializer.toJson(listaAmigosIndividuos))
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	def Result aplicarCambio((SuperIndividuo, SuperIndividuo)=>boolean aBlock, String id, String individuo) {
		try {
			val individuoACambiarLista = repoSuperIndividuo.searchById(id)
			val individuoModificar = individuo.fromJson(SuperIndividuo)
			aBlock.apply(individuoACambiarLista, individuoModificar)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

}
