
// Функция block_saby_download_from_link_execute
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Неопределено - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
//DynamicDirective
Функция block_saby_download_from_link_execute(block_type, node, path, context, block_context)
	Попытка
		res = ТранспортИнтеграции.local_helper_download_from_link(context.params, block_context["link"]);
		Возврат Base64Строка(res);
	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
		ВызватьИсключение(NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context)));
	КонецПопытки;
КонецФункции

// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on
