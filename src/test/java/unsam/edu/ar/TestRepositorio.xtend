package unsam.edu.ar

import edu.unsam.heroManager.AntiHeroe
import edu.unsam.heroManager.Equipo
import edu.unsam.heroManager.ItemSimple
import edu.unsam.heroManager.JsonUpdate
import edu.unsam.heroManager.RepoEquipo
import edu.unsam.heroManager.RepoItem
import edu.unsam.heroManager.RepoSuperIndividuo
import edu.unsam.heroManager.SuperIndividuo
import hero.manager.services.AmigosRestService
import hero.manager.services.ItemsRestService
import java.lang.reflect.Field
import java.time.LocalDate
import org.junit.Assert
import org.junit.Before
import org.junit.Test

import static org.mockito.Mockito.*

class TestRepositorio {
	ItemSimple armadura
	ItemSimple armadura2
	SuperIndividuo thanos
	SuperIndividuo SI5
	SuperIndividuo SI7
	Equipo alianza
	RepoEquipo repoE = RepoEquipo.getInstance
	RepoItem repoI = RepoItem.getInstance
	RepoSuperIndividuo repoSI = RepoSuperIndividuo.getInstance
	JsonUpdate updater

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
			precio=12.5
		]
		armadura2 = new ItemSimple() => [
			descripcion = "una armadura potente"
			alcance = 2.0
			danio = 2.0
			peso = 2.0
			resistencia = 2.0
			sobrenatural = false
			precio=12.5
		]

		thanos = new SuperIndividuo() => [
			agregarItem(armadura)
			nombre = "thanos"
			apellido = "avenger"
			apodo = "elMalo"
			victorias = 5
			empates = 4
			derrotas = 2
			fuerza = 5
			fechaInicio = LocalDate.of(2017, 1, 2)
			tipoDeIndividuo = AntiHeroe.instance
			dinero = 100.0
			resistencia = 7
		]
		alianza = new Equipo => [
			nombre = "alianza"
			agregarMiembro(thanos)

		]
		SI5 = new SuperIndividuo => [
			id = "SI5"
			nombre = "thanos"
			apellido = "avenger"
			apodo = "elMalo1"
		]
		SI7 = new SuperIndividuo => [
			id = "SI7"
			nombre = "thanos"
			apellido = "avenger"
			apodo = "elMalo2"
		]
		updater = new JsonUpdate => [
			itemRS = mockedRSItems
			amigoRS = mockedRSSuperI
		]
		
		//RESETEA EL REPO SINGLETON PARA QUE NO ROMPAN LOS TEST 
		var Field instance = repoI.class.getDeclaredField("instance");
		instance.setAccessible(true);
		instance.set(null, null);
		instance = repoSI.class.getDeclaredField("instance");
		instance.setAccessible(true);
		instance.set(null, null);
		instance = repoE.class.getDeclaredField("instance");
		instance.setAccessible(true);
		instance.set(null, null);

	}

	@Test
	def void busquedaPorId() {
		armadura.setId("I99")
		repoI.elementos.add(armadura)
		Assert.assertEquals("I99", repoI.searchById("I99").getId)
	}

	@Test
	def void seAgregaElElementoAlRepositorio() {
		repoI.create(armadura)
		Assert.assertEquals(1, repoI.getElementos.size, 0.0)
	}

	@Test
	def void seEliminaElElementoDelRepositorio() {
		repoI.create(armadura)
		repoI.delete(armadura)
		Assert.assertEquals(0, repoI.getElementos.size, 0.0)
	}

	@Test
	def void buscarElementoEnRepoDeSuperIndividuos() {
		repoSI.elementos.clear
		repoSI.create(thanos)
		Assert.assertEquals(1, repoSI.search("tha").size, 0.0)
	}

	@Test
	def void buscarElementoEnRepoDeEquipo() {
		repoE.create(alianza)
		Assert.assertEquals(1, repoE.search("elMalo").size, 0.1)
	}
	
	@Test
	def void calculaLosSISinEquipo() {
		repoSI = RepoSuperIndividuo.getInstance
		repoSI.create(thanos)
		repoSI.create(SI5)
		repoSI.create(SI7)
		repoE.create(alianza)
		alianza.setLider(SI5)
		Assert.assertEquals(1, alianza.superIndividuosQuePudenPertenecerAlEquipo().size())
	}

	@Test
	def void buscarElementoEnRepoDeItems() {
		repoI.create(armadura)
		Assert.assertEquals(1, repoI.search("una armadu").size, 0.1)
	}

	@Test
	def void seActualizaUnElemento() {
		repoI.create(armadura)
		armadura2.setNombre("nuevoNombre")
		armadura2.id = armadura.id
		repoI.update(armadura2)
		Assert.assertEquals("nuevoNombre", repoI.searchById("1").getNombre)
		repoI.elementos.clear
	}

	@Test
	def void actualizaItemConJson() {
		repoI.create(armadura)
		updater.updateRepoItem(repoI)
		Assert.assertEquals(50, repoI.searchById("1").getDanio(), 0.1)
	}

	@Test
	def void actualizaSuperIndividuoConJson() {
		repoSI.create(thanos)
		repoSI.create(SI5)
		repoSI.create(SI7)
		updater.updateRepoSuperIndividuo(repoSI)
		val SuperIndividuo thanosRepo = repoSI.searchById("SI1")
		Assert.assertEquals(2, thanosRepo.getAmigos.size, 0.0)
	}

	def mockedRSItems() {
		var String json = '[{"id":"I1","nombre":"Batarang","alcance":100,"peso":1,"danio":50,"resistencia":0,"precio":800,"sobrenatural":false}]'
		val itemRStemp = mock(ItemsRestService)
		when(itemRStemp.getItems).thenReturn(json)
		itemRStemp 
	}

	def mockedRSSuperI() {
		var String json = '[{"id_individuo":"SI1","amigos":["SI5","SI7"]}]'
		val itemRStemp = mock(AmigosRestService)
		when(itemRStemp.getAmistades).thenReturn(json)
		itemRStemp
	}

}
