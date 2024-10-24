
//DynamicDirective
Функция simple_block_execute_test(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "test_read_saby_object" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_test_read_saby_object_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;
КонецФункции

