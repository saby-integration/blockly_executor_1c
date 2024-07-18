
Функция simple_block_execute_text(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	simple_block_get_args(node, path, context, block_context);
	simple_block_get_fields(node, path, context, block_context);
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "concatenate" Тогда
		block_check_step(context, block_context);
		result = block_concatenate_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "split" Тогда
		block_check_step(context, block_context);
		result = block_split_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "text_getSubstring" Тогда
		block_check_step(context, block_context);
		result = block_text_getSubstring_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "re_search" Тогда
		block_check_step(context, block_context);
		result = block_re_search_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "text_charAt" Тогда
		block_check_step(context, block_context);
		result = block_text_charAt_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли  block_type = "text_indexOf" Тогда
		block_check_step(context, block_context);
		result = block_text_indexOf_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "format" Тогда
		block_check_step(context, block_context);
		result = block_format_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "get_current_datetime" Тогда
		block_check_step(context, block_context);
		result = block_get_current_datetime_calc_value(block_type, node, path, context, block_context);		
	ИначеЕсли block_type = "uuid4" Тогда
		block_check_step(context, block_context);
		result = block_uuid4_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  

Функция block_execute_core_text(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "text" Тогда
		result = block_text_execute(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции

Функция block_execute_text(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_text(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_text(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;
	Возврат result;	
КонецФункции

