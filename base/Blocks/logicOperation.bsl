Функция block_logic_operation_calc_value(block_type, node, path, context, block_context)
	required_param = Новый Массив;
	required_param.Добавить("A");
	required_param.Добавить("B");
	required_param.Добавить("OP");
	block_check_required_param_in_block_context(required_param, block_context);
	block_a = ?(ЗначениеЗаполнено(block_context["A"]) и не (ТипЗнч(block_context["A"]) = Тип("Булево") и не block_context["A"]), Истина, Ложь);
	block_b = ?(ЗначениеЗаполнено(block_context["B"]) и не (ТипЗнч(block_context["B"]) = Тип("Булево") и не block_context["B"]), Истина, Ложь); 
	operation = block_context["OP"];
	Если operation = "AND" Тогда
		Возврат ?(block_a И block_b, Истина, Ложь);
	ИначеЕсли operation = "OR" Тогда
		Возврат ?(block_a ИЛИ block_b, Истина, Ложь);
	Иначе
		ВызватьИсключение operation + " не поддерживается"
	КонецЕсли;	
КонецФункции
