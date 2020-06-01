package edu.unsam.heroManager.restService

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import edu.unsam.heroManager.Equipo
import java.io.IOException
import java.util.List

class EquipoSerializer extends StdSerializer<Equipo> {
	
new(Class<Equipo> t) {
		super(t);
	}

	override serialize(Equipo value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject()
		gen.writeStringField("id", value.id)
		gen.writeStringField("nombre", value.nombre)
		gen.writeStringField("ownerId", value.owner.id)
		gen.writeStringField("owner", value.owner.apodo)
		gen.writeStringField("lider", value.lider.apodo)
		gen.writeEndObject()
	}
		
	static def String toJson(List<Equipo> items) {
	
		mapper().writeValueAsString(items)
	}
	static def mapper(){
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Equipo,new EquipoSerializer(Equipo))
		mapper.registerModule(module)
		mapper
	}
}
//
//class EquipoCompletoSerializer extends StdSerializer<Equipo> {
//	
//new(Class<Equipo> t) {
//		super(t);
//	}
//
//	override serialize(Equipo value, JsonGenerator gen, SerializerProvider provider) throws IOException {
//		gen.writeStartObject()
//		gen.writeStringField("id", value.id)
//		gen.writeStringField("nombre", value.nombre)
//		gen.writeStringField("owner",SuperIndividuoSerializer.toJson(value.owner))
//		gen.writeStringField("lider",SuperIndividuoSerializer.toJson(value.lider))
//		gen.writeStringField("integrantes",SuperIndividuoSerializer.toJson(value.integrantes.toList))
//		gen.writeEndObject()
//	}
//		
//	static def String toJson(Equipo items) {
//	
//		mapper().writeValueAsString(items)
//	}
//	static def mapper(){
//		val ObjectMapper mapper = new ObjectMapper()
//		val SimpleModule module = new SimpleModule()
//		module.addSerializer(Equipo,new EquipoCompletoSerializer(Equipo))
//		mapper.registerModule(module)
//		mapper
//	}
//}