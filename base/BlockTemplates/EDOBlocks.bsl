
//DynamicDirective
Функция simple_block_execute_edo(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "saby_edo_start" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_saby_edo_start_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "fed_convert_object_to_xml" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_fed_convert_object_to_xml_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "fed_convert_xml_to_object" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_fed_convert_xml_to_object_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_read_document" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_saby_read_document_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_write_document" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_saby_write_document_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_document_list" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_saby_document_list_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_document_event_list" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_saby_document_event_list_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "invite_user" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_invite_user_calc_value(block_type, node, path, context, block_context);	 
	ИначеЕсли block_type = "saby_download_from_link" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_saby_download_from_link_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_execute_action" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_saby_execute_action_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  

//DynamicDirective
Функция block_execute_core_edo(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "saby_read_changes" Тогда
		result = block_multithreadloop_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_task_list" Тогда
		result = block_multithreadloop_execute(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции

//DynamicDirective
Функция block_execute_edo(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_edo(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_edo(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;	
	Возврат result;	
КонецФункции

