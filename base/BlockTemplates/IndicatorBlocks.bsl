
// Функция simple_block_execute_indicator
//
// Не видит описания параметра - БлокВыполнен
// BSLLS:MissingParameterDescription-off
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
Функция simple_block_execute_indicator(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "indicator_from_accounting_entry_side" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_indicator_from_accounting_entry_side_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли  block_type = "taxmon2_indicator_register" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_taxmon2_indicator_register_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли  block_type = "taxmon2_indicator_turnover_account" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_taxmon2_indicator_turnover_account_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли  block_type = "taxmon2_indicator_turnover_accounts" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_taxmon2_indicator_turnover_accounts_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;		
КонецФункции
// BSLLS:FunctionOutParameter-on
// BSLLS:MissingParameterDescription-on

// Функция block_execute_core_indicator
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
Функция block_execute_core_indicator(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "accounting_entries_list" Тогда
		result = block_multithreadloop_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "accounting_entries_list2" Тогда
		result = block_multithreadloop_execute(block_type, node, path, context, block_context);
	ИначеЕсли  block_type = "taxmon2_set_declaration_indicator" Тогда
		result = block_taxmon2_set_declaration_indicator_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "taxmon2_get_declaration_indicator" Тогда
		result = block_taxmon2_get_declaration_indicator_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли  block_type = "taxmon2_math_arithmetic" Тогда
		result = block_taxmon2_math_arithmetic_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции
// BSLLS:FunctionOutParameter-on

// block_execute_indicator
//
// BSLLS:MissingParameterDescription-off
// Не видит описания параметра - БлокВыполнен
//
// Параметры:
// block_type - Строка - Название блока
// node - XML - Текущий обрабатываемый узел XML
// path - Строка - Абсолютный путь до исполняемого блока
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
// БлокВыполнен - Признак выполнения блока
//
// Возвращаемое значение:
//  Структура - Результат выполения функции
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:FunctionOutParameter-off
//DynamicDirective
Функция block_execute_indicator(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_indicator(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_indicator(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;	
	Возврат result;	
КонецФункции
// BSLLS:FunctionOutParameter-on
// BSLLS:MissingParameterDescription-on
