
//DynamicDirective
Функция simple_block_execute_list(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "lists_get_index" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_lists_get_index_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "lists_set_index" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_lists_set_index_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "lists_length" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_lists_length_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  

//DynamicDirective
Функция block_execute_core_list(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "lists_create_with" Тогда
		result = block_lists_create_with_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "lists_concatenate" Тогда
		result = block_lists_concatenate_execute(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции

//DynamicDirective
Функция block_execute_list(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_list(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_list(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;
	Возврат result;	
КонецФункции

