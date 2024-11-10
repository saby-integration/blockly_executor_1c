
//DynamicDirective
Функция simple_block_execute_settings(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "accordion_item" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_accordion_item_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_obj_action_list_view_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view_filter" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_obj_action_list_view_filter_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view_column" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_obj_action_list_view_column_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view_toolbar" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_obj_action_list_view_toolbar_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view_toolbar_search" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_obj_action_list_view_toolbar_search_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_toolbar_menu" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_toolbar_menu_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "public_param_get" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_public_param_get_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "algorithm_info" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_algorithm_info_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  

//DynamicDirective
Функция block_execute_settings(block_type, node, path, context, block_context, БлокВыполнен)
	result = simple_block_execute_settings(block_type, node, path, context, block_context, БлокВыполнен);	
	Возврат result;	
КонецФункции

