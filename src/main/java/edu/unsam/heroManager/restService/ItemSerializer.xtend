package edu.unsam.heroManager.restService

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import edu.unsam.heroManager.Item
import java.io.IOException
import java.util.List

class ItemSerializer extends StdSerializer<Item> {
	
new(Class<Item> t) {
		super(t);
	}

	override serialize(Item value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject()
		gen.writeStringField("id", value.id)
		gen.writeStringField("apodo", value.nombre)
		gen.writeNumberField("poder",value.poderDeAtaque)
		gen.writeEndObject()
	}
		
	static def String toJson(List<Item> items) {
		if(items===null || items.empty){return "[ ]"}
		mapper().writeValueAsString(items)
	}
	static def mapper(){
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Item,new ItemSerializer(Item))
		mapper.registerModule(module)
		mapper
	}
}