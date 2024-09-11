
Процедура ПриЗапускеРобота(ПараметрыВызова)
	Попытка
		Step = ПараметрыВызова["current_block"];
		Selected = ПараметрыВызова["selected"];
	Исключение
	КонецПопытки;
	ПервыйЗапуск = Истина;
	Если ЗначениеЗаполнено(Step) Тогда
		ПервыйЗапуск = Ложь;			
	КонецЕсли;	
	Если Ini = Неопределено Тогда
		Ini = Новый Соответствие;
	КонецЕсли;	
	//Если context = Неопределено Или ПервыйЗапуск Тогда
	//	context = new_context();
	//КонецЕсли;
	//context.Вставить("commands", Новый Массив);
	//context.Вставить("limit_commands", 3);
	operation_uuid = "";
	connection_uuid	= "";
	//Если ТипЗнч(ПараметрыВызова) = Тип("Структура") или ТипЗнч(ПараметрыВызова) = Тип("Соответствие") Тогда
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
		report_read();
		
		context = BlocklyContext_init(Report.uuid, debug_mode, current_block, current_workspace, algorithm_name, algorithm_own, algorithm_file_type, , Report);
		
		BlocklyExecutor = blockly_executor_init(, , get_prop(ПараметрыВызова, "breakpoints", Новый Соответствие));
		
		context.Вставить("command_result", ПреобразоватьМассивСтруктурВСоответствие(get_prop(ПараметрыВызова, "commands_result"), "uuid"));
	//КонецЕсли;
	context.operation.Вставить("operation_uuid",operation_uuid);
	Попытка
		ИмяНастроек = ПолучитьИмяПродукта();
		//Заполняются параметры подключения по данным connection_uuid, запуск из редактора блоки
		params = ПрочитатьИзХранилища(ИмяНастроек, "params"+connection_uuid,,);
		Если params = Неопределено Тогда
			params = ПрочитатьИзХранилища(ИмяНастроек, "params",,);			
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
		connection_uuid = get_prop(context.params,"ConnectionId","");
	КонецЕсли;
	context.operation.Вставить("connection_uuid",connection_uuid);
	
КонецПроцедуры

Процедура ЗаписатьПараметрыРобота(ИмяРобота)
	ИмяНастроек = ПолучитьИмяПродукта();
	ХранилищеОбщихНастроек.Сохранить(ИмяНастроек, ИмяРобота, ПараметрыРобота,,);
КонецПроцедуры

Процедура ПрочитатьПараметрыРобота(ИмяРобота)
	ИмяНастроек = ПолучитьИмяПродукта();
	ПараметрыРобота = ПрочитатьИзХранилища(ИмяНастроек, ИмяРобота,,);		
КонецПроцедуры
