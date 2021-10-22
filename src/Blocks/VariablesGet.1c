Функция block_variables_get_calc_value(block_type, node, path, context, block_context)
	required_param = новый массив;
	required_param.Добавить("VAR");
	block_check_required_param_in_block_context(required_param, block_context);
	Попытка
		Возврат block_get_variable(context, block_context["VAR"]);
	Исключение
		ВызватьИсключение "Переменная " + block_context["VAR"] + " не определена"
	КонецПопытки
КонецФункции
