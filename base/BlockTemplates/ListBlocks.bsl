
// Функция simple_block_execute_list
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
Функция simple_block_execute_list(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "lists_get_index" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_lists_get_index_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "lists_set_index" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_lists_set_index_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "lists_length" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_lists_length_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "lists_indexOf" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_lists_indexOf_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "list_obj_sort" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_list_obj_sort_calc_value(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  
// BSLLS:FunctionOutParameter-on

// Функция block_execute_core_list
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
Функция block_execute_core_list(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "lists_create_with" Тогда
		result = block_lists_create_with_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "lists_concatenate" Тогда
		result = block_lists_concatenate_execute(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции
// BSLLS:FunctionOutParameter-on

// Функция block_execute_list
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
Функция block_execute_list(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_list(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_list(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;
	Возврат result;	
КонецФункции
