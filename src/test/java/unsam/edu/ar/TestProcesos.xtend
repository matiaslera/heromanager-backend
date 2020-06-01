package unsam.edu.ar

import org.junit.Before
import edu.unsam.heroManager.ItemSimple
import edu.unsam.heroManager.SuperIndividuo
import java.time.LocalDate
import edu.unsam.heroManager.AntiHeroe
import edu.unsam.heroManager.RepoEquipo
import edu.unsam.heroManager.RepoItem
import edu.unsam.heroManager.RepoSuperIndividuo
import org.junit.Test
import org.junit.Assert

import edu.unsam.heroManager.Procesos.RegalarItems
import edu.unsam.heroManager.Equipo
import edu.unsam.heroManager.Villano
import edu.unsam.heroManager.Procesos.ProcesosDeAdministracion
import edu.unsam.heroManager.Procesos.EliminarVillanosDeEquipo
import edu.unsam.heroManager.Procesos.AumentarPrecioItem

class TestProcesos {
	ItemSimple armadura
	SuperIndividuo thanos
	RepoEquipo repoE
	RepoItem repoIT
	RepoSuperIndividuo repoSI
	RegalarItems regalo
	ProcesosDeAdministracion instruccion = new ProcesosDeAdministracion()
	Equipo losVengadores
	EliminarVillanosDeEquipo eliminarVillano
	AumentarPrecioItem tarifazo
	@Before
	def void init() {
		armadura = new ItemSimple() => [
			nombre = "armor"
			descripcion = "una armadura potente"
			alcance = 2.0
			danio = 2.0
			peso = 2.0
			resistencia = 2.0
			sobrenatural = false
			precio = 100.0
		]

		thanos = new SuperIndividuo() => [
			nombre = "thanos"
			apellido = "avenger"
			apodo = "elMalo"
			victorias = 5
			empates = 4
			derrotas = 2
			fuerza = 5
			fechaInicio = LocalDate.of(1888, 1, 2)
			tipoDeIndividuo = AntiHeroe.instance
			dinero = 100.0
			resistencia = 7
		]

		regalo = new RegalarItems() => [
			repoE = RepoEquipo.instance
			repoIT = RepoItem.instance
			repoSI = RepoSuperIndividuo.instance
			anoDeAntiguedadParaRecibirItem = 2
			item = armadura
		]
		
		losVengadores = new Equipo => [
			nombre="lv"
			agregarMiembro(thanos)
		]
		eliminarVillano = new EliminarVillanosDeEquipo => [
			repoE = RepoEquipo.instance
			repoIT = RepoItem.instance
			repoSI = RepoSuperIndividuo.instance	
		]
		tarifazo = new AumentarPrecioItem=>[
			repoE = RepoEquipo.instance
			repoIT = RepoItem.instance
			repoSI = RepoSuperIndividuo.instance
			porcentajeAumento = 1.1
		]
		
		
	}

	@Test
	def void regalarArmaduraItemASuperIndividuo() {
		repoIT.create(armadura)
		repoSI.create(thanos)
		instruccion.agregarOperaciones(regalo)
		instruccion.realizarOperaciones()
		Assert.assertEquals(1,thanos.getItems.size,0.0)
	}
	
	@Test 
	def void eliminarVillanoDelEquipo(){
		repoE.create(losVengadores)
		thanos.tipoDeIndividuo = Villano.instance
		instruccion.agregarOperaciones(eliminarVillano)
		instruccion.realizarOperaciones()
		Assert.assertEquals(0, losVengadores.integrantes.size())
	}
	@Test
	def void incrementarPrecioDeItemEnPorcentaje() {
		repoIT.create(armadura)
		instruccion.agregarOperaciones(tarifazo)
		instruccion.realizarOperaciones()
		Assert.assertEquals(110,armadura.precio,0.1)
	}
}
