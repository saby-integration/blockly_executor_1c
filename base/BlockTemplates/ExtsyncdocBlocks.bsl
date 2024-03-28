
Функция simple_block_execute_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	simple_block_get_args(node, path, context, block_context);
	simple_block_get_fields(node, path, context, block_context);
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "extsyncdoc_write" Тогда
		block_check_step(context, block_context);
		result = block_extsyncdoc_write_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsyncdoc_run" Тогда
		block_check_step(context, block_context);
		result = block_extsyncdoc_run_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsyncdoc_create" Тогда
		block_check_step(context, block_context);
		result = block_extsyncdoc_create_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsyncdoc_fillchangedsbisobjects" Тогда
		block_check_step(context, block_context);
		result = block_extsyncdoc_extsyncdoc_fillchangedsbisobjects_calc_value(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;
КонецФункции

Функция block_execute_core_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "saby_extsyncobj_list" Тогда
		result = block_multithreadloop_execute(block_type, node, path, context, block_context, Истина);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции

Функция block_execute_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;	
	Возврат result;	
КонецФункции


