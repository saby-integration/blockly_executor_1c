//DynamicDirective
Функция block_split_calc_value(block_type, node, path, context, block_context)
	value = block_context["value"];
	block_context["value"] = СтрРазделить82(value, block_context["delimiter"], Ложь);
	block_check_step(context, block_context);
	Возврат block_context["value"];	
КонецФункции	
