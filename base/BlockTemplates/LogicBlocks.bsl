
// Функция simple_block_execute_logic
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
Функция simple_block_execute_logic(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "logic_compare" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_logic_compare_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "logic_compare2" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_logic_compare2_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "logic_operation" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_logic_operation_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "logic_negate" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_logic_negate_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "logic_boolean" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_logic_boolean_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "logic_null" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = Неопределено;
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции
// BSLLS:FunctionOutParameter-on

// Функция block_execute_core_logic
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
Функция block_execute_core_logic(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "controls_if" Тогда
		result = block_controls_if_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "ternary_operation" Тогда
		result = block_ternary_operation_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции
// BSLLS:FunctionOutParameter-on

// Функция block_execute_logic
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
Функция block_execute_logic(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_logic(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_logic(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;
	Возврат result;	
КонецФункции
