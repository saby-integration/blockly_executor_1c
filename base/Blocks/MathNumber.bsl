Функция block_math_number_calc_value(block_type, node, path, context, block_context)
	required_param = Новый Массив;
	required_param.Добавить("NUM");
	block_check_required_param_in_block_context(required_param, block_context);
	Возврат Число(block_context["NUM"]);	
КонецФункции	
