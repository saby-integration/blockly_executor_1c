
// Функция block_text_length_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  Число - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
//DynamicDirective
Функция block_text_length_calc_value(block_type, node, path, context, block_context)
	value = block_context["VALUE"]; 
	Результат = Неопределено;
	Если ТипЗнч(value) = Тип("Строка") Тогда
		Результат = СтрДлина(value);
	ИначеЕсли ТипЗнч(value) = Тип("Число") Тогда
		value = Формат(value, "ЧГ=");
		Результат = СтрДлина(Строка(value));
	ИначеЕсли ТипЗнч(value) = Тип("Массив") ИЛИ ТипЗнч(value) = Тип("Структура") ИЛИ ТипЗнч(value) = Тип("Соответствие") Тогда
		Результат = value.Количество();
	Иначе
		Ошибка = "Невозможно вычислить длину значения";
		ВызватьИсключение Ошибка;
	КонецЕсли;
	Возврат Результат;
КонецФункции	
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on
