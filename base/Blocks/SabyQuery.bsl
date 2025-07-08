
// Функция block_saby_query_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Произвольное - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
//DynamicDirective
Функция block_saby_query_calc_value(block_type, node, path, context, block_context)
	Если get_prop(block_context, "filter") <> Неопределено Тогда
		block_context.filter.Вставить("Тип", block_context["type"]);
	Иначе
		block_context.Вставить("filter", Новый Соответствие);
		block_context["filter"].Вставить("Тип", block_context["type"]);
	КонецЕсли;
	block_context["filter"].Вставить("Навигация", Новый Соответствие);
	Если get_prop(block_context, "limit") <> Неопределено Тогда
		block_context["filter"]["Навигация"].Вставить("РазмерСтраницы", block_context["limit"]);
	КонецЕсли;
	Если get_prop(block_context, "offset") <> Неопределено Тогда
		block_context["filter"]["Навигация"].Вставить("Страница", block_context["offset"]);
	КонецЕсли;
	result = ТранспортИнтеграции.local_helper_document_list(context.params, block_context["filter"]);
	Возврат result;
КонецФункции
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on

