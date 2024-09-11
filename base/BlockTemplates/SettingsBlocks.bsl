
Функция simple_block_execute_settings(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	workspace_find_fields(node, block_context);
    workspace_execute_inputs(node, path, context, block_context);
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "accordion_item" Тогда
		block_check_step(context, block_context);
		result = block_accordion_item_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view" Тогда
		block_check_step(context, block_context);
		result = block_obj_action_list_view_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view_filter" Тогда
		block_check_step(context, block_context);
		result = block_obj_action_list_view_filter_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view_column" Тогда
		block_check_step(context, block_context);
		result = block_obj_action_list_view_column_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view_toolbar" Тогда
		block_check_step(context, block_context);
		result = block_obj_action_list_view_toolbar_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view_toolbar_search" Тогда
		result = block_obj_action_list_view_toolbar_search_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "public_param_get" Тогда
		block_check_step(context, block_context);
		result = block_public_param_get_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  

Функция block_execute_settings(block_type, node, path, context, block_context, БлокВыполнен)
	result = simple_block_execute_settings(block_type, node, path, context, block_context, БлокВыполнен);	
	Возврат result;	
КонецФункции

