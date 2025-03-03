
//DynamicDirective
Функция simple_block_execute_variables(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "variables_set" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_variables_set_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "variables_get" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_variables_get_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  

//DynamicDirective
Функция block_execute_variables(block_type, node, path, context, block_context, БлокВыполнен)
	result = simple_block_execute_variables(block_type, node, path, context, block_context, БлокВыполнен);	
	Возврат result;	
КонецФункции

