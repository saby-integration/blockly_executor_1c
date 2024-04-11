Функция ArrayHelper_find(items, value, field = "id")
	Для i = 0 по items.Количество() - 1 Цикл
		Если items[i][field] = value Тогда
			Возврат i;
		КонецЕсли;	
	КонецЦикла;	
	Возврат items.Количество() - 1;
КонецФункции	
