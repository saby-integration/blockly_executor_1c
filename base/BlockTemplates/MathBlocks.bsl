
//DynamicDirective
Функция simple_block_execute_math(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "math_number" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_math_number_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "math_arithmetic" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_math_arithmetic_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "math_round" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_math_round_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  

//DynamicDirective
Функция block_execute_math(block_type, node, path, context, block_context, БлокВыполнен)
	result = simple_block_execute_math(block_type, node, path, context, block_context, БлокВыполнен);	
	Возврат result;	
КонецФункции

