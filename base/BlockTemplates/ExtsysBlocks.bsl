
Функция simple_block_execute_extsys(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	simple_block_get_args(node, path, context, block_context);
	simple_block_get_fields(node, path, context, block_context);
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "extsys_read" Тогда
		block_check_step(context, block_context);
		result = block_extsys_read_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_update_status" Тогда
		block_check_step(context, block_context);
		result = block_saby_extsys_update_status_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_update_status2" Тогда
		block_check_step(context, block_context);
		result = block_saby_extsys_update_status2_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_read_changes" Тогда
		block_check_step(context, block_context);
		result = block_extsys_read_changes_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_calc_ini" Тогда
		block_check_step(context, block_context);
		result = block_extsys_calc_ini_calc_value(block_type, node, path, context, block_context);	 
	ИначеЕсли block_type = "test_read_saby_object" Тогда
		block_check_step(context, block_context);
		result = block_test_read_saby_object_calc_value(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;		
КонецФункции

