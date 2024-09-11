
Процедура IniUpdate(_Ини) Экспорт
	УстановитьПривилегированныйРежим(Истина);
	ИмяПродукта = ПолучитьИмяПродукта();	
	Попытка
		_Ини["name"] = ?(Найти(_Ини["name"], "Blockly_") = 1, _Ини["name"], "Blockly_"+_Ини["name"]);
		Ini.Вставить(_Ини["name"], _Ини["value"]);
		_Ini = encode_xdto_xml(Ini);
		СуффиксХраненияИНИ = СтрЗаменить(context.params.api_url, "https://", "");
		ХранилищеОбщихНастроек.Сохранить(ИмяПродукта, "Ini"+СуффиксХраненияИНИ, _Ini,,ИмяПродукта);
	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
		ВызватьИсключение(NewExtExceptionСтрока(ИнфОбОшибке, "Ошибка кеширования ini", _Ини["name"]));
	КонецПопытки;
КонецПроцедуры

Функция IniGet(Имя) Экспорт
	Попытка
		Если get_prop(Ini, Имя) = Неопределено Тогда
			ВызватьИсключение NewExtExceptionСтрока(,"Отсутствует ини", Имя);
		КонецЕсли;
		Возврат Ini[Имя]; //todo если инишки нет вернуть исключение "че нить не найдено"	
	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
		ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке, "Ошибка чтения ini", "(" + Имя + ")");
	КонецПопытки;
КонецФункции

Функция CalcIni(ПараметрыВызова) Экспорт
	ДокDOM = ПолучитьДокументDOM(IniGet(ПараметрыВызова["algorithm"]));
	ОбновитьСтруктуру(context_variables_get(context), ПараметрыВызова);
	
	ОбщиеПараметры = get_prop(context.params,"public", Новый Структура);
	Если ТипЗнч(ОбщиеПараметры) = Тип("Структура") Тогда
		ОбновитьСтруктуру(context_variables_get(context), ОбщиеПараметры);
	КонецЕсли;
	
	РезультатРаботыБлока = blockly_executor_execute(ДокDOM, ПараметрыВызова["endpoint"]);
	Возврат РезультатРаботыБлока;
КонецФункции

Функция LocalCalcIni(ПараметрыВызова) Экспорт 
	ПрочитатьСессиюОтладки();
	ПриЗапускеРобота(ПараметрыВызова);
	Возврат ExternalCalcIni(ПараметрыВызова);
КонецФункции

Функция ExternalCalcIni(ПараметрыКоманды) 
	Если ТипЗнч(ПараметрыКоманды["params"]) = Тип("Структура") Тогда
		Load_ini( ПараметрыКоманды["algorithm"], ПараметрыКоманды);
		context.params = ПараметрыКоманды["params"];
	Иначе
		Load_ini( ПараметрыКоманды["algorithm"] );
	КонецЕсли;
	Результат = CalcIni(ПараметрыКоманды);
	
	Если не (Результат["status"] = "complete" или Результат["status"] = "error") Тогда
		СохранитьСессиюОтладки();
	Иначе
		ОчиститьСессиюОтладки();	
	КонецЕсли;
	Возврат Результат;
КонецФункции


Функция Load_ini( ИмяИни, ПараметрыПодключения = Неопределено ) Экспорт 
	ИмяИни = ?(Найти(ИмяИни, "Blockly_") = 1, ИмяИни, "Blockly_"+ИмяИни);
	
	Если Ini = Неопределено Тогда
		Ini = Новый Соответствие;
	ИначеЕсли ТипЗнч(Ini) = Тип("Строка") ТОгда
		//вторая и дальнейшие итерации вызова API_BLOCKLY_RUN,  По окончании которого СохранитьСессиюОтладки() превращает ini в XML строку
		Ini = decode_xml_xdto(Ini);       
	КонецЕсли;
	Если ТипЗнч(context) = Тип("Строка") Тогда
		//Раньше мы сохраняли контекст, теперь чистим его при завершении обсчета. Оставил для неведомой совместимости
		context = decode_xml_xdto(context);
	КонецЕсли;	
	Если get_prop(Ini, ИмяИни) = Неопределено Тогда
		мИниФайлов	= Новый Массив();
		мИниФайлов.Добавить(Новый Структура("type, name", "Blockly", ИмяИни));
		Если ПараметрыПодключения = Неопределено Тогда
			connection_uuid = context.operation.connection_uuid;
			Если НЕ ЗначениеЗаполнено(connection_uuid) Тогда
				connection_uuid = context.params.ConnectionId;
			КонецЕсли;	
		Иначе
			Если context = Неопределено ТОгда
				//Зашли при загрузке инишки из команды формы
				//перед вызовом - API_BLOCKLY_RUN
				context = new_context();
			КонецЕсли;
			context.Вставить("params", ПараметрыПодключения["params"] );
			connection_uuid = ПараметрыПодключения["connection_uuid"];
		КонецЕсли;
		params	= Новый Структура("props, ini",Новый Структура("id, type_data", connection_uuid, 1),мИниФайлов,);
		res = local_helper_integration_api(context.params, "IntegrationConnection.ReadConnection", params);
		Если (ТипЗнч(res) = Тип("Соответствие")) и (res.Получить("data") <> Неопределено) И (res["data"].Получить(ИмяИни) <> Неопределено) Тогда
			ДанныеОбИНИ = res["data"].Получить(ИмяИни);
			Если ТипЗнч(ДанныеОбИНИ) = Тип("Соответствие") И (ДанныеОбИНИ.Получить("data_name") = ИмяИни) Тогда 
				ДанныеИНИ = ДанныеОбИНИ.Получить("data");
				Если ТипЗнч(ДанныеИНИ) = Тип("Строка") И Не ПустаяСтрока(ДанныеИНИ) Тогда 
					Ini.Вставить( ИмяИни, ДанныеИНИ );
				Иначе
					ВызватьИсключение NewExtExceptionСтрока(,"Отсутствует ини файл - "+ ИмяИни, "Load_ini");
				КонецЕсли;
			Иначе
				ВызватьИсключение NewExtExceptionСтрока(,"Данные ини файла не соответсвтвую ожидаемым. - "+ ИмяИни, "Load_ini");
			КонецЕсли;
		Иначе
			ВызватьИсключение NewExtExceptionСтрока(,"Отсутствует ини файл - "+ ИмяИни, "Load_ini");
		КонецЕсли;
	КонецЕсли;
	Возврат Ini[ИмяИни];
КонецФункции

