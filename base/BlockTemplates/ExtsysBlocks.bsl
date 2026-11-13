
// Функция simple_block_execute_extsys
//
// Параметры:
// block_type - Строка - Название блока
// node - XML - Текущий обрабатываемый узел XML
// path - Строка - Абсолютный путь до исполняемого блока
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
// БлокВыполнен - Булево - Признак выполнения блока
//
// Возвращаемое значение:
//  Структура - Результат выполения функции
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:FunctionOutParameter-off
//DynamicDirective
Функция simple_block_execute_extsys(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "extsys_read" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsys_read_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_update_status2" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsys_update_status2_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_update_status3" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsys_update_status3_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_read_changes" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsys_read_changes_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_calc_ini" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsys_calc_ini_calc_value(block_type, node, path, context, block_context);	 
	ИначеЕсли block_type = "extsys_print_form_list" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsys_print_form_list_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "object_get_attachments" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_object_get_attachments_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "object_get_attachments_EDO" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_object_get_attachments_EDO_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "file_read" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_file_read_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "append_status_from_is" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_append_status_from_is_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "os_execute" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_os_execute_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "ask_user" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_ask_user_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "extsys_link_by_external_uid" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsys_link_by_external_uid_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	
	Возврат result;		
КонецФункции
// BSLLS:FunctionOutParameter-on
