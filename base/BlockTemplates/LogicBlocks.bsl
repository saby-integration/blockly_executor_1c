
Функция simple_block_execute_logic(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	workspace_find_fields(node, block_context);
    workspace_execute_inputs(node, path, context, block_context);
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "logic_compare" Тогда
		block_check_step(context, block_context);
		result = block_logic_compare_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "logic_operation" Тогда
		block_check_step(context, block_context);
		result = block_logic_operation_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "logic_negate" Тогда
		block_check_step(context, block_context);
		result = block_logic_negate_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "logic_boolean" Тогда
		block_check_step(context, block_context);
		result = block_logic_boolean_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "logic_null" Тогда
		block_check_step(context, block_context);
		result = Неопределено;
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  

Функция block_execute_core_logic(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "controls_if" Тогда
		result = block_controls_if_execute(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции

Функция block_execute_logic(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_logic(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_logic(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;
	Возврат result;	
КонецФункции

