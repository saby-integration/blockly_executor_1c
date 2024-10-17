
//DynamicDirective
Функция API_BLOCKLY_RUN_CLIENT(ПараметрыВызова) Экспорт
	Попытка
		ПрочитатьСессиюОтладки();
		ПриЗапускеРобота(ПараметрыВызова);
		Операция = get_prop(ПараметрыВызова, "ДлительнаяОперация", Неопределено);
		Если Операция <> Неопределено Тогда
			Если ДлитОперации = Неопределено Тогда
				ДлитОперации = Новый Соответствие();
			КонецЕсли;
			Если context.operation.operation_uuid <> Неопределено Тогда
				ДлитОперации.Вставить(context.operation.operation_uuid, Операция);
			КонецЕсли;
			ПараметрыВызова.Удалить("ДлительнаяОперация");
		КонецЕсли;
		Если Не ЗначениеЗаполнено(get_prop(ПараметрыВызова, "current_block")) Тогда
			Версия = ПреобразоватьВерсию(ВерсияМетаданных());
			id = ПараметрыВызова["connection_uuid"];
			params = Новый Структура("id, Версия",id,Версия);
			connection_info = local_helper_read_connection(context.params, params);
			context_variables_get(context).Вставить("_connection_public_params", connection_info["Data"]["public_params"]);
		КонецЕсли;
		Результат = ExternalCalcIni(ПараметрыВызова);  
		_connection_public_params = get_prop(Результат.data, "_connection_public_params");
		Если _connection_public_params <> Неопределено Тогда
			connection_info = local_helper_read_connection(context.params, params);
			public_params = connection_info["Data"]["public_params"];
			Если public_params = Неопределено Тогда
				public_params = Новый Соответствие();
			КонецЕсли;
			ОбновитьСтруктуруРекурсивно(public_params, _connection_public_params);
			connection_info["Data"].Вставить("public_params", public_params);
			params = Новый Структура("props, ini", connection_info, Новый Массив);
			local_helper_write_connection(context.params, params)
		КонецЕсли;
	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
		ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
		Возврат Новый структура("data, status", ОшибкаСтруктура, "error");
	КонецПопытки;
	Возврат Результат;
КонецФункции

Процедура API_CLEAR_HISTORY() Экспорт
	УстановитьПривилегированныйРежим(Истина);
	СервераСБИС		= СписокСерверовSaby();
	ИмяНастроек = ПолучитьИмяПродукта();
	Для Каждого АдресСбис Из СервераСБИС Цикл
		ХранилищеОбщихНастроек.Удалить(ИмяНастроек, "Ini"+АдресСбис.Значение, ИмяНастроек);
	КонецЦикла;
	ХранилищеОбщихНастроек.Удалить(ИмяНастроек, "context",);	
КонецПроцедуры	
