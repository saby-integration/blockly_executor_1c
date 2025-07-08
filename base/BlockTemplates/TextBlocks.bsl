
// функция simple_block_execute_text
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
Функция simple_block_execute_text(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "concatenate" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_concatenate_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "split" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_split_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "text_getSubstring" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_text_getSubstring_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "re_search" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_re_search_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "text_charAt" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_text_charAt_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли  block_type = "text_indexOf" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_text_indexOf_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "format" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_format_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "get_current_datetime" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_get_current_datetime_calc_value(block_type, node, path, context, block_context);		
	ИначеЕсли block_type = "uuid4" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_uuid4_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "text_replace" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_text_replace_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "text_length" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_text_length_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "text_trim" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_text_trim_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  
// BSLLS:FunctionOutParameter-on

// Функция block_execute_core_text
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
Функция block_execute_core_text(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "text" Тогда
		result = block_text_execute(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции
// BSLLS:FunctionOutParameter-on

// функция block_execute_text
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
Функция block_execute_text(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_text(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_text(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;
	Возврат result;	
КонецФункции
