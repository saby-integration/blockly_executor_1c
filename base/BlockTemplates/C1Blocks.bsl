
Функция simple_block_execute_с1(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	simple_block_get_args(node, path, context, block_context);
	simple_block_get_fields(node, path, context, block_context);
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "c1_ref_to_obj" Тогда
		block_check_step(context, block_context);
		result = block_c1_ref_to_obj_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_ref_from_id" Тогда
		block_check_step(context, block_context);
		result = block_c1_ref_from_id_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_doc_read_print_forms" Тогда
		block_check_step(context, block_context);
		result = block_c1_doc_read_print_forms_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_ref" Тогда
		block_check_step(context, block_context);
		result = block_c1_ref_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_meta_read" Тогда
		block_check_step(context, block_context);
		result = block_c1_meta_read_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_meta_update" Тогда
		block_check_step(context, block_context);
		result = block_c1_meta_update_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_call_filter" Тогда
		block_check_step(context, block_context);
		result = block_c1_call_filter_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_get_uuid" Тогда
		block_check_step(context, block_context);
		result = block_c1_get_uuid_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_ref_from_api3" Тогда
		block_check_step(context, block_context);
		result = block_c1_ref_from_api3_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_predefine" Тогда
		block_check_step(context, block_context);
		result = block_c1_predefine_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_register_update" Тогда
		block_check_step(context, block_context);
		result = block_c1_register_update_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_strip" Тогда
		block_check_step(context, block_context);
		result = block_c1_strip_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_attach_attachment" Тогда
		block_check_step(context, block_context);
		result = block_c1_attach_attachment_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  

Функция block_execute_core_с1(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "c1_call_select" Тогда
		result = block_c1_call_select_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_meta_create" Тогда
		result = block_c1_meta_create_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_clear_table" Тогда
		result = block_c1_clear_table_execute(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции

Функция block_execute_c1(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_с1(block_type, node, path, context, block_context, БлокВыполнен);
	Если НЕ БлокВыполнен Тогда
		result = simple_block_execute_с1(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;
	Возврат result;	
КонецФункции

