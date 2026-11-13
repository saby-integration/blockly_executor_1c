
// Функция block_math_change_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Неопределено - Результат вычисления операции
//
//DynamicDirective
Функция block_math_change_calc_value(block_type, node, path, context, block_context)
	var_name = get_prop(block_context, "VAR");
	num = block_get_variable(context, var_name);
	change = get_prop(block_context, "DELTA"); 
	Если ТипЗнч(num) <> Тип("Число") 
		Или ТипЗнч(change) <> Тип("Число") Тогда
			ТекстОшибки = "Поддерживается работа только с числами";
			ВызватьИсключение NewExtExceptionСтрока(, ТекстОшибки);		
	КонецЕсли;
	value = num + change;
	block_set_variable(context, var_name, value);
	Возврат value;
КонецФункции	
