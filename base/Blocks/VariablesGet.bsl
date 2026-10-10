
// Функция block_variables_get_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Произвольный - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
//DynamicDirective
Функция block_variables_get_calc_value(block_type, node, path, context, block_context)
	required_param = новый массив;
	required_param.Добавить("VAR");
	block_check_required_param_in_block_context(required_param, block_context);
	Попытка
		Возврат block_get_variable(context, block_context["VAR"]);
	Исключение
		ВызватьИсключение "Переменная " + block_context["VAR"] + " не определена"
	КонецПопытки
КонецФункции
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on
