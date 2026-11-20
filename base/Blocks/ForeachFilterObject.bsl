
// Функция foreach_filter_object_get_items
//
// Параметры:
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Массив - Результат работы метода
//
//DynamicDirective
Функция foreach_filter_object_get_items(context, block_context)
	Если block_context.FILTER.Selection.MarkedAll Тогда
		ПараметрыКоманды = Новый Структура("Filter", block_context.FILTER);
		Pagination = Новый Структура();
		Pagination.Вставить("PageSize", 20);
		Pagination.Вставить("Page", block_context.page);  
		ПараметрыКоманды.Вставить("Pagination", Pagination);
		res = load_calc_ini(block_context.filter.Algorithm, ПараметрыКоманды, "main");
		Если res["Status"] = "error" Тогда
			ВызватьИсключение NewExtExceptionСтрока(, "Ошибка выполнения ini: '" + block_context.filter.Algorithm
					+ "', endpoint: 'main'" + Символы.ПС + res.Result.message,
				res.Result.detail, res.Result.action);
		КонецЕсли;	
		Результат = res.Result;
		Список = Результат["Rows"];
		Возврат Список;
	ИначеЕсли block_context.page = 0 Тогда
		Возврат block_context.FILTER.Selection.Marked;
	Иначе
		Возврат Новый Массив();
	КонецЕсли;
КонецФункции
