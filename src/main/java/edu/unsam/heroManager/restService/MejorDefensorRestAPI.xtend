package edu.unsam.heroManager.restService

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import edu.unsam.heroManager.Amenaza
import edu.unsam.heroManager.RepoAmenaza
import edu.unsam.heroManager.RepoEquipo
import edu.unsam.heroManager.RepoSuperIndividuo
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
@Controller
@JsonAutoDetect(fieldVisibility = Visibility.ANY)
class MejorDefensorRestAPI {
	

	extension JSONUtils = new JSONUtils
	RepoAmenaza amenaza
	RepoSuperIndividuo repoSI
	RepoEquipo repoEquipo

	new(RepoAmenaza amenaza, RepoSuperIndividuo repoSuperIndividuo, RepoEquipo repoEquipo) {
		this.amenaza = amenaza
		this.repoSI = repoSuperIndividuo
		this.repoEquipo = repoEquipo
	}

	@Get("/amenaza/:id/mejor_defensor")
	
	def getMejorDefensor() {
			var amenazaBuscada = amenaza.searchById(id)
			if (amenazaBuscada === null) {
				return notFound(getErrorJson("No existe una Amenaza con el Id " + id))
			} else {
				if(defensorMasIndicado(amenazaBuscada)===null)
					return notFound (getErrorJson("No hay nadie que pueda combatir la amenaza"))
				return ok(defensorMasIndicado(amenazaBuscada).toJson)
			}
	}

	private def getErrorJson(String message) {
		'{ "error": "' + message + '" }'
	}

	def defensorMasIndicado(Amenaza amenaza) {
		val mejorHeroe = repoSI.defensorMasIndicado(amenaza)
		val mejorEquipo = repoEquipo.defensorMasIndicado(amenaza)
		if (mejorHeroe.chancesDeContrarrestarUnaAmenaza(amenaza) > mejorEquipo.chancesDeContrarrestarUnaAmenaza(amenaza)) {
			mejorHeroe
		} else {
			mejorEquipo
		}
	}

}
