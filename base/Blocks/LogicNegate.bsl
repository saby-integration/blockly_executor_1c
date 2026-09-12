
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
// BSLLS:TernaryOperatorUsage-off
//DynamicDirective
Функция block_logic_negate_calc_value(block_type, node, path, context, block_context)
	BOOL = get_prop(block_context, "BOOL", Неопределено);
	Возврат ?(ЗначениеЗаполнено(BOOL) И Не (ТипЗнч(BOOL) = Тип("Булево") И Не BOOL), Ложь, Истина);
КонецФункции
// BSLLS:TernaryOperatorUsage-on
