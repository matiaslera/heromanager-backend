package edu.unsam.heroManager.restService

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import edu.unsam.heroManager.RepoSuperIndividuo
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class PerfilCompletoController {
	extension JSONUtils = new JSONUtils
	RepoSuperIndividuo repoSuperIndividuo = RepoSuperIndividuo.getInstance

	@Get("/perfil_completo/:id")
	def Result login(@Body String body) {
		try {
			val superIndividuoCompleto = repoSuperIndividuo.searchById(id)
			ok(superIndividuoCompleto.toJson)
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
}
