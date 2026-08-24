
// Функция block_procedures_defnoreturn_execute
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
//DynamicDirective
Функция block_procedures_defnoreturn_execute(block_type, node, path, context, block_context)
	Если block_context.Свойство("_result") Тогда
		Возврат block_context["_result"];
	КонецЕсли;
	block_check_step(context, block_context);
	code = workspace_find_statement_by_name(node, "STACK");
	name = workspace_find_field_by_name(node, "NAME");
	Если НЕ block_context.Свойство("_stack") И ТипЗнч(code) = Тип("ЭлементDOM") Тогда
		block_execute_all_next(code, path + "." + name, context, block_context, Истина);	
		ВставитьСвойствоЕслиНет(block_context, "_stack", Неопределено);
	КонецЕсли;
	Возврат Неопределено;
КонецФункции
