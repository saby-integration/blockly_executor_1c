
// Функция simple_block_execute_function
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
Функция simple_block_execute_function(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "execute_workspace" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_execute_workspace_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "try" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_try_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "raise_ext_exception" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_raise_ext_exception_calc_value(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;		
КонецФункции
// BSLLS:FunctionOutParameter-on

// Функция block_execute_core_function
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
Функция block_execute_core_function(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "procedures_defnoreturn" Тогда
		result = block_procedures_defnoreturn_execute(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "procedures_callnoreturn" Тогда
		result = block_procedures_callnoreturn_execute(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "procedures_callreturn" Тогда
		result = block_procedures_callreturn_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "procedures_defreturn" Тогда
		result = block_procedures_defreturn_execute(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции
// BSLLS:FunctionOutParameter-on

// Функция block_execute_function
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
Функция block_execute_function(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_function(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_function(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;
	Возврат result;	
КонецФункции
