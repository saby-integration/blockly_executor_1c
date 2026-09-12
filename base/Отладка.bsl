
// СохранитьСессиюОтладки
//
//DynamicDirective
Процедура СохранитьСессиюОтладки()
	status = context.status;
	Попытка
		ИмяНастроек = НазваниеПродукта();
		Ini = ?(Ini = Неопределено, Неопределено, encode_xdto_xml(Ini));
		СуффиксХраненияИНИ = СтрЗаменить(context.params.ApiUrl, "https://", "");
		ЗаписатьВХранилище(ИмяНастроек, "Ini" + СуффиксХраненияИНИ, Ini, , ИмяНастроек);
		ЗаписатьВХранилище(ИмяНастроек, "params", context.params);
		Если Не (status = "complete" Или status = "error") Тогда
			Report.blockly_context = context.data;
			ЗаписатьВХранилище("Saby", "report", encode_xdto_xml(Report));
		Иначе
			ЗаписатьВХранилище("Saby", "report", Неопределено);
		КонецЕсли;	
	Исключение
// BSLLS:UnusedLocalVariable-off
// Нужно для отладки
		Ошибка = ОписаниеОшибки();
// BSLLS:UnusedLocalVariable-on	
	КонецПопытки;
    report_update(21);
КонецПроцедуры

// ОчиститьСессиюОтладки
//
//DynamicDirective
Процедура ОчиститьСессиюОтладки()
	Попытка
		ИмяНастроек = НазваниеПродукта();
		Ini = ?(Ini = Неопределено, Неопределено, encode_xdto_xml(Ini));
		СуффиксХраненияИНИ = СтрЗаменить(context.params.ApiUrl, "https://", "");
		ЗаписатьВХранилище(ИмяНастроек, "Ini" + СуффиксХраненияИНИ, Ini, , ИмяНастроек);
		ЗаписатьВХранилище(ИмяНастроек, "params", context.params);
		ЗаписатьВХранилище(ИмяНастроек, "context", Неопределено);
	Исключение
// BSLLS:UnusedLocalVariable-off
// Нужно для отладки
		Ошибка = ОписаниеОшибки();
// BSLLS:UnusedLocalVariable-on	
	КонецПопытки;	
КонецПроцедуры

// ПрочитатьСессиюОтладки
//
//DynamicDirective
Процедура ПрочитатьСессиюОтладки()
	Попытка
		ИмяНастроек = НазваниеПродукта();
		context = ПрочитатьИзХранилища(ИмяНастроек, "context");
		context_param	= ПрочитатьИзХранилища(ИмяНастроек, "params");
		СуффиксХраненияИНИ = СтрЗаменить(get_prop(context_param, "ApiUrl", ""), "https://", "");
		Ini = ПрочитатьИзХранилища(ИмяНастроек, "Ini" + СуффиксХраненияИНИ, , ИмяНастроек);
		Ini = ?(Ini = Неопределено, Неопределено, decode_xml_xdto(Ini));
		Если Ini = Неопределено Тогда
			Ini = Новый Соответствие;
		КонецЕсли;	
		Если context = Неопределено Тогда
			context = BlocklyContext_init();
		Иначе
			context = decode_xml_xdto(context);
		КонецЕсли;
		Если context_param = Неопределено Тогда
			context_param = новый Структура;
		КонецЕсли;
		context.Вставить("params", context_param); 
		
		extsyncdoc_uuid = get_prop(context.operation, "operation_uuid", "");
		Если Не ЗначениеЗаполнено(extsyncdoc_uuid) Тогда
			extsyncdoc_uuid = Строка(Новый УникальныйИдентификатор());
			context.operation.Вставить("operation_uuid", extsyncdoc_uuid);
		КонецЕсли;
		connection_uuid = get_prop(context.operation, "connection_uuid", "");
		Если Не ЗначениеЗаполнено(connection_uuid) Тогда
			connection_uuid = context.params.ConnectionUuid;
			context.operation.Вставить("connection_uuid", connection_uuid);
		КонецЕсли;		
	Исключение
// BSLLS:UnusedLocalVariable-off
// Нужно для отладки
		Ошибка = ОписаниеОшибки();
// BSLLS:UnusedLocalVariable-on	
	КонецПопытки;
КонецПроцедуры
