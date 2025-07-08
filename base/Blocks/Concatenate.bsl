
// Функция block_concatenate_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Неопределено - Результат работы метода
//
//DynamicDirective
Функция block_concatenate_calc_value(block_type, node, path, context, block_context)
	prop_count = Число(workspace_find_mutation_by_name(node, "items", 0));
	Если prop_count > 0 Тогда
		separator = ?(block_context.SEPARATOR = "space", " ", block_context.SEPARATOR);
		result = "";
		Для счетчик = 0 По prop_count - 1 Цикл   
			prop = get_prop(block_context, "PROP" + счетчик, "");
			Если ТипЗнч(prop) = Тип("Число") Тогда 
				prop = Формат(prop, "ЧГ=");	
			КонецЕсли;
			Если ТипЗнч(prop) <> Тип("Строка") Тогда
				ВызватьИсключение NewExtExceptionСтрока(, "В блок concatenate передана не строка."); 
			КонецЕсли;	
			result = result + ?(счетчик = 0, "", separator) + prop;
		КонецЦикла;
		Возврат result;
	Иначе
		Возврат "";
	КонецЕсли;
КонецФункции
