
// Функция block_logic_compare2_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Булево - Результат вычисления операции
//
// BSLLS:CognitiveComplexity-off
//DynamicDirective
Функция block_logic_compare2_calc_value(block_type, node, path, context, block_context)
	prop_count = 0;
	operation = block_context["OP"];
	required_param = Новый Массив;
	required_param.Добавить("OP");
	Для Каждого Элем Из block_context Цикл
		Если Найти(Элем.Ключ, "PARAM") Тогда
			required_param.Добавить(Элем.Ключ);
			prop_count = prop_count + 1;		
		КонецЕсли;
	КонецЦикла;	
	block_check_required_param_in_block_context(required_param, block_context);
	result = Неопределено;
	Для Каждого Элем Из required_param Цикл
		Если Элем <> "OP" Тогда
			block_b = ?(ЗначениеЗаполнено(block_context[Элем]) И НЕ (ТипЗнч(block_context[Элем]) = Тип("Булево") И НЕ block_context[Элем]), Истина, Ложь);
			Если result = Неопределено Тогда
				result = block_b;
			КонецЕсли;	
			Если operation = "AND" Тогда
				result = result И block_b;
			ИначеЕсли operation = "OR" Тогда
				result = result ИЛИ block_b;
			Иначе
				ВызватьИсключение operation + " не поддерживается";
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	Возврат result;
КонецФункции
// BSLLS:CognitiveComplexity-on
