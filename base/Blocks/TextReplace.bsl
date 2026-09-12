
//DynamicDirective

Процедура ПроверкаТипСтрокаЧисло(ПроверяемыйПараметр)
	Если ТипЗнч(ПроверяемыйПараметр) = Тип("Строка") 
		Или ТипЗнч(ПроверяемыйПараметр) = Тип("Число") Тогда
		Возврат;
	КонецЕсли;
	ВызватьИсключение "Операция text_replace поддерживается только для строк и чисел";
КонецПроцедуры

// Функция block_text_replace_calc_value
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
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
//DynamicDirective
Функция block_text_replace_calc_value(block_type, node, path, context, block_context) 
	Попытка
		STR = block_context["STR"]; 
	Исключение    
		ВызватьИсключение "Не заполнен обязательный параметр STR";	
	КонецПопытки;	
	Попытка
		OLD = block_context["OLD"];
	Исключение 
		ВызватьИсключение "Не заполнен обязательный параметр OLD";		
	КонецПопытки;	
	Попытка
		NEW_STR = block_context["NEW"];
	Исключение 
		ВызватьИсключение "Не заполнен обязательный параметр NEW";		
	КонецПопытки;	
	Если STR = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;	
	ПроверкаТипСтрокаЧисло(STR);	
	ПроверкаТипСтрокаЧисло(OLD);	
	ПроверкаТипСтрокаЧисло(NEW_STR);	
	
	Возврат СтрЗаменить(STR, OLD, NEW_STR);		
КонецФункции	
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on
