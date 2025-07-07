
// Функция simple_block_execute_extsyncdoc
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
Функция simple_block_execute_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	result = Неопределено;
	Если block_type = "extsyncdoc_write" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsyncdoc_write_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsyncdoc_write2" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsyncdoc_write2_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "extsyncdoc_run" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsyncdoc_run_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsyncdoc_create" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsyncdoc_create_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsyncdoc_fillchangedsbisobjects" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_extsyncdoc_extsyncdoc_fillchangedsbisobjects_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "connection_public_param_update" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_connection_public_param_update_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "connection_public_param_read" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_connection_public_param_read_calc_value(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;
КонецФункции
// BSLLS:FunctionOutParameter-on

// Функция block_execute_core_extsyncdoc
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
Функция block_execute_core_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "saby_extsyncobj_list" Тогда
		result = block_multithreadloop_execute(block_type, node, path, context, block_context, Истина);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции
// BSLLS:FunctionOutParameter-on

// Функция block_execute_extsyncdoc
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
Функция block_execute_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;	
	Возврат result;	
КонецФункции
