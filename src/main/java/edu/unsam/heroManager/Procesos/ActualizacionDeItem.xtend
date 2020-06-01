package edu.unsam.heroManager.Procesos

import edu.unsam.heroManager.JsonUpdate
import edu.unsam.heroManager.RepoItem

class ActualizacionDeItem extends Proceso {
	JsonUpdate parserJson = new JsonUpdate


	override doExecute() {
		parserJson.updateRepoItem(RepoItem.instance)
	}
}