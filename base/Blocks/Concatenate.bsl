//DynamicDirective
Функция block_concatenate_calc_value(block_type, node, path, context, block_context)
	prop_count = 0;
	Для каждого элем из block_context Цикл
		Если Найти(элем.Ключ, "PROP") Тогда
			prop_count = prop_count + 1;
		КонецЕсли;
	КонецЦикла;
	Если prop_count > 0 Тогда
		separator = ?(block_context.SEPARATOR = "space", " ", block_context.SEPARATOR);
		result = block_context["PROP0"];
		Для элем = 1 По prop_count - 1 Цикл
			result = result + separator + block_context["PROP"+элем];
		КонецЦикла;
		Возврат result;
	Иначе
		Возврат "";
	КонецЕсли;
КонецФункции
