
Функция API_ROBOT_RUN(ПараметрыВызова) Экспорт
	ПараметрыВызова.Параметры.Свойство("ИдСессии", ИдентификаторСессии);
	ПриЗапускеРобота(ПараметрыВызова);
	Если ПараметрыРобота = Неопределено Тогда
		ПараметрыРобота = ПараметрыВызова["Параметры"];
	КонецЕсли;
	ПараметрыЗапроса = Новый Структура("connection_uuid, operation_uuid, algorithm, commands_result, endpoint",
	ПараметрыВызова["connection_uuid"], Неопределено, ПараметрыВызова["algorithm"], Новый Массив, ПараметрыВызова["endpoint"]);
	Пока Истина Цикл
		РезультатЗапроса = IntegrationRobotRun(ПараметрыЗапроса);
		Если РезультатЗапроса["status"] <> "run"  Тогда
			Если РезультатЗапроса["status"] = "error" Тогда
				ВызватьИсключение РезультатЗапроса["data"];	
			КонецЕсли;
			Возврат РезультатЗапроса["data"];
		КонецЕсли;
		ПараметрыЗапроса["operation_uuid"] = РезультатЗапроса["operation_uuid"];
		ПараметрыЗапроса["commands_result"] = ОбработатьКоманды(РезультатЗапроса["commands"]);
		
	КонецЦикла;		
КонецФункции

Функция IntegrationRobotRun(ПараметрыВызова)
	Соединение = ПолучитьHTTPСоединение(Ложь, ПараметрыРобота["host"]);
	АдресРесурса = ПараметрыРобота["path"];
	Запрос = Новый Структура("connection_uuid, algorithm, operation_uuid, commands_result, endpoint",
	ПараметрыВызова["connection_uuid"], ПараметрыВызова["algorithm"], ПараметрыВызова["operation_uuid"], ПараметрыВызова["commands_result"], ПараметрыВызова["endpoint"]);	
	СтрокаТелаЗапроса = encode_xdto_xml(Запрос);
	ЗапросСервису = Новый HTTPЗапрос(АдресРесурса, СформироватьЗаголовкиЗапроса());
	Если СтрокаТелаЗапроса <> "" Тогда
		ЗапросСервису.УстановитьТелоИзСтроки(СтрокаТелаЗапроса);
	КонецЕсли;
	Попытка
		Ответ = Соединение.ОтправитьДляОбработки(ЗапросСервису);
	Исключение
		Ошибка = ОписаниеОшибки();
	КонецПопытки;	
	СтрокаОтвета = Ответ.ПолучитьТелоКакСтроку();
	Чтение = Новый ЧтениеXML;
	Чтение.УстановитьСтроку(СтрокаОтвета);
	РезультатЗапроса = decode_xml_xdto(СтрокаОтвета);
	Возврат РезультатЗапроса;
КонецФункции
