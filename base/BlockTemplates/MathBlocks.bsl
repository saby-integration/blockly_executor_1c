
// Функция simple_block_execute_math
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
Функция simple_block_execute_math(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "math_number" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_math_number_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "math_arithmetic" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_math_arithmetic_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "math_round" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_math_round_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции
// BSLLS:FunctionOutParameter-on

// Функция block_execute_math
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
Функция block_execute_math(block_type, node, path, context, block_context, БлокВыполнен)
	result = simple_block_execute_math(block_type, node, path, context, block_context, БлокВыполнен);	
	Возврат result;	
КонецФункции
