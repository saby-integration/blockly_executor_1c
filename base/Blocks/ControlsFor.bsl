//DynamicDirective
Функция block_controls_for_calc_value(block_type, node, path, context, block_context)
	required_param = новый массив;
	required_param.Добавить("BY");
	required_param.Добавить("VAR");
	block_check_required_param_in_block_context(required_param, block_context);
	
	index = ? (block_context.Свойство("FROM") И block_context["FROM"]<> неопределено, block_context["FROM"], 1);
	index = ? (block_context.Свойство("current_index") И block_context["current_index"]<> неопределено, block_context["current_index"], index);
	indexTo = ? (block_context.Свойство("TO") И block_context["TO"]<> неопределено, block_context["TO"], 10);
	indexBy = ? (block_context.Свойство("BY") И block_context["BY"]<> неопределено, block_context["BY"], 1);
	
	Пока index <= indexTo Цикл
		block_set_variable(context, block_context["VAR"], index);
		ДочернийУзел = get_statement_node(node);
		block_execute_all_next(ДочернийУзел, path, context, block_context, True);

		index = index + indexBy;
		block_context.Вставить("current_index", index);
	КонецЦикла;	
КонецФункции
