package edu.unsam.heroManager

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import edu.unsam.heroManager.RepoItem
import edu.unsam.heroManager.RepoSuperIndividuo
import hero.manager.services.ItemsRestService
import java.lang.reflect.Type
import java.util.ArrayList
import java.util.Set
import hero.manager.services.AmigosRestService
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class JsonUpdate {
	var ItemsRestService itemRS = new ItemsRestService
	var AmigosRestService amigoRS = new AmigosRestService
	


	def updateRepoSuperIndividuo(RepoSuperIndividuo repoSI) {
		val Gson gson = new Gson()
		val Type listType = new TypeToken<ArrayList<SuperIndividuoJSO>>() {
		}.getType()
		val ArrayList<SuperIndividuoJSO> arrayDeJson = gson.fromJson(amigoRS.getAmistades, listType)
		arrayDeJson.forEach(elemJson|conversorJSOaSuperIndividuo(elemJson, repoSI))
	}

	def void conversorJSOaSuperIndividuo(SuperIndividuoJSO elementoNuevo,RepoSuperIndividuo repo)
	{
		val elementoConAmigosUpdateados = repo.searchById(elementoNuevo.getId())
		elementoConAmigosUpdateados.borrarAmigos
		elementoNuevo.getAmigos.forEach(elem|elementoConAmigosUpdateados.agregarAmigo(repo.searchById(elem)))
		repo.update(elementoConAmigosUpdateados)
	}
		

	def updateRepoItem(RepoItem repoI) {
		val Gson gson = new Gson()
		val Type listType = new TypeToken<ArrayList<ItemSimple>>() {
		}.getType()
		val ArrayList<ItemSimple> arrayDeJson = gson.fromJson(itemRS.getItems, listType)
		arrayDeJson.filter(elemJson|repoI.searchById(elemJson.getId) !== null).forEach(elemJson|repoI.update(elemJson))
		arrayDeJson.filter(elemJson|repoI.searchById(elemJson.getId) === null).forEach(elemJson|repoI.create(elemJson))
	}
	
	/* 
	def conversorJSOaItemCompuesto(ItemJSO elementoNuevo, RepoItem repo) {
		val elementoConConponentesUpdateados = repo.searchById(elementoNuevo.getId())
		elementoConConponentesUpdateados.items.clear
		elementoNuevo.componentes.forEach(elem|elementoConConponentesUpdateados.agregarItem(repo.searchById(elem)))
		repo.update(elementoConConponentesUpdateados)		
	}
	*/
}


class SuperIndividuoJSO {
	String id_individuo
	@Accessors Set<String> amigos = newHashSet

	def getId() {
		id_individuo
	}

}
class ItemJSO extends Item{
	String id_individuo
	@Accessors Set<String> componentes = newHashSet

	override getId() {
		id_individuo
	}
	
	override poderDeAtaque(){
		
	}
	
	override validar() {
	}
	


}
