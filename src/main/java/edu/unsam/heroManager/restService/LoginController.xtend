package edu.unsam.heroManager.restService

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import com.google.gson.Gson
import edu.unsam.heroManager.RepoSuperIndividuo
import edu.unsam.heroManager.SuperIndividuo
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Post

@Controller
@JsonAutoDetect(fieldVisibility = Visibility.ANY)

class LoginController {

	RepoSuperIndividuo repoSuperIndividuo = RepoSuperIndividuo.getInstance


	
	@Post("/login")
	def Result login(@Body String body) {
		try {
			val Gson gson = new Gson()
			val loginData = gson.fromJson(body,SuperIndividuo)
			val superIndividuoLogueado = repoSuperIndividuo.searchUserByLoginData(loginData)
			ok(SuperIndividuoSerializer.toJson(superIndividuoLogueado)) 
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
}
