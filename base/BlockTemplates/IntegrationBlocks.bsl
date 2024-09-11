
Функция simple_block_execute_integration(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	workspace_find_fields(node, block_context);
    workspace_execute_inputs(node, path, context, block_context);
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "saby_upload_files" Тогда
		block_check_step(context, block_context);
		result = block_saby_upload_files_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_convert_files_to_pdf" Тогда
		block_check_step(context, block_context);
		result = block_saby_convert_files_to_pdf_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_query" Тогда
		block_check_step(context, block_context);
		result = block_saby_query_calc_value(block_type, node, path, context, block_context);	 
	ИначеЕсли block_type = "saby_find" Тогда
		block_check_step(context, block_context);
		result = block_saby_find_calc_value(block_type, node, path, context, block_context); 
	ИначеЕсли block_type = "saby_read" Тогда
		block_check_step(context, block_context);
		result = block_saby_read_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby" Тогда	
		block_check_step(context, block_context);
		result = block_saby_calc_value(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;		
КонецФункции

