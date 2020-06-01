package edu.unsam.heroManager.restService

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import edu.unsam.heroManager.RepoItem
import edu.unsam.heroManager.RepoSuperIndividuo
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils

@Controller
@JsonAutoDetect(fieldVisibility = Visibility.ANY)
class ItemsController {
	extension JSONUtils = new JSONUtils
	RepoSuperIndividuo repoSuperIndividuo = RepoSuperIndividuo.getInstance
	RepoItem repoItem = RepoItem.getInstance

	
	@Get("/obtener_items/:id")
	def Result todosLosItems() {
		try {
			val superIndividuo = repoSuperIndividuo.searchById(id)
			ok(ItemSerializer.toJson(superIndividuo.getItems)) 
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
	
	@Get("/obtener_item_completo/:id")
	def Result unItemCompleto() {
		try {
			val item = repoItem.searchById(id)
			ok(item.toJson) 
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
}
