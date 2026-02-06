
// Функция block_lists_length_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Число - Размер массива
//
//DynamicDirective
Функция block_lists_length_calc_value(block_type, node, path, context, block_context)
	value = get_prop(block_context, "value");
	Попытка 
		length = value.Количество();
	Исключение  
		length = 0;
	КонецПопытки;
	Если ТипЗнч(value) = Тип("Структура") 
		Или ТипЗнч(value) = Тип("Соответствие") Тогда
		length = 0;
	КонецЕсли;	
	Возврат length;		
КонецФункции	
