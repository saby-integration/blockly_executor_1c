
// функция simple_block_execute_test
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
Функция simple_block_execute_test(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "test_read_saby_object" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_test_read_saby_object_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;
КонецФункции
// BSLLS:FunctionOutParameter-on
