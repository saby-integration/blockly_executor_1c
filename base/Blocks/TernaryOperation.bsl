
// Функция block_ternary_operation_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Соответствие - Результат выполения функции
//
//DynamicDirective
Функция block_ternary_operation_calc_value(block_type, node, path, context, block_context)
	node_if = workspace_find_input_by_name(node, "CONDITION");
	Если node_if = Неопределено Тогда
		ВызватьИсключение "Bad " + "CONDITION" + path;
	КонецЕсли;	
	result = block_execute_all_next(node_if, path + "." + "condition", context, block_context);
	ВставитьСвойствоЕслиНет(block_context, "CONDITION", result);	
	condition = ?(ЗначениеЗаполнено(block_context["CONDITION"]) И НЕ (ТипЗнч(block_context["CONDITION"]) = Тип("Булево") И НЕ block_context["CONDITION"]), Истина, Ложь); 
	Если condition Тогда
		node_do = workspace_find_input_by_name(node, "TRUE_VALUE");
		Если node_do = Неопределено Тогда
			Возврат Неопределено;
		КонецЕсли;
		result = block_execute_all_next(node_do, path + "." + "true_value", context, block_context, True);
		Возврат result;
	Иначе
		node_do = workspace_find_input_by_name(node, "FALSE_VALUE");
		Если node_do = Неопределено Тогда
			Возврат Неопределено;
		КонецЕсли;	
		result = block_execute_all_next(node_do, path + "." + "false_value", context, block_context, True);
		Возврат result;
	КонецЕсли;
КонецФункции
