package unsam.edu.ar

import org.junit.Before
import edu.unsam.heroManager.SuperIndividuo
import edu.unsam.heroManager.Mejora
import org.junit.Test
import org.junit.Assert
import edu.unsam.heroManager.ItemCompuesto
import edu.unsam.heroManager.ItemSimple

class TestItem {

	SuperIndividuo thor
	ItemSimple armadura
	ItemSimple collar
	Mejora mejoraArmadura
	Mejora mejoraCollar
	ItemCompuesto libro

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
		libro = new ItemCompuesto() =>[
			agregarItem(armadura)
			agregarItem(collar)
			alcance = 2.0
			danio = 2.0
			peso = 2.0
			resistencia = 2.0
		]
		

		mejoraArmadura = new Mejora() => [
			porcentajeDanio = 100.0
			porcentajeResis = 100.0
			porcentajeAlcance = 100.0
			precio = 50.0
		]
		mejoraCollar = new Mejora() => [
			porcentajeDanio = 100.0
			porcentajeResis = 100.0
			porcentajeAlcance = 100.0
			precio = 100.0
		]

		thor = new SuperIndividuo() => [
			agregarItem(armadura)
			agregarItem(collar)
			nombre = "Clark"
			apellido = "Kent"
			apodo = "SuperMan"
			victorias = 50
			empates = 35
			derrotas = 20
			fuerza = 5
			dinero = 100.0
			resistencia = 7
		]
	}

	@Test
	def void elSuperIndividuoCompraUnaMejoraDescuentaDinero() {
		thor.comprarMejora(mejoraArmadura)
		Assert.assertEquals(50, thor.dinero, 0.1)
	}

	@Test(expected=typeof(RuntimeException))
	def void elSuperIndividuoNoPuedeCompraUnaMejoraDineroInsuficiente() {
		thor.comprarMejora(mejoraCollar)
	}

	@Test
	def void elSuperIndividuoAplicaLaMejora() {
		thor.comprarMejora(mejoraArmadura)
		thor.aplicarMejora(armadura, mejoraArmadura)
		Assert.assertEquals(6.7, armadura.poderDeAtaque, 0.1)
	}

	@Test(expected=typeof(RuntimeException))
	def void elSuperIndividuoNoPuedeAplicaLaMejoraQueNoEstaComprada() {
		thor.aplicarMejora(armadura, mejoraArmadura)
	}

	@Test 
	def void elLibroTieneLaResistenciaArmadura(){
		Assert.assertEquals(5.0,libro.resistencia,0.1)
	}
	@Test 
	def void elPoderDeAtaqueDelLibro(){
		Assert.assertEquals(7.7,libro.poderDeAtaque,0.1)
	}
	

}
