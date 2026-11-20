
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
	TEXT = get_prop(block_context, "TEXT"); 
	Если Не ТипЗнч(TEXT) = Тип("Строка") Тогда
		Возврат TEXT;
	КонецЕсли;	
    Если mode = "BOTH" Тогда
        Результат = СокрЛП(TEXT);
    ИначеЕсли mode = "LEFT" Тогда
        Результат = СокрЛ(TEXT);
    ИначеЕсли mode = "RIGHT" Тогда
        Результат = СокрП(TEXT);
	Иначе
		Результат = TEXT;	
    КонецЕсли;
    Возврат Результат;
КонецФункции	
