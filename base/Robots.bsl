
// Функция ********************************
//
// Параметры:
//  ПараметрыВызова - Структура - Параметры Вызова
//
//DynamicDirective
Процедура ПриЗапускеРобота(ПараметрыВызова)
	Попытка
		Step = ПараметрыВызова["current_block"];
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
// BSLLS:UnusedLocalVariable-on
	Если Ini = Неопределено Тогда
		Ini = Новый Соответствие;
	КонецЕсли;	
	operation_uuid = "";
	connection_uuid	= "";
	// Если ТипЗнч(ПараметрыВызова) = Тип("Структура") или ТипЗнч(ПараметрыВызова) = Тип("Соответствие") Тогда
		operation_uuid = get_prop(ПараметрыВызова, "operation_uuid", Неопределено);
		Если Не ЗначениеЗаполнено(operation_uuid) Тогда
			operation_uuid = Строка(Новый УникальныйИдентификатор());
		КонецЕсли;
		connection_uuid = get_prop(ПараметрыВызова, "connection_uuid", Неопределено);
		
		algorithm_name = get_prop(ПараметрыВызова, "algorithm", Неопределено);
        algorithm_own = get_prop(ПараметрыВызова, "algorithm_own", Неопределено);
		algorithm_file_type = get_prop(ПараметрыВызова, "algorithm_file_type", "xml");
		uid = get_prop(ПараметрыВызова, "uid", Неопределено);
		Если uid = Null Тогда
			uid = Неопределено;	
		КонецЕсли;
		debug_mode = get_prop(ПараметрыВызова, "debug_mode", Неопределено);
		current_block = get_prop(ПараметрыВызова, "current_block", Неопределено);
		Если current_block = Null Тогда
			current_block = Неопределено;	
		КонецЕсли;
		current_workspace = get_prop(ПараметрыВызова, "current_workspace", Неопределено);
		
		operation = Новый Структура("uuid", operation_uuid);
		Report = report_init(operation, uid);
		report_read(Report, Step);
		
		context = BlocklyContext_init(Report.uuid, debug_mode, current_block, current_workspace, algorithm_name, algorithm_own, algorithm_file_type, , Report);
		// BSLLS:UnusedLocalVariable-off
		// Оставим BlocklyExecutor для дебага
		BlocklyExecutor = blockly_executor_init(
			,
			,
			get_prop(ПараметрыВызова, "breakpoints", Новый Соответствие));
		// BSLLS:UnusedLocalVariable-on		
		
		context.Вставить("command_result", ПреобразоватьМассивСтруктурВСоответствие(get_prop(ПараметрыВызова, "commands_result"), "uuid"));
	// КонецЕсли;
	context.operation.Вставить("operation_uuid",operation_uuid);
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
