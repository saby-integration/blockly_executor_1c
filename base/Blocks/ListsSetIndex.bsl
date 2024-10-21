//DynamicDirective
Функция block_lists_set_index_calc_value(block_type, node, path, context, block_context)
	array = block_get_variable(context, block_context["VAR"]);
	mode = block_context["MODE"];
	where = block_context["WHERE"];
	Если mode = "SET" Тогда
		if where = "FROM_START" Тогда
			array.Вставить(block_context["AT"], block_context["TO"]);
			Возврат array;
		ИначеЕсли where = "FROM_END" Тогда
			ВызватьИсключение "В блоке set index не поддерживается "+ where
		ИначеЕсли where = "FIRST" Тогда
			array.Вставить(0, block_context["TO"]);
			Возврат array;
		ИначеЕсли where = "LAST" Тогда
			array.Добавить(block_context["TO"]);
			Возврат array;
		ИначеЕсли where = "RANDOM" Тогда
			ВызватьИсключение "В блоке set index не поддерживается "+ where
		Иначе
			ВызватьИсключение "В блоке set index не поддерживается "+ where
		КонецЕсли;	
	Иначе
		ВызватьИсключение "В блоке set index не поддерживается "+ where
	КонецЕсли;	
КонецФункции
