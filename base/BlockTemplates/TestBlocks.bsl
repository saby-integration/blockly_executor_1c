
Функция simple_block_execute_test(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	workspace_find_fields(node, block_context);
    workspace_execute_inputs(node, path, context, block_context);
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "test_read_saby_object" Тогда
		block_check_step(context, block_context);
		result = block_test_read_saby_object_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;
КонецФункции

