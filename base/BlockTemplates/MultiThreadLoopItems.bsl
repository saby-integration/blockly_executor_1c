
// функция для расчета следующего блока
//
// Параметры:
// block_type - Строка - Название блока
// node - XML - Текущий обрабатываемый узел XML
// path - Строка - Абсолютный путь до исполняемого блока
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
// statement - Булево - Дополнительные параметры расчёта блока
//
// Возвращаемое значение:
//  Неопределено - Результат успешного выполения функции
//
//DynamicDirective
Функция  block_multithreadloop_execute_item(block_type, node, path, context, block_context, statement=False)
	Если block_type = "saby_read_changes" Тогда
		saby_read_changes_execute_item(node, path, context, block_context);
	Иначе	
		Block_execute_all_next(node, path, context, block_context, statement);
	КонецЕсли;
	Возврат Неопределено;
КонецФункции

// функция-хаб для получения массива итерируемых значений с общими входными параметрами, 
// но постраничной ориентацией внутри единого цикла
//
// Параметры:
// block_type - Строка - Название блока
// node_loop - Массив - Текущий обрабатываемый узел XML
// path - Строка - Абсолютный путь до исполняемого блока
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
// local_context - Соответствие - Контекст обрабатываемго массива
//
// Возвращаемое значение:
//  Неопределено - Результат успешного выполения функции
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
// BSLLS:IfElseIfEndsWithElse-off
//DynamicDirective
Функция  block_multithreadloop_execute_get_items(block_type, node_loop, path, context, block_context, local_context)
	Если block_type = "saby_read_changes" Тогда
        block_context.Вставить("items", saby_read_changes_get_items(context, block_context));
	ИначеЕсли block_type = "saby_extsyncobj_list" Тогда
        block_context.Вставить("items", saby_extsyncobj_list_items(context, block_context));
	ИначеЕсли block_type = "saby_task_list" Тогда
        block_context.Вставить("items", saby_task_list_items(context, block_context));
	ИначеЕсли block_type = "accounting_entries_list" Тогда
        block_context.Вставить("items", accounting_entries_list_items(context, block_context, local_context));
	ИначеЕсли block_type = "accounting_entries_list2" Тогда
        block_context.Вставить("items", accounting_entries_list2_items(context, block_context, local_context));
	ИначеЕсли block_type = "controls_forEachAsync" Тогда
        block_context.Вставить("items", controls_forEachAsync_get_items(context, block_context));
	ИначеЕсли block_type = "foreach_filter_object" Тогда
        block_context.Вставить("items", foreach_filter_object_get_items(context, block_context));
	КонецЕсли;
	Возврат Неопределено;
КонецФункции
// BSLLS:IfElseIfEndsWithElse-on
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on
