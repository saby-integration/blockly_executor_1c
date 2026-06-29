
// Функция simple_block_execute_view_column_settings
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
Функция simple_block_execute_view_column_settings(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;

	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;

	Если block_type = "view_column_default" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_column_default_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_column_date_number" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_column_date_number_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_column_document_kedo" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_column_document_kedo_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_column_employee" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_column_employee_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_column_icon" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_column_icon_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции

//DynamicDirective

Функция simple_block_execute_view_filter_settings(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;

	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;

	Если block_type = "view_filter_number" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_filter_number_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_filter_string" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_filter_string_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_filter_chips" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_filter_chips_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_filter_enumeration_with_date" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_filter_enumeration_with_date_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_filter_period" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_filter_period_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_filter_enumeration" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_filter_enumeration_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_filter_link" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_filter_link_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_filter_bool" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_filter_bool_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции

// Функция simple_block_execute_settings
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
// BSLLS-off
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
		result = block_view_toolbar_search_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_toolbar_search" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_toolbar_search_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_toolbar_command" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_toolbar_command_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_toolbar_menu" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_toolbar_menu_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "public_param_get" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_public_param_get_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "algorithm_info" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_algorithm_info_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_list_flat" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_list_flat_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_list_hierarchical" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_list_hierarchical_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_list_tasks" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_list_tasks_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "view_list_documents" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_view_list_documents_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "extsys_query_by_view" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsys_query_by_view_calc_value(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции
// BSLLS-on

// Функция block_execute_core_settings
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
//DynamicDirective
Функция block_execute_core_settings(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "cache_read" Тогда
		result = block_cache_read_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции

// Функция block_execute_settings
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
//DynamicDirective
Функция block_execute_settings(block_type, node, path, context, block_context, БлокВыполнен)
	result = simple_block_execute_settings(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_view_column_settings(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_view_filter_settings(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда
		result = block_execute_core_settings(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Возврат result;
КонецФункции

