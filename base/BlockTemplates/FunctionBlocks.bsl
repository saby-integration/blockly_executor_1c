
Функция block_execute_core_function(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "procedures_defnoreturn" Тогда
		result = block_procedures_defnoreturn_execute(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "procedures_callnoreturn" Тогда
		result = block_procedures_callnoreturn_execute(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "procedures_callreturn" Тогда
		result = block_procedures_callreturn_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "procedures_defreturn" Тогда
		result = block_procedures_defreturn_execute(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "execute_workspace" Тогда
		result = block_execute_workspace_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "try" Тогда
		result = block_try_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции

Функция block_execute_function(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_function(block_type, node, path, context, block_context, БлокВыполнен);
	Возврат result;	
КонецФункции

