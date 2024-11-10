
//DynamicDirective
Процедура ЗаполнитьПубличныеПараметры(context)
	Если ЗначениеЗаполнено(block_obj_get_path_value(context, "variables.step","")) Тогда
		Возврат;
	КонецЕсли;	
	connection_uuid = block_obj_get_path_value(context,"operation.connection_uuid","");
	Если НЕ ЗначениеЗаполнено(connection_uuid) Тогда
		Возврат;
	КонецЕсли;	
	Версия = ПреобразоватьВерсию(ВерсияМетаданных());
	params = Новый Структура("id, Версия",connection_uuid,Версия);
	connection_info = local_helper_read_connection(context.params, params);
	context.operation.Вставить("data", connection_info["Data"]);	
КонецПроцедуры

//DynamicDirective
Процедура ЗаписатьПубличныеПараметры(context)
	update_public_params = block_obj_get_path_value(context, "operation.update_public_params","");
	Если update_public_params <> Неопределено Тогда
		connection_uuid = block_obj_get_path_value(context,"operation.connection_uuid","");
		Версия = ПреобразоватьВерсию(ВерсияМетаданных());
		params = Новый Структура("id, Версия",connection_uuid,Версия);
		connection_info = local_helper_read_connection(context.params, params);
		public_params = connection_info["Data"]["public_params"];
		Если public_params = Неопределено Тогда
			public_params = Новый Соответствие();
		КонецЕсли;
		ОбновитьСтруктуруРекурсивно(public_params, update_public_params);
		connection_info["Data"].Вставить("public_params", public_params);
		params = Новый Структура("props, ini", connection_info, Новый Массив);
		local_helper_write_connection(context.params, params)
	КонецЕсли;
	
КонецПроцедуры

