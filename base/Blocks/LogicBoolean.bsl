
// Функция block_logic_boolean_calc_value
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
Функция block_logic_boolean_calc_value(block_type, node, path, context, block_context)
	res = ?(block_context["BOOL"]="TRUE", Истина, Ложь);
	Возврат res;
КонецФункции
