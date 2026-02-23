
// report_init
//
// Параметры:
//  operation - Строка - Операция
//  uuid - Строка - uuid
//  service - Строка - service
//	action_to_write - Массив - Действия для записи в ESD
//  algorithm_name - Строка - Название алгоритма
//
// Возвращаемое значение:
//  - Структура - Результат обсчета алгоритма
//
// BSLLS:NumberOfOptionalParams-off
// BSLLS:DuplicateStringLiteral-off
Функция report_init(operation = Неопределено, uuid = Неопределено, service = Неопределено,
		Знач action_to_write = Неопределено, algorithm_name = "")
	_report = Новый Структура("operation, service", operation, service);
	_data = Новый Структура("params", Новый Структура);
	_data.Вставить("AlgorithmUid", algorithm_name);
    _report.Вставить("data", _data);
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
// BSLLS:DuplicateStringLiteral-on
// BSLLS:NumberOfOptionalParams-on

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

//DynamicDirective

Функция extsyncdoc_params(status_esd = Неопределено)
	Робот = get_prop(context.operation, "isRobot", Ложь);
	Data = ТранспортИнтеграции.local_helper_system_info(Робот);
	
	extsyncdoc_uuid = get_prop(report, "uuid", "");
	direction = get_prop(context.report, "direction", 1);
	ПараметрыВызова = Новый Структура("Uuid, Data, Direction", extsyncdoc_uuid, Data, direction);
	Если status_esd <> Неопределено Тогда
		ПараметрыВызова.Вставить("Status", status_esd);
    КонецЕсли;  
	Возврат ПараметрыВызова;	
КонецФункции

//DynamicDirective

Процедура report_update()
	status = context.status;
	
	Если Не context.report.new И status = "complete" Тогда
		status_esd = 21;
		extsyncdoc_uuid = get_prop(context.report, "uuid", "");
		ИмяФоновогоЗадания = "Saby Выполнить обмен " + extsyncdoc_uuid; 
		Если ВозможностьЗапускаФоновогоЗадания() 
			И ФоновоеЗаданиеВыполняется(ИмяФоновогоЗадания) Тогда
			ОжиданиеОкончанияФоновоеЗадание(ИмяФоновогоЗадания);
		КонецЕсли;
		_ПараметрыESD = extsyncdoc_params(status_esd);
		// Перенесем данные из контекста в ESD.Data
		_Источник = context["report"]["data"];
		_Приемник = _ПараметрыESD["Data"];
		ОбновитьСтруктуруРекурсивно(_Приемник, _Источник);
		report_write_objects(_ПараметрыESD);
		report_write_actions();
	КонецЕсли;
КонецПроцедуры

//DynamicDirective

Процедура report_add_objects(objects, run = Ложь)
	Если ТипЗнч(objects) = Тип("Массив") Тогда
        ИнтеграцияДополнитьМассив(context.report.objects_to_write, objects);
    Иначе
        context.report.objects_to_write.Добавить(objects);
    КонецЕсли;    
	Если Не context.report.new И context.report.objects_to_write.Количество() > 20 Тогда
		report_write_objects(extsyncdoc_params(), run);
	КонецЕсли;
КонецПроцедуры

//DynamicDirective

Процедура report_write_objects(extsyncdoc_params, run = Ложь)
	 //убрать дату, если будет работать без нее
	connection_uuid = get_prop(report.operation, "uuid", "");
	Попытка
		// BSLLS:UnusedLocalVariable-off	
		ПолученыйUuid = ТранспортИнтеграции.local_helper_extsyncdoc_write(
								context.params,
								connection_uuid,
								extsyncdoc_params,
								context.report.objects_to_write);
		context.report.objects_to_write = Новый Массив;	
		// BSLLS:UnusedLocalVariable-on		
	Исключение
		// BSLLS:UnusedLocalVariable-off
		ИнфОбОшибке = ИнформацияОбОшибке();
		// BSLLS:UnusedLocalVariable-on		
	КонецПопытки;
	extsyncdoc_uuid = get_prop(report, "uuid", "");
	#Если Сервер Тогда
	Если run Тогда  
		extsyncdoc_uuid = get_prop(report, "uuid", "");
		ПараметрыФоновогоЗадания = Новый Структура;
        ПараметрыФоновогоЗадания.Вставить("context", context);
		ИмяФоновогоЗадания = "Saby Выполнить обмен " + extsyncdoc_uuid; 
        Если ВозможностьЗапускаФоновогоЗадания() И Не ФоновоеЗаданиеВыполняется(ИмяФоновогоЗадания) Тогда 
            ПараметрыФоновогоЗадания.Вставить("ОтображатьПрогрессВыполнения", Ложь);
            ЗапуститьДлительнуюОперацию("block_extsyncdoc_write_run", ИмяФоновогоЗадания, ПараметрыФоновогоЗадания, context);  
        КонецЕсли;    
	КонецЕсли;
	#КонецЕсли
КонецПроцедуры

//DynamicDirective

Процедура report_write_actions()
	actions = get_prop(context.report, "actions_to_write", Новый Массив);
	Если actions.Количество() > 0 Тогда
		Попытка
			extsyncdoc_uuid = get_prop(report, "uuid", "");
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
КонецПроцедуры

//report_add_actions
// Параметры:
//  action - Структура - action
//
//DynamicDirective
Процедура report_add_actions(action)

	context.report.actions_to_write.Добавить(action);
	Если Не context.report.new И context.report.actions_to_write.Количество() > 20 Тогда
		report_write_actions();
	КонецЕсли;
	
КонецПроцедуры


