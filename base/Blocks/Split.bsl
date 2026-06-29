
// Функция block_split_calc_value
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
Функция block_split_calc_value(block_type, node, path, context, block_context)
	value = get_prop(block_context, "value");
	Если ТипЗнч(value) = Тип("Строка") Тогда
		value = СтрРазделить82(value, block_context["delimiter"], Ложь);
	Иначе
		ВызватьИсключение NewExtExceptionСтрока(, "Ошибка в блоке", "В блок split передана не строка");
	КонецЕсли;	
	Возврат value;	
КонецФункции	
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on
