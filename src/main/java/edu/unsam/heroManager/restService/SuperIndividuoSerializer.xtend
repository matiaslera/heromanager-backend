package edu.unsam.heroManager.restService

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import edu.unsam.heroManager.SuperIndividuo
import java.io.IOException
import java.util.List

class SuperIndividuoSerializer extends StdSerializer<SuperIndividuo> {

	new(Class<SuperIndividuo> t) {
		super(t);
	}

	override serialize(SuperIndividuo value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject();
		gen.writeStringField("id", value.id);
		gen.writeStringField("apodo", value.apodo);
		gen.writeEndObject();
	}
	
	static def String toJson(SuperIndividuo individuo) {
		mapper().writeValueAsString(individuo)
	}
	
	static def String toJson(List<SuperIndividuo> individuos) {
		if(individuos===null || individuos.empty){return "[ ]"}
		mapper().writeValueAsString(individuos)
	}
	static def mapper(){
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(SuperIndividuo,new SuperIndividuoSerializer(SuperIndividuo))
		mapper.registerModule(module)
		mapper
	}
}
