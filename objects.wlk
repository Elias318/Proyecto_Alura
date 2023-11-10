class UserException inherits Exception { }

class Plato{
	var property azucar 
	var property calorias = 100 + 3* azucar
	
}
class PlatoPresentado{
	var plato
	var creador
	method creador() = creador
	method plato() = plato
}


class Entrada inherits Plato(azucar = 0){
	method esBonito() = true
}

class Principal inherits Plato{
	var esBonito
	method esBonito() = esBonito
}

class Postre inherits Plato(azucar = 120){
	var colores 
	method esBonito() = colores > 3
}


class Cocinero{
	var property especialidad 
	 
	method catar(plato) = especialidad.catar(plato)
	method cambiarEspecialidad() = especialidad.cambio(self)
	
	method cocinarParaTorneo(){
		especialidad.cocinar()
	}
	method catarYDarCalificacion(plato)= especialidad.catar()
	
	method cambiarEspecialidad(cual){
		especialidad = cual
	}
}

class Pastelero{
	var dulzor 
	method catar(plato){
		if(dulzor > 0 && dulzor <= 10)
			return 5 * plato.azucar() / dulzor.min(10)
		else
		throw new UserException(message = "El duzlor debe estar entre 1 y 10")
	}
	
	method cocinar()= new Postre(colores = dulzor / 50)
		
}

class Chef{
	var caloriasAceptadas
	method catar(plato) {
		if(self.cumpleCriterio(plato))
			return 10
		else 
			return 0
	}
	
	method cumpleCriterio(plato) =  plato.esBonito() && plato.calorias() <= caloriasAceptadas
	method cocinar()= new Principal(azucar = caloriasAceptadas , esBonito= true)
}

class SousChef inherits Chef{
	override method catar(plato){
		if(self.cumpleCriterio(plato))
			return super(10)
		else 
			return (plato.calorias() / 100).min(6)	
	}
	override method cocinar()= new Entrada()
}

class Torneo{
	const platosPresentados
	const catadores
	
	

	// Punto 6)B)
	method cocineroGanador() = 
		if (platosPresentados.isEmpty())
			throw new DomainException(message = "No se presentaron participantes")
		else
			self.platoPresentadoGanador().creador()
	
	method platoPresentadoGanador() = platosPresentados.max({platoPresentado => self.puntajeTotal(platoPresentado.plato())})
	
	method puntajeTotal(plato) = catadores.sum({catador => catador.catar(plato)})
	
	
	
}

const elias = new Cocinero(especialidad = new Pastelero(dulzor = 5))


const plato1 = new PlatoPresentado(plato = ravioles , creador = elias)
const ravioles = new Principal(azucar = 2 , esBonito = true)
const torneo = new Torneo (platosPresentados=[plato1] , catadores = [francisco , flor])