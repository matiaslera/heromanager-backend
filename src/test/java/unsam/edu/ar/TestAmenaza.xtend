package unsam.edu.ar

import edu.unsam.heroManager.Amenaza
import org.junit.Before
import edu.unsam.heroManager.Ataque
import edu.unsam.heroManager.SuperIndividuo
import edu.unsam.heroManager.Villano
import org.uqbar.geodds.Point
import java.time.LocalDate
import org.junit.Test
import org.junit.Assert
import edu.unsam.heroManager.DesastreNatural


class TestAmenaza {

	SuperIndividuo thanos

	Amenaza ataque
	DesastreNatural tornado

	@Before
	def void init() {
		thanos = new SuperIndividuo() => [
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
		
		ataque = new Ataque() => [
			ubicacion = new Point(2, 3)
			cantidadPersonasEnPeligro = 30
			agregarInvolucrado(thanos)
			agregarInvolucrado(thanos)
			agregarInvolucrado(thanos)
		]
		
		tornado = new DesastreNatural() => [
			ubicacion = new Point(2, 3)
			cantidadPersonasEnPeligro = 30
			superficieAfectada = 10.2
			potencia = 10.5

		]
	

	}
	
	@Test
	def void magnitudDeUnAtaque() {
		Assert.assertEquals(15, ataque.magnitud, 0.1)
		//PDA thanos = 5 * 3(cant de involucrados)
	}
	
	@Test
	def void nivelDeAmenazaAtaque(){
		Assert.assertEquals(15*30,ataque.nivelDeAmenaza,0.1)
	}
	@Test
	def void nivelDeAmenazaDesastreNatural(){
		Assert.assertEquals(3375,tornado.nivelDeAmenaza,0.1)
	}
}
