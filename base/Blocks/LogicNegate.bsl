
// Функция block_logic_negate_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Булево - Результат обсчета алгоритма
//
//DynamicDirective
Функция block_logic_negate_calc_value(block_type, node, path, context, block_context)
	required_param = Новый Массив;
	required_param.Добавить("BOOL");
	block_check_required_param_in_block_context(required_param, block_context);	
	Возврат ?(ЗначениеЗаполнено(block_context["BOOL"]) и не (ТипЗнч(block_context["BOOL"]) = Тип("Булево") и не block_context["BOOL"]), Ложь, Истина);
КонецФункции
