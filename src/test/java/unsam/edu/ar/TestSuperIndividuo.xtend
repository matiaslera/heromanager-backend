package unsam.edu.ar
import edu.unsam.heroManager.SuperIndividuo
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import edu.unsam.heroManager.Heroe
import java.time.LocalDate
import org.uqbar.geodds.Point
import edu.unsam.heroManager.Ataque
import edu.unsam.heroManager.Villano
import edu.unsam.heroManager.AntiHeroe
import edu.unsam.heroManager.ItemSimple

class TestSuperIndividuo {

	SuperIndividuo superman
	SuperIndividuo thanos
	ItemSimple collar
	ItemSimple armadura
	ItemSimple espada
	Ataque ataque
	@Before def void init() {
		

		armadura = new ItemSimple() => [
			alcance = 5.0
			danio = 5.0
			peso = 5.0
			resistencia = 5.0
			sobrenatural = false
		]

		collar = new ItemSimple() => [
			alcance = 2.0
			danio = 2.0
			peso = 2.0
			resistencia = 2.0
			sobrenatural = false
		]	

		espada = new ItemSimple() => [
			alcance = 3.0
			danio = 5.0
			peso = 7.0
			resistencia = 2.0
			sobrenatural = false
		]

		thanos = new SuperIndividuo() => [
			agregarItem(espada)
			agregarItem(armadura)
			agregarItem(collar)
			nombre = "thanos"
			apellido = "avenger"
			apodo = "elMalo"
			victorias = 5
			empates = 4
			derrotas = 2
			fuerza = 5
			fechaInicio = LocalDate.of(2017, 1, 2)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Villano.instance
			dinero = 100.0
			resistencia = 7
		]
		
		superman = new SuperIndividuo() => [
			agregarItem(armadura)
			agregarItem(collar)
			agregarEnemigo(thanos)
			nombre = "Clark"
			apellido = "Kent"
			apodo = "SuperMan"
			victorias = 50
			empates = 35
			derrotas = 20
			fuerza = 5
			fechaInicio = LocalDate.of(2014, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo =  Heroe.instance
			dinero = 50.0
			resistencia = 7
		]
		
		ataque = new Ataque() => [
			ubicacion = new Point(2, 3)
			cantidadPersonasEnPeligro = 30
			agregarInvolucrado(thanos)
		]
		
	}
		
	@Test
	def void CantidadDeAniosActivo() { 
		Assert.assertEquals(5, superman.aniosActivos, 0.0) 
	}
	
	@Test
	def void experiencia() {
		Assert.assertEquals(48.75, superman.experiencia, 0.1)
	}

	@Test
	def void poderDeAtaque() {
		Assert.assertEquals(10.94, superman.poderDeAtaque, 0.1) 
	}

	@Test
	def void sumaVeintePorcItemsExeptoMasPoderoso() {
		Assert.assertEquals(0.44,superman.sumaVeintePorcItemsExeptoMasPoderoso(), 0.01)
	}

	@Test
	def void elPoderDeItemMasPoderoso() {
		Assert.assertEquals(5.5, superman.poderDeItemMasPoderoso, 0.01)
	}
	
	@Test
	def void esSenior() {
		Assert.assertTrue(superman.esSenior)
	}
	
	@Test
	def void noEsSenior() {
		Assert.assertFalse(thanos.esSenior)
	}
	
	@Test
	def void poderDeDefensa() {
		Assert.assertEquals(10.0, thanos.poderDeDefensa, 0.0) 
	}

	@Test
	def void tienepastaDeLider() {
		Assert.assertTrue(superman.tienePastaDeLider)
	}
	
	@Test 
	def void efectividadDeUnHeroeSenior(){
		Assert.assertEquals(106.708, superman.efectividad,0.1)
	}
	@Test 
	def void efectividadDeUnAntiHeroeConExperienciaMenCien(){
		superman.setTipoDeIndividuo(AntiHeroe.instance)
		Assert.assertEquals(65.59, superman.efectividad,0.1)
	}
	
	@Test 
	def void efectividadDeUnVillano(){
		superman.setTipoDeIndividuo(Villano.instance)
		Assert.assertEquals(32.38, superman.efectividad,0.1)
	}
	
	@Test
	def void chancesDeContrarrestarUnaAmenaza() {
		Assert.assertEquals(22.9, superman.chancesDeContrarrestarUnaAmenaza(ataque), 0.1)
	}

	@Test
	def void elCostoDeCombatirUnAtaqueParaSuperman(){
		Assert.assertEquals(13.76, superman.costoDeCombatirUnaAmenaza(ataque),0.1)// 5200 / 
	}
	@Test (expected=typeof(RuntimeException))
	def void supermanNoPuedeSerEnemigoDeSiMismo(){
		superman.agregarEnemigo(superman)
	}
	
}
