package edu.unsam.heroManager.restService

import edu.unsam.heroManager.AntiHeroe
import edu.unsam.heroManager.Equipo
import edu.unsam.heroManager.Heroe
import edu.unsam.heroManager.ItemSimple
import edu.unsam.heroManager.RepoEquipo
import edu.unsam.heroManager.RepoItem
import edu.unsam.heroManager.RepoSuperIndividuo
import edu.unsam.heroManager.SuperIndividuo
import edu.unsam.heroManager.Villano
import java.time.LocalDate
import org.uqbar.geodds.Point

class GenObjects {
	

	def static addToRepo() {
		val repoSI = RepoSuperIndividuo.instance
		val repoEQ = RepoEquipo.instance
		val repoI = RepoItem.instance

		val armadura = new ItemSimple() => [
			nombre = "Cota del malla"
			photoUrl="https://img.rankedboost.com/wp-content/uploads/2019/06/Chain-Vest-Teamfight-Tactics.png"
			alcance = 5.0
			danio = 5.0
			peso = 5.0
			resistencia = 5.0
			sobrenatural = false
			precio = 2.0
		]

		val collar = new ItemSimple() => [
			nombre = "Collar Divino"
			photoUrl="https://mi0.rightinthebox.com/images/384x384/201709/otgg1505459373981.jpg"
			alcance = 2.0
			danio = 2.0
			peso = 2.0
			resistencia = 2.0
			sobrenatural = false
			precio = 3.0
		]

		val espada = new ItemSimple() => [
			nombre = "Espada del olimpo"
			photoUrl="http://3.bp.blogspot.com/-Agr3OmE4ovs/UjpKacHgPtI/AAAAAAAAAFw/xtU7ZJiLlWQ/s1600/011.jpg"
			alcance = 5.0
			danio = 10.0
			peso = 7.0
			resistencia = 2.0
			sobrenatural = true
			precio = 5.0
		]
		val thanos = new SuperIndividuo => [
			nombre = "thanos"
			apellido = "avenger"
			email="thanos@individuo.com"
			photoUrl= "https://cdn.20m.es/img2/recortes/2019/04/29/940221-600-338.jpg"
			apodo = "Thanos"
			password="gemas"
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Villano.instance
			victorias = 12
			empates = 23
			derrotas = 1
			fuerza = 523
			dinero = 50.0
			resistencia = 7
		]

		val capi = new SuperIndividuo() => [
			agregarItem(armadura)
			photoUrl= "https://andro4all.com/files/2014/03/Capit%C3%A1n-Am%C3%A9rica2.jpg"
			email="cptAM@individuo.com"
			tipoDeIndividuo = Heroe.instance
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			nombre = "Steve"
			apellido = "Rogers"
			password="usa"
			apodo = "Capitan America"
			victorias = 5
			empates = 4
			derrotas = 2
			fuerza = 5
			dinero = 100.0
			resistencia = 7
		]

		val thor = new SuperIndividuo => [
			photoUrl= "https://cdn-3.expansion.mx/dims4/default/274fa6d/2147483647/strip/true/crop/800x450+0+0/resize/800x450!/quality/90/?url=https%3A%2F%2Fcdn-3.expansion.mx%2F1c%2Fc5%2Fd04cafc14d89a76ce66745368305%2Fthor-avengers-1.jpg"
			email="asgard@individuo.com"
			agregarItem(armadura)
			agregarItem(collar)
			agregarEnemigo(capi)
			nombre = "Dios"
			apellido = "Rayo"
			apodo = "Thor"
			password="martillo"
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

		val cersei = new SuperIndividuo => [
			email="????@individuo.com"
			photoUrl= "https://miro.medium.com/max/1200/1*gMm72vVrnwgreAa1HLjd_g.jpeg"
			agregarItem(collar)
			agregarEnemigo(capi)
			nombre = "Game"
			apellido = "Thrones"
			apodo = "Cersei"
			password="123"
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
		val batman = new SuperIndividuo => [
			photoUrl= "https://mauriciocalzada.files.wordpress.com/2012/09/17e918cbatmp.jpeg"
			email="gothamTrueHero@individuo.com"
			agregarItem(armadura)
			agregarEnemigo(capi)
			nombre = "Bruce "
			apellido = "Wayne"
			apodo = "Batman"
			password="muercielago"
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

		val hulk = new SuperIndividuo => [
			photoUrl= "http://depor.com/files/article_main/uploads/2019/08/05/5d4872dbbe5b2.jpeg"
			email="brucethegreenman@individuo.com"
			agregarItem(armadura)
			agregarItem(collar)
			agregarEnemigo(thanos)
			agregarAmigo(batman)
			agregarAmigo(thor)
			agregarAmigo(cersei)
			nombre = "Bruce"
			apellido = "Banner"
			apodo = "Hulk"
			password="verde"
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

		val Joker = new SuperIndividuo => [
			photoUrl= "https://i.ytimg.com/vi/ygUHhImN98w/maxresdefault.jpg"
			email="elbromas@individuo.com"
			agregarItem(collar)
			nombre = "Mago"
			apellido = "Loco"
			apodo = "Joker"
			password="elbromas"
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = AntiHeroe.instance
			victorias = 112
			empates = 22
			derrotas = 51
			fuerza = 435
			dinero = 50.0
			resistencia = 7
		]

		val madMax = new SuperIndividuo => [
			photoUrl= "https://static.iris.net.co/semana/upload/images/2015/5/16/427790_94657_1.jpg"
			email="reallymad@individuo.com"
			agregarItem(collar)
			nombre = "Mad"
			apellido = "Max"
			apodo = "MadMax"
			password="123"
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Heroe.instance
			victorias = 13
			empates = 22
			derrotas = 51
			fuerza = 125
			dinero = 50.0
			resistencia = 7
		]
		val ironMan = new SuperIndividuo => [
			photoUrl= "https://fsa.zobj.net/crop.php?r=kMI2AN7NEJKJl4hX0fljK9bFoNUR_HhkBX3xpvAwrnArPcmBhDbqm1-AP4qk5bn5KJyqVQ9-jb7yrWTTKwOCvXUTma6kCenyrAwWg7THpu_5knZUgw36g5kuiN5xb47_cvy0we92jAHTHN3GKi5b_kUUaApfkMwetfv480wfQ9YEKcPt0u7780SsNorT8UE_qWKDA-c2vEhmHr2i"
			email="supertony@individuo.com"
			agregarItem(armadura)
			agregarItem(espada)
			agregarItem(collar)
			agregarItem(armadura)
			agregarItem(espada)
			agregarItem(collar)
			nombre = "Tony"
			apellido = "Stark"
			apodo = "Iron Man"
			password="pepper"
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Heroe.instance
			victorias = 9999
			empates = 0
			derrotas = 1
			fuerza = 999
			dinero = 999999.9
			resistencia = 500
		]

		val spiderman = new SuperIndividuo => [
			photoUrl= "https://img.cinemablend.com/filter:scale/quill/2/4/5/d/b/8/245db82ddbc8a48260bffa80c0b1d004bd8dd6a6.jpg?mw=600"
			email="mj123@individuo.com"
			agregarItem(armadura)
			agregarItem(collar)
			nombre = "Peter"
			apellido = "Parker"
			apodo = "Spiderman"
			password="123"
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Heroe.instance
			victorias = 123
			empates = 2
			derrotas = 13
			fuerza = 523
			dinero = 50.0
			resistencia = 7
		]
		val pepper = new SuperIndividuo => [
			photoUrl= "https://i.ytimg.com/vi/taKQd3yWSno/hqdefault.jpg"
			email="gtfo@individuo.com"
			agregarItem(armadura)
			agregarItem(espada)
			agregarItem(collar)
			nombre = "Virgina"
			apellido = "Potts"
			apodo = "Pepper"
			password="123"
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Heroe.instance
			victorias = 1
			empates = 232
			derrotas = 532
			fuerza = 52
			dinero = 50.0
			resistencia = 7
		]
		val punisher = new SuperIndividuo => [
			photoUrl= "https://areajugones.sport.es/wp-content/uploads/2019/01/The-Punisher-4.jpg.webp"
			email="franco_castillo@individuo.com"
			agregarItem(armadura)
			agregarItem(espada)
			agregarItem(collar)
			nombre = "Frank"
			apellido = "Castle"
			apodo = "The Punisher"
			password="123"
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Heroe.instance
			victorias = 1321
			empates = 2
			derrotas = 0
			fuerza = 3543
			dinero = 5000.0
			resistencia = 7
		]
		val luke = new SuperIndividuo => [
			photoUrl= "https://dam.smashmexico.com.mx/wp-content/uploads/2018/06/25120020/lukecage_portada.jpg"
			email="lucas_celdas_reloco@individuo.com"
			agregarItem(espada)
			agregarItem(collar)
			nombre = "Lucas"
			apellido = "Cage"
			apodo = "Luke Cage"
			password="123"
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Heroe.instance
			victorias = 1324
			empates = 221
			derrotas = 35
			fuerza = 456
			dinero = 50.0
			resistencia = 7
		]
		val widow = new SuperIndividuo => [
			photoUrl= "https://img.ecartelera.com/noticias/fotos/50400/50444/1.jpg"
			email="espia_poco_secreta@individuo.com"
			agregarItem(espada)
			nombre = "Natasha"
			apellido = "Romanoff"
			apodo = "Black Window"
			password="123"
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Heroe.instance
			victorias = 164
			empates = 24
			derrotas = 15
			fuerza = 554
			dinero = 50.0
			resistencia = 7
		]
		val nickFuria = new SuperIndividuo => [
			photoUrl= "https://am24.akamaized.net/tms/cnt/uploads/2019/08/What-do-you-mean-Nick-Fury-wouldnt-have-worked-in-Endgame.jpg"
			email="nicky_furiosoa@individuo.com"
			agregarItem(espada)
			nombre = "Nicholas"
			apellido = "Fury"
			apodo = "Nick Fury"
			password="123"
			fechaInicio = LocalDate.of(2018, 3, 10)
			baseDeOps = new Point(7, 9)
			tipoDeIndividuo = Heroe.instance
			victorias = 164
			empates = 24
			derrotas = 15
			fuerza = 554
			dinero = 50.0
			resistencia = 7
		]

		val  losVengadores= new Equipo => [
			nombre = "Avengers & co"
			setLider(ironMan)
			agregarMiembro(thor)
			agregarMiembro(hulk)
			agregarMiembro(madMax)
			agregarMiembro(capi)
			agregarMiembro(spiderman)
			agregarMiembro(pepper)
			agregarMiembro(punisher)
			agregarMiembro(luke)
			agregarMiembro(widow)
			owner=nickFuria
		]
		val alianza = new Equipo => [
			nombre = "Los locos"
			agregarMiembro(batman)
			agregarMiembro(hulk)
			setLider(cersei)
			owner=madMax
		]

		repoSI => [
			create(cersei)
			create(hulk)
			create(capi)
			create(thor)
			create(batman)
			create(Joker)
			create(madMax)
			create(ironMan)
			create(spiderman)
			create(pepper)
			create(punisher)
			create(luke)
			create(thanos)
			create(widow)
			create(nickFuria)

		]

		repoEQ => [
			create(losVengadores)
			create(alianza)
		]

		repoI => [
			create(armadura)
			create(collar)
			create(espada)
		]

	}

}
