
// Функция block_text_getSubstring_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  Строка - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
//DynamicDirective
Функция block_text_getSubstring_calc_value(block_type, node, path, context, block_context)
	result = "";
	where1 = block_context["WHERE1"];
	where2 = block_context["WHERE2"];
	Если where1 = "FIRST" Тогда
		Если where2 = "FROM_START" Тогда
			result = Лев(block_context["STRING"], block_context["AT2"]);
		Иначе
			ВызватьИсключение "В блоке text_getSubstring where1 = FIRST не поддерживается " + where2
		КонецЕсли
	ИначеЕсли where1 = "FROM_START" Тогда
		Если where2 = "FROM_START" Тогда
			result = Сред(block_context["STRING"], block_context["AT1"], block_context["AT2"]);
		ИначеЕсли where2 = "LAST" Тогда
			result = Сред(block_context["STRING"], block_context["AT1"]);
		Иначе
			ВызватьИсключение "В блоке text_getSubstring where1 = FROM_START не поддерживается " + where2
		КонецЕсли
	Иначе
		ВызватьИсключение "В блоке text_getSubstring не поддерживается " + where1
	КонецЕсли;
	
	Возврат result;
КонецФункции
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on
