
// Функция block_math_arithmetic_calc_value
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
Функция block_math_arithmetic_calc_value(block_type, node, path, context, block_context)
	required_param = Новый Массив;
	required_param.Добавить("OP");
	required_param.Добавить("A");
	required_param.Добавить("B");
	block_check_required_param_in_block_context(required_param, block_context);
	operation = block_context["OP"];
	// BSLLS:TryNumber-off ПривестиЗначение не подходит - надо вызвать ошибку
	ЗначA = block_context["A"];
	ЗначB = block_context["B"];
	Попытка
		Если ТипЗнч(ЗначA) <> Тип("Дата") Тогда
			ЗначA = Число(ЗначA);
		КонецЕсли;	
		Если ТипЗнч(ЗначB) <> Тип("Дата") Тогда
			ЗначB = Число(ЗначB);
		КонецЕсли;	
	Исключение   
		ТекстОшибки = "Блок MathArithmetic производит операции только с числами. Переменную не удалось преобразовать к числу";
		ВызватьИсключение NewExtExceptionСтрока(, ТекстОшибки);		
	КонецПопытки;
	// BSLLS:TryNumber-on	
	Если operation = "ADD" Тогда
		Результат = ЗначA + ЗначB;
	ИначеЕсли operation = "MINUS" Тогда
		Результат = ЗначA - ЗначB;
	ИначеЕсли operation = "MULTIPLY" Тогда
		Результат = ЗначA * ЗначB;
	ИначеЕсли operation = "DIVIDE" Тогда
		Результат = ЗначA / ЗначB;
	ИначеЕсли operation = "POWER" Тогда
		Результат = Pow(ЗначA, ЗначB);
	Иначе
		ВызватьИсключение NewExtExceptionСтрока(, "В блоке MathArithmetic не реализована операция", operation);
	КонецЕсли;
	Возврат Результат;
КонецФункции	
