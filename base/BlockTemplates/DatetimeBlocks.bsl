
// Функция simple_block_execute_datetime
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
// BSLLS:FunctionOutParameter-off
//DynamicDirective
Функция simple_block_execute_datetime(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "date_to_string" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_date_to_string_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "string_to_date" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_string_to_date_calc_value(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции
// BSLLS:FunctionOutParameter-on

// Функция block_execute_datetime
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
Функция block_execute_datetime(block_type, node, path, context, block_context, БлокВыполнен)
	result = simple_block_execute_datetime(block_type, node, path, context, block_context, БлокВыполнен);	
	Возврат result;	
КонецФункции
