
//DynamicDirective

Функция block_controls_flow_statements_calc_value(block_type, node, path, context, block_context)
	operation = get_prop(block_context, "FLOW", "");
	Если operation = "BREAK" Тогда
		ВызватьИсключение NewExtExceptionСтрока(, "LoopBreak",,,, "LoopBreak");
	ИначеЕсли operation = "CONTINUE" Тогда 
		ВызватьИсключение NewExtExceptionСтрока(, "LoopContinue",,,, "LoopContinue");
	Иначе
		ВызватьИсключение NewExtExceptionСтрока(, "Для блока controls_flow_statements не реализована операция " + operation);
	КонецЕсли;
	Возврат Неопределено;	
КонецФункции
