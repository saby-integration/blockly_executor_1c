Функция block_lists_get_index_calc_value(block_type, node, path, context, block_context)
	array = block_get_variable(context, block_context["VAR"]);
	mode = block_context["MODE"];
	where = block_context["WHERE"];
	Если mode = "GET" Тогда
		if where = "FROM_START" Тогда
			Возврат array[block_context["AT"]];
		ИначеЕсли where = "FROM_END" Тогда
			ВызватьИсключение "В блоке get index не поддерживается "+ where
		ИначеЕсли where = "FIRST" Тогда
			Возврат array[0];
		ИначеЕсли where = "LAST" Тогда
			ВызватьИсключение "В блоке get index не поддерживается "+ where
		ИначеЕсли where = "RANDOM" Тогда
			ВызватьИсключение "В блоке get index не поддерживается "+ where
		Иначе
			ВызватьИсключение "В блоке get index не поддерживается "+ where
		КонецЕсли;	
	ИначеЕсли mode = "GET_REMOVE" Тогда
		ВызватьИсключение "В блоке get index не поддерживается "+ where
	ИначеЕсли mode = "REMOVE" Тогда
		ВызватьИсключение "В блоке get index не поддерживается "+ where
	Иначе
		ВызватьИсключение "В блоке get index не поддерживается "+ where
	КонецЕсли;	
КонецФункции
