
//DynamicDirective
Функция simple_block_execute_indicator(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "indicator_from_accounting_entry_side" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_indicator_from_accounting_entry_side_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;		
КонецФункции

//DynamicDirective
Функция block_execute_core_indicator(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "accounting_entries_list" Тогда
		result = block_multithreadloop_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "accounting_entries_list2" Тогда
		result = block_multithreadloop_execute(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции

//DynamicDirective
Функция block_execute_indicator(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_indicator(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_indicator(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;	
	Возврат result;	
КонецФункции

