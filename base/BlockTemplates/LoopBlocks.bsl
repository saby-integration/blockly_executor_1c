
//DynamicDirective
Функция simple_block_execute_loop(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "controls_for" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_controls_for_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "controls_forEach2" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_controls_for_each2_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "controls_forEach" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_controls_for_each_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  

//DynamicDirective
Функция block_execute_core_loop(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "controls_whileUntil" Тогда
		result = block_controls_while_until_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "controls_forEachAsync" Тогда
		result = block_multithreadloop_execute(block_type, node, path, context, block_context, Истина);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции

//DynamicDirective
Функция block_execute_loop(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_loop(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_loop(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;
	Возврат result;	
КонецФункции


