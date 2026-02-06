
// report_init
//
// Параметры:
//  operation - Строка - Операция
//  uuid - Строка - uuid
//  service - Строка - service
//	action_to_write - Массив - Действия для записи в ESD
//
// Возвращаемое значение:
//  - Структура - Результат обсчета алгоритма
//
Функция report_init(operation = Неопределено, uuid = Неопределено, service = Неопределено, Знач action_to_write = Неопределено)
	_report = Новый Структура("operation, service", operation, service);
    _report.Вставить("data", Новый Структура("params", Новый Структура));
	_report.Вставить("blockly_context", Неопределено);
	_report.Вставить("params", Новый Структура);
    _report.Вставить("objects_to_write", Новый Массив);
	Если action_to_write = Неопределено Тогда
		action_to_write = Новый Массив;
	КонецЕсли;	
	_report.Вставить("actions_to_write", action_to_write);
	Если Не ЗначениеЗаполнено(uuid) Тогда
		operation_uuid = Строка(Новый УникальныйИдентификатор());
		Если get_prop(_report.operation, "params") <> Неопределено Тогда   //дублирует report_read
			_report.Вставить("params", _report.operation.params);
		КонецЕсли;
		_report.Вставить("new", Истина);
	Иначе
		operation_uuid = uuid;
		_report.Вставить("new", Ложь);
	КонецЕсли;
	_report.Вставить("uuid", operation_uuid);
	Возврат _report
КонецФункции

// report_read
//
// Параметры:
//  Report - Структура - Report
//  Step - Строка - Step
//
Процедура report_read(Report, Step)
	Если ЗначениеЗаполнено(Step) Тогда
		Rep = ПрочитатьИзХранилища("Saby", "report");
		Если Rep <> Неопределено Тогда
			 Report = decode_xml_xdto(Rep);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

// BSLLS:CognitiveComplexity-off

//DynamicDirective

Процедура report_write_obj_action()
	Если НЕ context.report.new Тогда
		objects = get_prop(context.report, "objects_to_write", Новый Массив);
		Если objects.Количество() > 0 Тогда
			Попытка
				extsyncdoc_uuid = get_prop(context.operation, "operation_uuid", "");
				ПараметрыВызова = Новый Структура("Uuid", extsyncdoc_uuid);
				connection_uuid = get_prop(context.operation, "connection_uuid", "");
				// BSLLS:UnusedLocalVariable-off
				ПолученыйUuid = ТранспортИнтеграции.local_helper_extsyncdoc_write(
				context.params,
				connection_uuid,
				ПараметрыВызова,
				objects);
				// BSLLS:UnusedLocalVariable-on
			Исключение
				// BSLLS:UnusedLocalVariable-off
				ИнфОбОшибке = ИнформацияОбОшибке();
				// BSLLS:UnusedLocalVariable-on		
			КонецПопытки;				
		КонецЕсли;
		actions = get_prop(context.report, "actions_to_write", Новый Массив);
		Если actions.Количество() > 0 Тогда
			Попытка
				extsyncdoc_uuid = get_prop(context.operation, "operation_uuid", "");
				params = Новый Структура("ExtSyncDocUuid, Actions", extsyncdoc_uuid, actions);
				// BSLLS:UnusedLocalVariable-off
				РезультатЗаписиВЖурнал = ТранспортИнтеграции.local_helper_integration_api(context.params, "ExtSyncDoc.RegisterActions", params, "integration-sync");
				// BSLLS:UnusedLocalVariable-on
			Исключение
				// BSLLS:UnusedLocalVariable-off
				ИнфОбОшибке = ИнформацияОбОшибке();
				// BSLLS:UnusedLocalVariable-on		
			КонецПопытки;
		КонецЕсли;
	КонецЕсли;	
КонецПроцедуры	

//
//DynamicDirective

Процедура report_update()
	status = context.status;
	Попытка
		ИмяНастроек = НазваниеПродукта();
		Ini = ?(Ini = Неопределено, Неопределено, encode_xdto_xml(Ini));
		СуффиксХраненияИНИ = СтрЗаменить(context.params.api_url, "https://", "");
		ЗаписатьВХранилище(ИмяНастроек, "Ini" + СуффиксХраненияИНИ, Ini, , ИмяНастроек);
		ЗаписатьВХранилище(ИмяНастроек, "params", context.params);
		Если не (status = "complete" или status = "error") Тогда
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
	
	Если НЕ context.report.new И status = "complete" Тогда
		objects = get_prop(context.report, "objects_to_write", Новый Массив);
		Попытка
			extsyncdoc_uuid = get_prop(context.operation, "operation_uuid", "");
			ПараметрыВызова = Новый Структура("Uuid, Status", extsyncdoc_uuid, 21);
			connection_uuid = get_prop(context.operation, "connection_uuid", "");
			// BSLLS:UnusedLocalVariable-off
			ПолученыйUuid = ТранспортИнтеграции.local_helper_extsyncdoc_write(
						context.params,
						connection_uuid,
						ПараметрыВызова,
						objects);
			context.operation.Вставить("operation_uuid", ПолученыйUuid);
		
			// BSLLS:UnusedLocalVariable-on
		Исключение
			// BSLLS:UnusedLocalVariable-off
			ИнфОбОшибке = ИнформацияОбОшибке();
			// BSLLS:UnusedLocalVariable-on		
		КонецПопытки;
						
		actions = get_prop(context.report, "actions_to_write", Новый Массив);
		Если actions.Количество() > 0 Тогда
			Попытка
				extsyncdoc_uuid = get_prop(context.operation, "operation_uuid", "");
				Если Не ЗначениеЗаполнено(extsyncdoc_uuid) Тогда
					Возврат;
				КонецЕсли;
				params = Новый Структура("ExtSyncDocUuid, Actions", extsyncdoc_uuid, actions);
				// BSLLS:UnusedLocalVariable-off
				РезультатЗаписиВЖурнал = ТранспортИнтеграции.local_helper_integration_api(context.params, "ExtSyncDoc.RegisterActions", params, "integration-sync");
				// BSLLS:UnusedLocalVariable-on
			Исключение
				// BSLLS:UnusedLocalVariable-off
				ИнфОбОшибке = ИнформацияОбОшибке();
				// BSLLS:UnusedLocalVariable-on		
			КонецПопытки;
		КонецЕсли;
		
	КонецЕсли;
КонецПроцедуры

// BSLLS:CognitiveComplexity-on

//report_add_objects
//
// Параметры:
//  object - Структура - object
//
//DynamicDirective
Процедура report_add_objects(object)
	context.report.objects_to_write.Добавить(object);
	
	Если Не context.report.new И context.report.objects_to_write.Количество() > 20 Тогда
		Робот = get_prop(context.operation, "isRobot", Ложь);
		Data = ТранспортИнтеграции.local_helper_system_info(Робот);
				
		connection_uuid = get_prop(context.operation, "connection_uuid", "");
		extsyncdoc_uuid = get_prop(context.operation, "operation_uuid", "");
		ПараметрыВызова = Новый Структура("Uuid, Data", extsyncdoc_uuid, Data); //убрать дату, если будет работать без нее
		Попытка
			// BSLLS:UnusedLocalVariable-off	
			ПолученыйUuid = ТранспортИнтеграции.local_helper_extsyncdoc_write(
						context.params,
						connection_uuid,
						ПараметрыВызова,
						context.report.objects_to_write);
			context.operation.Вставить("operation_uuid", ПолученыйUuid);
			// BSLLS:UnusedLocalVariable-on		
		Исключение
			// BSLLS:UnusedLocalVariable-off
			ИнфОбОшибке = ИнформацияОбОшибке();
			// BSLLS:UnusedLocalVariable-on		
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

//report_add_actions
// Параметры:
//  action - Структура - action
//
//DynamicDirective
Процедура report_add_actions(action)

	context.report.actions_to_write.Добавить(action);
	Если Не context.report.new И context.report.actions_to_write.Количество() > 20 Тогда
		actions = context.report.actions_to_write;
		Попытка
			extsyncdoc_uuid = get_prop(context.operation, "operation_uuid", "");
			Если Не ЗначениеЗаполнено(extsyncdoc_uuid) Тогда
				Возврат;
			КонецЕсли;
			params = Новый Структура("ExtSyncDocUuid, Actions", extsyncdoc_uuid, actions);
			// BSLLS:UnusedLocalVariable-off
			РезультатЗаписиВЖурнал = ТранспортИнтеграции.local_helper_integration_api(context.params, "ExtSyncDoc.RegisterActions", params, "integration-sync");
			// BSLLS:UnusedLocalVariable-on
			context.report.actions_to_write = Новый Массив;
		Исключение
			// BSLLS:UnusedLocalVariable-off
			ИнфОбОшибке = ИнформацияОбОшибке();
			// BSLLS:UnusedLocalVariable-on
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры


