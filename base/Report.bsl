
// report_init
//
// Параметры:
//  operation - Строка - Операция
//  uuid - Строка - uuid
//  service - Строка - service
//
// Возвращаемое значение:
//  - Структура - Результат обсчета алгоритма
//
Функция report_init(operation = Неопределено, uuid = Неопределено, service = Неопределено)
	_report = Новый Структура("operation, uuid, service", operation, uuid, service);
    _report.Вставить("data", Новый Структура("params", Новый Структура));
	_report.Вставить("blockly_context", Неопределено);
	_report.Вставить("params", Новый Структура);
    Возврат _report
КонецФункции

// report_read
//
// Параметры:
//  Report - Структура - Report
//  Step - Строка - Step
//
Процедура report_read(Report, Step)
	Если Report.uuid = Неопределено Тогда
		Report.uuid = Строка(Новый УникальныйИдентификатор());
		Если get_prop(Report.operation, "params") <> Неопределено Тогда
			Report.Вставить("params", Report.operation.params);
		КонецЕсли;
	КонецЕсли;
	Если ЗначениеЗаполнено(Step) Тогда
		blockly_context = ПрочитатьИзХранилища("Saby", "context");
		Если blockly_context <> Неопределено Тогда
			 blockly_context = decode_xml_xdto(blockly_context);
		КонецЕсли;
		Report.blockly_context = blockly_context;
	КонецЕсли;
КонецПроцедуры

// report_update
//
//DynamicDirective
Процедура report_update()
	ЗаписатьВХранилище("Saby", "context", encode_xdto_xml(context.data));
КонецПроцедуры
