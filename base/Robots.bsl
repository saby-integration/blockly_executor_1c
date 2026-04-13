
// Функция ********************************
//
// Параметры:
//  ПараметрыВызова - Структура - Параметры Вызова
//
//DynamicDirective
Процедура ПриЗапускеРобота(ПараметрыВызова)
	Попытка
		Step = ПараметрыВызова["CurrentBlock"];
// BSLLS:UnusedLocalVariable-off
// Переменная модуля
		Selected = ПараметрыВызова["selected"];
// BSLLS:UnusedLocalVariable-on
// BSLLS:MissingCodeTryCatchEx-off
	Исключение
		// Нужно выполнить код и не упасть
	КонецПопытки;
// BSLLS:MissingCodeTryCatchEx-on

// BSLLS:UnusedLocalVariable-off
// Переменная модуля
	ПервыйЗапуск = Истина;
	Если ЗначениеЗаполнено(Step) Тогда
		ПервыйЗапуск = Ложь;			
	КонецЕсли;	
	КэшОперации = Неопределено;
// BSLLS:UnusedLocalVariable-on
	Если Ini = Неопределено Тогда
		Ini = Новый Соответствие;
	КонецЕсли;	
	operation_uuid = "";
	connection_uuid	= "";

	operation_uuid = get_prop(ПараметрыВызова, "ContextId", Неопределено);
	connection_uuid = get_prop(ПараметрыВызова, "ConnectionId", Неопределено);
	Если connection_uuid = Неопределено Тогда
		connection_uuid = get_prop(context.operation, "connection_uuid", "");
	КонецЕсли;
	
	algorithm_name = get_prop(ПараметрыВызова, "Algorithm", Неопределено);
    algorithm_own = get_prop(ПараметрыВызова, "AlgorithmOwn", Неопределено);
	algorithm_file_type = get_prop(ПараметрыВызова, "AlgorithmFileType", "xml");

	debug_mode = get_prop(ПараметрыВызова, "DebugMode", Неопределено);
	current_block = get_prop(ПараметрыВызова, "CurrentBlock", Неопределено);
	Если current_block = Null Тогда
		current_block = Неопределено;	
	КонецЕсли;
	current_workspace = get_prop(ПараметрыВызова, "CurrentWorkspace", Неопределено);
	action_to_write = get_prop(ПараметрыВызова, "action_to_write", Новый Массив);
	
	operation = Новый Структура("uuid", connection_uuid);
	Report = report_init(operation, operation_uuid, , action_to_write, algorithm_name);
	Если Report.new Тогда
		data_to_write = Новый Структура;
		data_to_write.Вставить("AlgorithmUid", algorithm_name);
		data_to_write.Вставить("Endpoint", get_prop(ПараметрыВызова, "Endpoint"));
		data_to_write.Вставить("EndpointArgs", get_prop(ПараметрыВызова, "EndpointArgs"));
		Report.Вставить("data_to_write", data_to_write);
		Report.Вставить("data", data_to_write);
	Иначе
		report_read(Report, Step);
	КонецЕсли;
	
	context = BlocklyContext_init(Report.uuid, debug_mode, current_block, current_workspace, algorithm_name, algorithm_own, algorithm_file_type, , Report);
	// BSLLS:UnusedLocalVariable-off
	// Оставим BlocklyExecutor для дебага
	BlocklyExecutor = blockly_executor_init(
		,
		,
		get_prop(ПараметрыВызова, "Breakpoints", Новый Соответствие));
	// BSLLS:UnusedLocalVariable-on		
	
	context.Вставить("command_result", ПреобразоватьМассивСтруктурВСоответствие(get_prop(ПараметрыВызова, "CommandsResult"), "uuid"));

	context.operation.Вставить("operation_uuid", Report.uuid);
	Попытка
		ИмяНастроек = НазваниеПродукта();
		// Заполняются параметры подключения по данным connection_uuid, запуск из редактора блоки
		params = ПрочитатьИзХранилища(ИмяНастроек, "params"+connection_uuid);
		Если params = Неопределено Тогда
			params = ПрочитатьИзХранилища(ИмяНастроек, "params");			
		КонецЕсли;
		Если ЗначениеЗаполнено(params) Тогда
			Для Каждого КлючИЗначениеПараметр Из params Цикл
				context.params.Вставить(КлючИЗначениеПараметр.Ключ, КлючИЗначениеПараметр.Значение);
			КонецЦикла;
		КонецЕсли;	
	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
		ВызватьИсключение(NewExtExceptionСтрока(ИнфОбОшибке, "Ошибки подготовки параметров."));
	КонецПопытки;
	Если Не ЗначениеЗаполнено(connection_uuid) Тогда
		connection_uuid = get_prop(context.params, "ConnectionId", "");
	КонецЕсли;
	context.operation.Вставить("connection_uuid", connection_uuid);
	integration_id = get_prop(context.params, "Integration", "");
	context.operation.Вставить("integration_id", integration_id);
	Data = get_prop(ПараметрыВызова, "Data"); 
	public_params = get_prop(Data, "public_params"); 
	context.Вставить("Filter", get_prop(public_params, "Filter", Неопределено));
	context.Вставить("Endpoint", get_prop(Data, "Endpoint", Неопределено));
КонецПроцедуры

// Процедура ЗаписатьПараметрыРобота
//
// Параметры:
//  ИмяРобота - Строка - Имя Робота
//
//DynamicDirective
Процедура ЗаписатьПараметрыРобота(ИмяРобота)
	ИмяНастроек = ИмяПродукта();
	ЗаписатьВХранилище(ИмяНастроек, ИмяРобота, ПараметрыРобота);
КонецПроцедуры

// ПрочитатьПараметрыРобота
//
// Параметры:
//  ИмяРобота - Строка - Имя Робота
// 
// ПараметрыРобота - глобальная переменная
// BSLLS:UnusedLocalVariable-off
Процедура ПрочитатьПараметрыРобота(ИмяРобота)
	ИмяНастроек = ИмяПродукта();
	ПараметрыРобота = ПрочитатьИзХранилища(ИмяНастроек, ИмяРобота);		
КонецПроцедуры
// BSLLS:UnusedLocalVariable-on
