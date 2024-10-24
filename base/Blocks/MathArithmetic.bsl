//DynamicDirective
Функция block_math_arithmetic_calc_value(block_type, node, path, context, block_context)
	required_param = Новый Массив;
	required_param.Добавить("OP");
	required_param.Добавить("A");
	required_param.Добавить("B");
	block_check_required_param_in_block_context(required_param, block_context);
	operation = block_context["OP"];
	Если operation = "ADD" Тогда
		Возврат block_context["A"] + block_context["B"];
	ИначеЕсли operation = "MINUS" Тогда
		Возврат block_context["A"] - block_context["B"];
	ИначеЕсли operation = "MULTIPLY" Тогда
		Возврат block_context["A"] * block_context["B"];
	ИначеЕсли operation = "DIVIDE" Тогда
		Возврат block_context["A"] / block_context["B"];
	Иначе
		ВызватьИсключение NewExtExceptionСтрока(,"В блоке MathArithmetic не реализована операция",operation);
	КонецЕсли;
КонецФункции	
