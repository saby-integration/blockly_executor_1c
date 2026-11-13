
// Функция block_logic_operation_calc_value
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
// BSLLS:TernaryOperatorUsage-off
//DynamicDirective
Функция block_logic_operation_calc_value(block_type, node, path, context, block_context)
	param_A = get_prop(block_context, "A", Неопределено);
	param_B = get_prop(block_context, "B", Неопределено);
	required_param = Новый Массив;
	required_param.Добавить("OP");
	block_check_required_param_in_block_context(required_param, block_context);
	block_a = ?(ЗначениеЗаполнено(param_A) И Не (ТипЗнч(param_A) = Тип("Булево") И Не param_A), Истина, Ложь);
	block_b = ?(ЗначениеЗаполнено(param_B) И Не (ТипЗнч(param_B) = Тип("Булево") И Не param_B), Истина, Ложь); 
	operation = block_context["OP"];
	Если operation = "AND" Тогда
		Возврат ?(block_a И block_b, Истина, Ложь);
	ИначеЕсли operation = "OR" Тогда
		Возврат ?(block_a ИЛИ block_b, Истина, Ложь);
	Иначе
		ВызватьИсключение operation + " не поддерживается"
	КонецЕсли;	
КонецФункции
// BSLLS:TernaryOperatorUsage-on
