//PRIMER INTENTO
/*class Empleado{
	const habilidades = []
	var cantidadSalud = 0
	var cantidadDanio= 0
	var rol 
	// const equipo = #{}
	method aprenderHabilidad(habilidad){
		habilidades.add(habilidad)
	}
	method saludCritica()
	//Punto 1
	method estaIncapacitado()= cantidadSalud < self.saludCritica()
	//Ver después en el vídeo si me conviene tenerla como const con un valor o como método
	
	//Punto 2
	method puedeUsarHabilidad(habilidad)= not self.estaIncapacitado() and self.poseeHabilidad(habilidad)
	method poseeHabilidad(habilidad)= habilidades.contains(habilidad)
	method cumplirMision(mision){
		if(self.reuneHabilidadesPara(mision)){
			self.sufrirEfectos(mision, mision.peligrosidad())	
		}
	}
	method sufrirEfectos(mision, danioPorMision){
		self.recibirDanio(danioPorMision)
			self.completarMision(mision)
	}
	method cumplirMisionEnEquipo(mision, equipo){
		if(self.algunoPuedeCumplir(mision, equipo)){
			equipo.forEach({persona => persona.sufrirEfectos(mision, mision.peligrosidad()/3)})
			
			
		}}
	method sobrevivioMision()= cantidadSalud > 0
	method completarMision(mision){
		if(self.sobrevivioMision()){
			self.completarMisionSegunRol(mision)
		}
	}
	method recibirDanio(danio){
		cantidadDanio += danio	
		cantidadSalud -= cantidadDanio
		
	}
	method completarMisionSegunRol(mision)
	method algunoPuedeCumplir(mision, equipo)= equipo.any({persona => persona.reuneHabilidadesPara(mision)})
	method reuneHabilidadesPara(mision)= mision.habilidadesRequeridas().forEach({habilidadRequerida => self.puedeUsarHabilidad(habilidadRequerida)})
}

class Jefe inherits Empleado{
	const subordinados = #{}
	override method puedeUsarHabilidad(habilidad)= super(habilidad) or self.algunSubordinadoPuedeUsar(habilidad)
	method algunSubordinadoPuedeUsar(habilidad)= subordinados.any({subordinado => subordinado.puedeUsarHabilidad(habilidad)})
}//aquí faltaría aclarar el rol de los jefes porque pueden ser espías u oficinistas

class Espia inherits Empleado{
	var habilidadesDesconocidas = []
	override method saludCritica()= 15
	override method completarMisionSegunRol(mision){
		self.hallarHabilidadesDesconocidas(mision)
		habilidadesDesconocidas.forEach({habilidad => self.aprenderHabilidad(habilidad)})
	}
method hallarHabilidadesDesconocidas(mision){
	habilidadesDesconocidas = mision.habilidadesRequeridas().forEach({habilidad => not self.puedeUsarHabilidad(habilidad)})
}
}

class Oficinista inherits Empleado{
	//agregarEstrella Si Gana Mision
	var cantidadEstrellas
	override method saludCritica()= 40-5*cantidadEstrellas
	override method completarMisionSegunRol(mision){
		cantidadEstrellas += 1
		self.verificarCambioDeRol()
	}
	
	method verificarCambioDeRol(){
		if(cantidadEstrellas == 3){
			rol = new Espia()
		}
	}
}*/

// Refactorizar porque no puedo cambiar el rol en oficinista
class Empleado{
	const habilidades = []
	var cantidadSalud = 0
	var cantidadDanio= 0
	var rol
	var formaCumplirMision 
	

	method cambiarRol(nuevoRol){
		rol = nuevoRol
	}
	// const equipo = #{}
	method aprenderHabilidad(habilidad){
		habilidades.add(habilidad)
	}
	//Punto 1
	method estaIncapacitado()= cantidadSalud < rol.saludCritica()
	//Ver después en el vídeo si me conviene tenerla como const con un valor o como método
	// RSTA: COMO MÉTODO 
	
	//Punto 2
	method puedeUsarHabilidad(habilidad)= not self.estaIncapacitado() and self.poseeHabilidad(habilidad)
	method poseeHabilidad(habilidad)= habilidades.contains(habilidad)
	method cumplirMision(mision){
		if(self.reuneHabilidadesPara(mision)){
			self.sufrirEfectos(mision, mision.peligrosidad())	
		}
	}
	method sufrirEfectos(mision, danioPorMision){
		self.recibirDanio(danioPorMision)
			self.completarMision(mision)
	}
	
	method sobrevivioMision()= cantidadSalud > 0
	method completarMision(mision){
		if(self.sobrevivioMision()){
			rol.completarMisionSegunRol(mision, self)
		}
	}
	method recibirDanio(danio){
		cantidadDanio += danio	
		cantidadSalud -= cantidadDanio
		
	}
	
	
	method reuneHabilidadesPara(mision)= mision.habilidadesRequeridas().forEach({habilidadRequerida => self.puedeUsarHabilidad(habilidadRequerida)})

	/*method hallarHabilidadesDesconocidas(mision){
	habilidadesDesconocidas = mision.habilidadesRequeridas().forEach({habilidad => not self.puedeUsarHabilidad(habilidad)})}
	
	method aprenderHabilidadesDesconocidas(){
		habilidadesDesconocidas.forEach({habilidad => self.aprenderHabilidad(habilidad)})
		* Ya no me importa que la persona haga esto, se encarga la misión de decirte cuales aprender*/ 
	}


class Jefe inherits Empleado{
	const subordinados = #{}
	override method puedeUsarHabilidad(habilidad)= super(habilidad) or self.algunSubordinadoPuedeUsar(habilidad)
	method algunSubordinadoPuedeUsar(habilidad)= subordinados.any({subordinado => subordinado.puedeUsarHabilidad(habilidad)})
}

class Equipo{
	const integrantes = #{}
	method cumplirMision(mision){
		if(self.algunoPuedeCumplir(mision)){
			integrantes.forEach({persona => persona.sufrirEfectos(mision, mision.peligrosidad()/3)})}
			}
	method algunoPuedeCumplir(mision)= integrantes.any({persona => persona.reuneHabilidadesPara(mision)})
}
object espia{
	method saludCritica()= 15
	method completarMisionSegunRol(mision, persona){
	mision.enseniarHabilidades(persona)
	}

}

class Oficinista{
	//agregarEstrella Si Gana Mision
	var cantidadEstrellas
	method saludCritica()= 40-5* cantidadEstrellas
	method completarMisionSegunRol(mision, persona){
		self.ganarEstrella()
		self.verificarCambioDeRol(persona)
	}
	method cantidadEstrellas()= cantidadEstrellas
	method ganarEstrella(){cantidadEstrellas += 1}
	
	method verificarCambioDeRol(persona){
		if(cantidadEstrellas == 3){
			persona.cambiarRol(espia)
		}}
	}
class Mision{
	const peligrosidad
	const habilidadesRequeridas = #{}
	method peligrosidad()= peligrosidad
	method habilidadesRequeridas()= habilidadesRequeridas
	method habilidadesQueNoPosee(persona)= habilidadesRequeridas.filter({habilidad => not persona.puedeUsarHabilidad()})
	method enseniarHabilidades(persona){self.habilidadesQueNoPosee(persona).forEach({habilidad => persona.aprenderHabilidad(habilidad)})}
	method serCumplidaPor(asignado){
		asignado.cumplirMision(self) 
	}
}


