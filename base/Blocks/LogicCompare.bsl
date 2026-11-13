
// Функция block_logic_compare_calc_value
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
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:CognitiveComplexity-off
// BSLLS:TooManyReturns-off
// BSLLS:TernaryOperatorUsage-off
//DynamicDirective
Функция block_logic_compare_calc_value(block_type, node, path, context, block_context)
	param_A = get_prop(block_context, "A", Неопределено);
	param_B = get_prop(block_context, "B", Неопределено);
	
	required_param = Новый Массив;
	required_param.Добавить("OP");
	block_check_required_param_in_block_context(required_param, block_context);
	operation = block_context["OP"];

	Если operation = "EQ" Тогда
		Возврат ?(param_A = param_B, Истина, Ложь);
	ИначеЕсли operation = "GT" Тогда
		Возврат ?(param_A > param_B, Истина, Ложь);
	ИначеЕсли operation = "LT" Тогда
		Возврат ?(param_A < param_B, Истина, Ложь);
	ИначеЕсли operation = "GTE" Тогда
		Возврат ?(param_A >= param_B, Истина, Ложь);
	ИначеЕсли operation = "LTE" Тогда
		Возврат ?(param_A <= param_B, Истина, Ложь);
	ИначеЕсли operation = "NEQ" Тогда
		Возврат ?(param_A <> param_B, Истина, Ложь);
	Иначе
		ВызватьИсключение operation + " не поддерживается"
	КонецЕсли;	
КонецФункции
// BSLLS:TernaryOperatorUsage-on
// BSLLS:TooManyReturns-on
// BSLLS:CognitiveComplexity-on
