
// Функция block_saby_document_list_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Неопределено - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:FunctionOutParameter-off
// BSLLS:IfElseIfEndsWithElse-off
//DynamicDirective
Функция block_saby_document_list_calc_value(block_type, node, path, context, block_context)
	ЕстьЕще = "Да";
	Навигация = Неопределено;
	НавигацияВСобытияхСаби(ЕстьЕще, block_context, Навигация);
	Результат = ОбработкаСобытийСаби("Документ", "SabyDocumentList", ЕстьЕще, Навигация, node, path, context, block_context);
	Возврат Результат;	
КонецФункции
// BSLLS:FunctionOutParameter-on
// BSLLS:IfElseIfEndsWithElse-on
