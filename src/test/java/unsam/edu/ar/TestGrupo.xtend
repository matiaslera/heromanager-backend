package unsam.edu.ar

import org.junit.Before
import edu.unsam.heroManager.SuperIndividuo
import org.junit.Test
import edu.unsam.heroManager.Villano
import edu.unsam.heroManager.Heroe
import org.junit.Assert
import java.time.LocalDate
import org.uqbar.geodds.Point
import edu.unsam.heroManager.AntiHeroe
import edu.unsam.heroManager.Amenaza
import edu.unsam.heroManager.Ataque
import edu.unsam.heroManager.DesastreNatural
import edu.unsam.heroManager.Equipo
import edu.unsam.heroManager.ItemSimple

class TestGrupo {

	SuperIndividuo thor
	SuperIndividuo thanos
	SuperIndividuo cersei
	SuperIndividuo batman
	SuperIndividuo hulk
	
	ItemSimple armadura
	ItemSimple collar
	ItemSimple espada

	Equipo alianza
	Equipo losVengadores

	Amenaza ataque
	DesastreNatural tornado
	
	@Before
	def void init() {
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
			alcance = 5.0
			danio = 10.0
			peso = 7.0
			resistencia = 2.0
			sobrenatural = false
		]
		thanos = new SuperIndividuo() => [
			id="SI1"
			agregarItem(espada)
			agregarItem(armadura)
			tipoDeIndividuo = Villano.instance
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			nombre = "thanos"
			apellido = "avenger"
			apodo = "elMalo"
			victorias = 5
			empates = 4
			derrotas = 2
			fuerza = 5
			dinero = 100.0
			resistencia = 7
		]
		thor = new SuperIndividuo => [
			id="SI2"
			agregarItem(armadura)
			agregarItem(collar)
			agregarEnemigo(thanos)
			nombre = "Clark"
			apellido = "Kent"
			apodo = "SuperMan"
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Heroe.instance
			victorias = 1
			empates = 2
			derrotas = 5
			fuerza = 5
			dinero = 50.0
			resistencia = 7
		]

		cersei = new SuperIndividuo => [
			agregarItem(armadura)
			agregarItem(collar)
			agregarEnemigo(thanos)
			nombre = "Clark"
			apellido = "Kent"
			apodo = "SuperMan"
			fechaInicio = LocalDate.of(2000, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = AntiHeroe.instance
			victorias = 100
			empates = 20
			derrotas = 20
			fuerza = 5
			dinero = 50.0
			resistencia = 7
		]
		batman = new SuperIndividuo => [
			agregarItem(armadura)
			agregarItem(collar)
			agregarEnemigo(thanos)
			nombre = "Bruno "
			apellido = "Diaz"
			apodo = "Batman"
			fechaInicio = LocalDate.of(2000, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Heroe.instance
			victorias = 100
			empates = 20
			derrotas = 20
			fuerza = 5
			dinero = 1000.0
			resistencia = 1
		]
		hulk = new SuperIndividuo => [
			agregarItem(armadura)
			agregarItem(collar)
			agregarEnemigo(thanos)
			agregarAmigo(batman)
			agregarAmigo(thor)
			agregarAmigo(cersei)
			nombre = "Hombre"
			apellido = "Verde"
			apodo = "Hulk"
			fechaInicio = LocalDate.of(2000, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Heroe.instance
			victorias = 100
			empates = 20
			derrotas = 20
			fuerza = 5000
			dinero = 5.0
			resistencia = 10
		]		

		alianza = new Equipo => [
			owner=hulk
			agregarMiembro(thor)
			setLider(cersei)

		]
		losVengadores = new Equipo => [
			agregarMiembro(batman)
			agregarMiembro(hulk)
			setLider(cersei)
			
		]
		ataque = new Ataque() => [
			ubicacion = new Point(2, 3)
			cantidadPersonasEnPeligro = 30
			agregarInvolucrado(thanos)
		]
		
		tornado = new DesastreNatural() => [
			ubicacion = new Point(2, 3)
			cantidadPersonasEnPeligro = 30
			superficieAfectada = 10.1
			

		]

	}


	def void elVillanoNoPuedeSerAgregadoAlGrupo() {
		alianza.agregarMiembro(thanos)
	}
	
	@Test
	def void poderDelGrupoConPastaDeLider() {

		Assert.assertEquals(118.492, alianza.poderGrupal, 0.1)
	// 113.022 + 0.5 * 10.94
	}
	
	@Test 
	def void CantidadDeEnemigosInvolucrados(){
		Assert.assertEquals(2, alianza.cantidadEnemigosInvolucrados(ataque), 0.1)
	}
	
	@Test 
	def void chancesDeCombatirUnaAmenaza(){
		Assert.assertEquals(19.4, alianza.chancesDeContrarrestarUnaAmenaza(ataque), 0.1)
	}
	@Test 
	def void costoDeCombatirUnaAmenaza(){
		Assert.assertEquals(1182.24, alianza.costoDeCombatirUnaAmenaza(ataque), 0.1)
	}
	
	@Test
	def void costoDeCombatirUnaAmenazaDesastreNatural(){
		Assert.assertEquals(985.2, alianza.costoDeCombatirUnaAmenaza(tornado), 0.1)
	}
	@Test 
	def void cantidadDeAmigosTotalDeVengadores(){
		Assert.assertEquals(2,losVengadores.amistadEnElEquip(),0.0)	
	}
	@Test
	def void poderDelGrupoDeVengadores() {

		Assert.assertEquals(118.492, alianza.poderGrupal, 0.1)
	// 113.022 + 0.5 * 10.94
	}
	@Test
	def void poderDeslGrupoDeVengadores() {
		Assert.assertTrue(alianza.esParteDelEquipo(thor.id))
	}
}
