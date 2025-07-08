
// Функция block_procedures_callnoreturn_execute
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Соответствие - результат работы workspace_find_next_statement
//
// BSLLS:UnusedLocalVariable-off
//DynamicDirective
Функция block_procedures_callnoreturn_execute(block_type, node, path, context, block_context)
	// Для отладки
	result = block_procedures_callreturn_execute(block_type, node, path, context, block_context);
	Возврат workspace_find_next_statement(node);
КонецФункции	
// BSLLS:UnusedLocalVariable-on
