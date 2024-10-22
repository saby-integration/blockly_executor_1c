//DynamicDirective
Функция block_logic_compare_calc_value(block_type, node, path, context, block_context)
	required_param = Новый Массив;
	required_param.Добавить("A");
	required_param.Добавить("B");
	required_param.Добавить("OP");
	block_check_required_param_in_block_context(required_param, block_context);
	operation = block_context["OP"];
	Если operation = "EQ" Тогда
		Возврат ?(block_context["A"] = block_context["B"], Истина, Ложь);
	ИначеЕсли operation = "GT" Тогда
		Возврат ?(block_context["A"] > block_context["B"], Истина, Ложь);
	ИначеЕсли operation = "LT" Тогда
		Возврат ?(block_context["A"] < block_context["B"], Истина, Ложь);
	ИначеЕсли operation = "GTE" Тогда
		Возврат ?(block_context["A"] >= block_context["B"], Истина, Ложь);
	ИначеЕсли operation = "LTE" Тогда
		Возврат ?(block_context["A"] <= block_context["B"], Истина, Ложь);
	ИначеЕсли operation = "NEQ" Тогда
		Возврат ?(block_context["A"] <> block_context["B"], Истина, Ложь);
	Иначе
		ВызватьИсключение operation + " не поддерживается"
	КонецЕсли;	
КонецФункции
