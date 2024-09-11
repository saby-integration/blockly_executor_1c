Функция block_lists_get_index_calc_value(block_type, node, path, context, block_context)
	array = block_get_variable(context, block_context["VAR"]);
	mode = block_context["MODE"];
	where = block_context["WHERE"];
	Если mode = "GET" Тогда
		if where = "FROM_START" Тогда
			Возврат array[block_context["AT"]];
		ИначеЕсли where = "FROM_END" Тогда
			ИндексЭлемента = block_context["AT"];
			Возврат array[array.Количество() - ИндексЭлемента];
		ИначеЕсли where = "FIRST" Тогда
			Возврат array[0];
		ИначеЕсли where = "LAST" Тогда
			Возврат array[array.Количество() - 1];
		ИначеЕсли where = "RANDOM" Тогда
			Гсч = Новый ГенераторСлучайныхЧисел();
			ИндексЭлемента = Гсч.СлучайноеЧисло(0, array.Количество() - 1);
			Возврат array[ИндексЭлемента];
		Иначе
			ВызватьИсключение "В блоке get index не поддерживается "+ where
		КонецЕсли;	
	ИначеЕсли mode = "GET_REMOVE" Тогда
		if where = "FROM_START" Тогда
			УдаленныйЭлемент = array[block_context["AT"]]; 
			array.Удалить(block_context["AT"]);
			Возврат УдаленныйЭлемент;
		ИначеЕсли where = "FROM_END" Тогда
			ИндексЭлемента = block_context["AT"];
			УдаленныйЭлемент = array[array.Количество() - ИндексЭлемента];	
			array.Удалить(array.Количество() - ИндексЭлемента);
			Возврат УдаленныйЭлемент;
		ИначеЕсли where = "FIRST" Тогда
			УдаленныйЭлемент = array[0];
			array.Удалить(0);
			Возврат УдаленныйЭлемент;
		ИначеЕсли where = "LAST" Тогда
			УдаленныйЭлемент = array[array.Количество() - 1];
			array.Удалить(array.Количество() - 1);
			Возврат УдаленныйЭлемент;
		ИначеЕсли where = "RANDOM" Тогда
			Гсч = Новый ГенераторСлучайныхЧисел();
			ИндексЭлемента = Гсч.СлучайноеЧисло(0, array.Количество() - 1);
			УдаленныйЭлемент = array[ИндексЭлемента];
			array.Удалить(ИндексЭлемента);
			Возврат УдаленныйЭлемент;
		Иначе
			ВызватьИсключение "В блоке get index не поддерживается "+ where
		КонецЕсли;
	ИначеЕсли mode = "REMOVE" Тогда
		if where = "FROM_START" Тогда
			array.Удалить(block_context["AT"]);
			Возврат array;
		ИначеЕсли where = "FROM_END" Тогда
			ИндексЭлемента = block_context["AT"];
			array.Удалить(array.Количество() - ИндексЭлемента);
			Возврат array;
		ИначеЕсли where = "FIRST" Тогда
			array.Удалить(0);
			Возврат array;
		ИначеЕсли where = "LAST" Тогда
			array.Удалить(array.Количество() - 1);
			Возврат array;
		ИначеЕсли where = "RANDOM" Тогда
			Гсч = Новый ГенераторСлучайныхЧисел();
			ИндексЭлемента = Гсч.СлучайноеЧисло(0, array.Количество() - 1);
			array.Удалить(ИндексЭлемента);
			Возврат array;
		Иначе
			ВызватьИсключение "В блоке get index не поддерживается "+ where
		КонецЕсли;
	Иначе
		ВызватьИсключение "В блоке get index не поддерживается "+ where
	КонецЕсли;	
КонецФункции
