
//DynamicDirective
Процедура СохранитьСессиюОтладки()
	Попытка
		ИмяНастроек = ПолучитьИмяПродукта();
		Ini = ?(Ini = Неопределено, Неопределено, encode_xdto_xml(Ini));
		СуффиксХраненияИНИ = СтрЗаменить(context.params.api_url, "https://", "");
		ЗаписатьВХранилище(ИмяНастроек, "Ini"+СуффиксХраненияИНИ, Ini,,ИмяНастроек);
		ЗаписатьВХранилище(ИмяНастроек, "params", context.params,,);
		//context.удалить("params");
		//context = ?(context = Неопределено, Неопределено, encode_xdto_xml(context));
		//ХранилищеОбщихНастроек.Сохранить(ИмяНастроек, "context", context,,);
		report_update();
	Исключение
		Ошибка = ОписаниеОшибки();
	КонецПопытки;	
КонецПроцедуры

//DynamicDirective
Процедура ОчиститьСессиюОтладки()
	Попытка
		ИмяНастроек = ПолучитьИмяПродукта();
		Ini = ?(Ini = Неопределено, Неопределено, encode_xdto_xml(Ini));
		СуффиксХраненияИНИ = СтрЗаменить(context.params.api_url, "https://", "");
		ЗаписатьВХранилище(ИмяНастроек, "Ini"+СуффиксХраненияИНИ, Ini,,ИмяНастроек);
		ЗаписатьВХранилище(ИмяНастроек, "params", context.params,,);
		ЗаписатьВХранилище(ИмяНастроек, "context", Неопределено,,);
	Исключение
		Ошибка = ОписаниеОшибки();
	КонецПопытки;	
КонецПроцедуры

//DynamicDirective
Процедура ПрочитатьСессиюОтладки()
	Попытка
		ИмяНастроек = ПолучитьИмяПродукта();
		context = ПрочитатьИзХранилища(ИмяНастроек, "context",,);
		context_param	= ПрочитатьИзХранилища(ИмяНастроек, "params",,);
		СуффиксХраненияИНИ = СтрЗаменить(get_prop(context_param, "api_url", ""), "https://", "");
		Ini = ПрочитатьИзХранилища(ИмяНастроек, "Ini"+СуффиксХраненияИНИ,,ИмяНастроек);
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
		
		extsyncdoc_uuid = get_prop(context.operation,"operation_uuid","");
		Если Не ЗначениеЗаполнено(extsyncdoc_uuid) Тогда
			extsyncdoc_uuid = Строка(Новый УникальныйИдентификатор());
			context.operation.Вставить("operation_uuid", extsyncdoc_uuid);
		КонецЕсли;
		connection_uuid = get_prop(context.operation,"connection_uuid","");
		Если Не ЗначениеЗаполнено(connection_uuid) Тогда
			connection_uuid = context.params.ConnectionId;
			context.operation.Вставить("connection_uuid", connection_uuid);
		КонецЕсли;		
	Исключение
		Ошибка = ОписаниеОшибки();
	КонецПопытки;
КонецПроцедуры
