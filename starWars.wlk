
class UserException inherits Exception { }

class Planeta{
	var property habitantes
	
	method poder() = habitantes.sum()
	
	method poseeOrden()= habitantes.shortby({unHab,otroHab => unHab.poder() > otroHab.poder()}).take(3).sum() > self.poder() / 2
	
}

class Habitante{
	var valentia 
	var fortaleza 
	
	method poder() = valentia + fortaleza
}

class Soldado inherits Habitante{
	var equipamento 
	override method poder() = super()+equipamento.map({equip => equip.poder()})
	method usar (equip){
		if(equipamento.contains(equip))
		equip.uso(+1)
		else 
		throw new UserException(message = "No se encontro el equipamento")
	}
	method reparar(arma){
		arma.uso(0)
	}
	
	method tomar(arma)= equipamento.add(arma)
	method soltar(arma) {
		if(equipamento.contains(arma))
			equipamento.remove(arma)
			else
			throw new UserException(message = "No se encontro el arma")
	}
}

class Equipamento {
	var potencia 
	var property uso = 0
	method esUtil()= potencia > 10 && not self.desgastada() 
	method desgastada()= uso > 20
	
}

class Maestro inherits Habitante{
	const midiclorias
	var property bando 
	var  sable 
	
	override method poder() = super() + midiclorias / 1000 + bando.poderDe(sable)
	
	method vivirSuceso(suceso , maestro) {
		bando.vivirSuceso(suceso , maestro)
	}
}

class Fuerza {
	const property nombre
	var tiempoEnBando = 0
	method poderDe(sable) = sable.potencia()
	
	method pasarTiempo() = tiempoEnBando++
	
	method vivirSuceso(suceso, maestro) {
		self.pasarTiempo()
		self.aceptarSuceso(suceso, maestro)	
	}
	
	method aceptarSuceso(suceso, maestro)
	
}

class LadoLuminoso inherits Fuerza(nombre = "Lado luminoso"){
	var pazInterior = 1000
	override method poderDe(sable) = super(sable) + tiempoEnBando
	
	override method aceptarSuceso(suceso , maestro){
		self.alterarPazInterior(suceso.cargaEmocional())
		if(self.sinPaz())
			maestro.bando(new LadoOscuro())
	}
	
	method alterarPazInterior(cant) {
		pazInterior = pazInterior + cant 
		}
	
	method sinPaz() = pazInterior <= 0
		
	
}

class LadoOscuro inherits Fuerza(nombre = "Lado oscuro"){
	var odio = 10
	override method poderDe(sable) = super(sable) * 2 + tiempoEnBando
	
	override method aceptarSuceso(suceso , maestro){
		if(suceso.cargaEmocional() > odio) 
			maestro.ladoFuerza(new LadoLuminoso())	
		else 
			self.aumentarOdio()	
	}
	
	method aumentarOdio(){odio *= 1.1}
}

class Suceso{
	var property cargaEmocional
}
const sableDeLuz = new Equipamento(potencia = 300)
const muerte = new Suceso(cargaEmocional = -1100)
const anaking = new Maestro(bando = new LadoLuminoso() , fortaleza = 60 , midiclorias = 0 , sable = sableDeLuz , valentia = 30)




