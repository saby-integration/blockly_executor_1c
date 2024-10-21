//DynamicDirective
Функция block_saby_document_list_calc_value(block_type, node, path, context, block_context)
	ЕстьЕще = "Да";
	Навигация = get_prop(block_context.filter, "Навигация");
	Если Навигация = Неопределено Тогда
		Навигация = Новый Структура("РазмерСтраницы", 25);
	КонецЕсли;
	
	Если Не block_context.Свойство("ONEPAGE") и get_prop(Навигация, "Страница") <> Неопределено Тогда
		block_context.Вставить("ONEPAGE", Истина);
	ИначеЕсли Не block_context.Свойство("ONEPAGE") и get_prop(Навигация, "Страница") = Неопределено Тогда 
		block_context.Вставить("ONEPAGE", Ложь);	
	КонецЕсли;
	КонкретнаяСтраница = Ложь;
	Если get_prop(Навигация, "Страница") <> Неопределено Тогда
		КонкретнаяСтраница = Истина;
	КонецЕсли;
	
	Пока ЕстьЕще = "Да" Цикл
		Если Не block_context.Свойство("INDEX") Тогда
			block_context.Вставить("INDEX", 0);		
		КонецЕсли;
		
		block_context.filter.Вставить("Навигация", Навигация);
		
		result = Транспорт.local_helper_document_list(context.params, block_context.filter); 
		
		Список = result["Документ"];
	
		Пока block_context["INDEX"] < Список.Количество() Цикл
			ДочернийУзел = get_statement_node(node);
			Список[block_context["INDEX"]].Вставить("Навигация", result["Навигация"]);
			block_set_variable(context, block_context["NAME"], Список[block_context["INDEX"]]);
			block_execute_all_next(ДочернийУзел, path, context, block_context, True);
			block_context["INDEX"] = block_context["INDEX"] + 1;
		КонецЦикла;
		
		block_context["INDEX"] = 0;
		ЕстьЕще = result["Навигация"]["ЕстьЕще"];
		block_context["filter"]["Навигация"].Вставить("Страница", Число(result["Навигация"]["Страница"]) + 1);
		Если block_context["ONEPAGE"] Тогда
			Прервать;
		КонецЕсли;	
	КонецЦикла;
	Возврат Неопределено;
	
КонецФункции
