
Функция simple_block_execute_extsys(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	workspace_find_fields(node, block_context);
    workspace_execute_inputs(node, path, context, block_context);
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "extsys_read" Тогда
		block_check_step(context, block_context);
		result = block_extsys_read_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_update_status2" Тогда
		block_check_step(context, block_context);
		result = block_extsys_update_status2_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_read_changes" Тогда
		block_check_step(context, block_context);
		result = block_extsys_read_changes_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_calc_ini" Тогда
		block_check_step(context, block_context);
		result = block_extsys_calc_ini_calc_value(block_type, node, path, context, block_context);	 
	ИначеЕсли block_type = "extsys_print_form_list" Тогда
		block_check_step(context, block_context);
		result = block_extsys_print_form_list_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "object_get_attachments" Тогда
		block_check_step(context, block_context);
		result = block_object_get_attachments_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "object_get_attachments_EDO" Тогда
		block_check_step(context, block_context);
		result = block_object_get_attachments_EDO_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;		
КонецФункции

