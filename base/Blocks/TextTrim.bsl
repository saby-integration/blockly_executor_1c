
// Функция block_text_trim_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Строка - Результат обсчета алгоритма
//
//DynamicDirective
Функция block_text_trim_calc_value(block_type, node, path, context, block_context)
	mode = block_context["MODE"];
    Если mode = "BOTH" Тогда
        Результат = СокрЛП(block_context["TEXT"]);
    ИначеЕсли mode = "LEFT" Тогда
        Результат = СокрЛ(block_context["TEXT"]);
    ИначеЕсли mode = "RIGHT" Тогда
        Результат = СокрП(block_context["TEXT"]);
	Иначе
		Результат = block_context["TEXT"];	
    КонецЕсли;
    Возврат Результат;
КонецФункции	
