
//DynamicDirective

Функция block_multithread_load_thread(uuid_deferred, context, block_context)    
	
	Попытка
		deferred_index = helper_find_in_array(context.deferred, uuid_deferred, "__deferred");	
	Исключение   
		ВызватьИсключение NewExtExceptionСтрока(, "Deferred not found",,, "Exception");
	КонецПопытки;
	deferred = context.deferred[deferred_index];
	
	context.variable_scopes = Saby_КопияМассива(context.variable_scopes, , context.variable_scope_deferred_index);
		
	Для Каждого Запись Из deferred["variable_scopes"] Цикл  
		context.variable_scopes.Добавить(Запись);	
	КонецЦикла;	
	
	Для Каждого variable_outside Из context.block_context["__variables_outside_deferred"] Цикл 
		context.variable_scopes[context.variable_scope_deferred_index].Вставить(variable_outside.Ключ, variable_outside.Значение);			
	КонецЦикла;
	
	block_context.Вставить("__child", get_prop(deferred["block_context"], "__child")); 	
	
	Возврат deferred["block_context"];
	        
КонецФункции

//DynamicDirective

Процедура block_multithread_mode_begin(context, block_context)  
	deferred_count = get_prop(block_context, "__deferred_count");
	Если deferred_count = Неопределено Тогда 
		variable_scope_deferred_index  = get_prop(context, "variable_scope_deferred_index");
		Если variable_scope_deferred_index <> Неопределено Тогда
			ВызватьИсключение NewExtExceptionСтрока(, "Вложенные multi_thread циклы не поддерживаются");
		КонецЕсли;
		block_context.Вставить("__deferred_count", 0);
		context.block_context.Вставить("__variables_outside_deferred", Saby_КопияСтруктуры(context.variable_scopes[context.variable_scope_current]));
	КонецЕсли;	
	context.variable_scope_deferred_index = context.variable_scope_current;
КонецПроцедуры

//DynamicDirective

Процедура block_multithread_mode_end(context)  
	Для Каждого variable_outside Из context.block_context["__variables_outside_deferred"] Цикл 
		context.variable_scopes[context.variable_scope_deferred_index].Вставить(variable_outside.Ключ, variable_outside.Значение);			
	КонецЦикла;

	context.variable_scope_deferred_index = Неопределено; 
КонецПроцедуры

// Процедура block_multithreadloop_switch_multithread_mode
//
// Параметры:
// context - Соответствие - Контекст исполняемого блока
// block_type - Строка - Название блока
// block_context - Соответствие - Контекст текущего выполняемого блока
// multithread_mode - Булево - Признак многопоточной обработки
//
//DynamicDirective
Процедура block_multithreadloop_switch_multithread_mode(context, block_type, block_context, multithread_mode)
	Если Не context.Свойство("limit_request") Тогда 
		context.Вставить("limit_request", 10);
	КонецЕсли;
	Возврат;
	context_multithread_mode = get_prop(context,"multithread_mode",Ложь);
	Если context_multithread_mode = Истина 
		И multithread_mode = Истина Тогда
		context.Вставить("multithread_mode",Ложь);
		ТекстОшибки = "Вложенный вызов ассинхронного блока. Необходимо использовать другой блок или изменить алгоритм";
		ВызватьИсключение NewExtExceptionСтрока(,ТекстОшибки,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context));
	КонецЕсли;
	Если multithread_mode = Истина Тогда
		context.Вставить("multithread_mode",Истина);
	КонецЕсли;	
КонецПроцедуры

// Функция block_multithreadloop_execute
//
// Параметры:
// block_type - Строка - Название блока
// node - XML - Текущий обрабатываемый узел XML
// path - Строка - Абсолютный путь до исполняемого блока
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
// multithread_mode - Булево - Признак многопоточной обработки
//
// Возвращаемое значение:
//  Структура - Результат выполения функции
//
//DynamicDirective
Функция block_multithreadloop_execute(block_type, node, path, context, block_context, multithread_mode = Ложь)
	block_multithreadloop_switch_multithread_mode(context, block_type, block_context, multithread_mode);
	block_multithread_mode_begin(context, block_context);
	Если context.is_deferred = Неопределено Тогда
		Возврат block_multithreadloop_wait_async_request(block_type, node, path, context, block_context);
	КонецЕсли;	
	deferred_block_context = block_multithread_load_thread(context.is_deferred, context, block_context);
	node_loop = node.ДочерниеУзлы[1];
	block_multithreadloop_on_loop(block_type, node, path, context, deferred_block_context);
	Пока Истина Цикл
		Попытка 
			block_multithreadloop_execute_item(block_type, node_loop, path+".0_"+block_context["index"], context, deferred_block_context, Истина);
			context_set_step(block_context.__id);
		Исключение   
			ИнфОбОшибке = ИнформацияОбОшибке();
			ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
			Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
				Если ОшибкаСтруктура.type = "AsyncRequest" Тогда 
					context["limit_request"] = context["limit_request"] - 1;
					context_add_request(ОшибкаСтруктура, block_context);
				ИначеЕсли ОшибкаСтруктура.type = "DeferredOperation" Тогда 
					dump = get_prop(ОшибкаСтруктура, "dump", Новый Структура);
					dump.Вставить("multi_thread_loop_block_context", deferred_block_context);	
					dump.Вставить("multi_thread_loop_variable_scopes", Saby_КопияМассива(context.variable_scopes, context.variable_scope_deferred_index + 1));
					ВызватьИсключение NewExtExceptionСтрока(,"DeferredOperation",,,dump,"DeferredOperation"); 	
				ИначеЕсли ОшибкаСтруктура.type = "DeferredComplete" Тогда
					Продолжить;
				Иначе
					ВызватьИсключение ИнфОбОшибке.Описание;  			
				КонецЕсли
			Иначе	
				ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context));	
			КонецЕсли;		
		КонецПопытки;
		block_context["__deferred_count"] = block_context["__deferred_count"] - 1;
		ВызватьИсключение NewExtExceptionСтрока( , , , , , "DeferredComplete"); 
	КонецЦикла;
КонецФункции

// Функция block_multithreadloop_on_before_loop
//
// Параметры:
// block_type - Строка - Название блока
// node - XML - Текущий обрабатываемый узел XML
// path - Строка - Абсолютный путь до исполняемого блока
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
//
// Возвращаемое значение:
//  Структура - Результат выполения функции
//
//DynamicDirective
Функция block_multithreadloop_on_before_loop(block_type, node, path, context, block_context)
	Если block_type = "accounting_entries_list" Тогда
        workspace_execute_inputs(node, path, context, block_context);
	ИначеЕсли block_type = "accounting_entries_list2" Тогда
		workspace_find_fields(node, block_context);
        workspace_execute_inputs(node, path, context, block_context);
	Иначе
		Если block_type = "foreach_filter_object" Тогда
			workspace_execute_inputs(node, path, context, block_context);
		КонецЕсли;
	КонецЕсли;
	Возврат Неопределено;
КонецФункции	
	
// Процедура block_multithreadloop_wait_async_request_init
//
// Параметры:
// context - Соответствие - Контекст исполняемого блока
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
//DynamicDirective
Процедура block_multithreadloop_wait_async_request_init(context) 
	ТранспортИнтеграции.async_responces = Новый Соответствие; 
	ТранспортИнтеграции.async_requests = Новый Соответствие;
	Если Не context.Свойство("reading_async_answers_mode") Тогда 
		context.Вставить("reading_async_answers_mode", Ложь);
	КонецЕсли;	
	Если Не context.Свойство("Выход_LimitCommand") Тогда 
		context.Вставить("Выход_LimitCommand", Ложь);
	КонецЕсли;	
	context.block_context.Вставить("__thread_vars", Новый Массив);
	context.block_context.__thread_vars.Добавить(Новый Соответствие);
КонецПроцедуры	
// BSLLS:UnusedLocalVariable-on

// Процедура block_multithreadloop_deferred_async_request
//
// Параметры:
// block_type - Строка - Название блока
// node - XML - Текущий обрабатываемый узел XML
// path - Строка - Абсолютный путь до исполняемого блока
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
//
//DynamicDirective
Процедура block_multithreadloop_deferred_async_request(block_type, node, path, context, block_context)
	Если (ТранспортИнтеграции.async_requests.Количество() = 0 
		И ТранспортИнтеграции.async_responces.Количество() = 0) Тогда
		Возврат 
	КонецЕсли;	
	ТранспортИнтеграции.block_multithreadloop_get_async_request(context.params);
	
	Если ТранспортИнтеграции.async_responces.Количество() = 0 Тогда  
		Возврат; 	
	КонецЕсли;
	
	QueryId = Неопределено;
	Для Каждого Запись_responce Из ТранспортИнтеграции.async_responces Цикл
		QueryId = Запись_responce.Ключ;
		Прервать
	КонецЦикла;
	
	Если QueryId = Неопределено Тогда
		Возврат; 
	КонецЕсли;	
	
	Запись_responce = ТранспортИнтеграции.async_responces.Получить(QueryId); 
	ПараметрыЗапроса = get_prop(Запись_responce,"ПараметрыЗапроса",Неопределено);
	block_context_request = get_prop(ПараметрыЗапроса,"block_context",Неопределено);
	context.block_context.Вставить("__thread_vars", get_prop(block_context_request, "__thread_vars"));
	node_loop = node.ДочерниеУзлы[1];
	Попытка
		block_multithreadloop_on_loop(block_type, node, path, context, block_context_request);  
		block_multithreadloop_execute_item(block_type, node_loop, path+".0_"+block_context_request["index"], context, block_context_request, Истина);
		context["limit_request"] = context["limit_request"] + 1;	
	Исключение 
		ИнфОбОшибке = ИнформацияОбОшибке();
		ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
		Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
			Если ОшибкаСтруктура.type = "AsyncRequest" Тогда 
				context_add_request(ОшибкаСтруктура, block_context_request);
			ИначеЕсли ОшибкаСтруктура.type = "LimitCommand" Тогда 
				context.Вставить("reading_async_answers_mode", Истина);	     
				context.Вставить("Выход_LimitCommand", Истина);
			Иначе	
				ВызватьИсключение ИнфОбОшибке.Описание;  			
			КонецЕсли
		Иначе
			context.Вставить("multithread_mode", Ложь); 
			ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context));	
		КонецЕсли;		
	КонецПопытки;
	ТранспортИнтеграции.async_responces.Удалить(QueryId);
КонецПроцедуры	

// Процедура block_multithreadloop_wait_async_request_responce_exception
//
// Параметры:
// ИнфОбОшибке - Структура - Данные ошибки
// block_type - Строка - Название блока
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
//
//DynamicDirective
Процедура block_multithreadloop_wait_async_request_responce_exception(ИнфОбОшибке, block_type, context, block_context, ПрерватьЦикл = Ложь)  
	ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
	Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
		Если ОшибкаСтруктура.type = "AsyncRequest" Тогда 
			context["limit_request"] = context["limit_request"] - 1;
			context_add_request(ОшибкаСтруктура,block_context);
			block_multithreadloop_clear_child_context(block_context);
			block_multithreadloop_block_context_index_inc(block_context);
		ИначеЕсли ОшибкаСтруктура.type = "LimitCommand" Тогда 
			context.Вставить("reading_async_answers_mode", Истина);	     
			context.Вставить("Выход_LimitCommand", Истина);
		Иначе	
			ОбработатьОшибкуЦиклическогоБлока(context, block_type, block_context, ИнфОбОшибке, ПрерватьЦикл, Истина);  			
		КонецЕсли
	Иначе
		context.Вставить("multithread_mode", Ложь); 
		ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context));	
	КонецЕсли;		
КонецПроцедуры

// Функция block_multithreadloop_check_LimitCommand
//
// Параметры:
// context - Соответствие - Контекст исполняемого блока
//
// Возвращаемое значение:
//  Неопределено - Результат успешного выполения функции
//
//DynamicDirective
Функция block_multithreadloop_check_LimitCommand(context)
	Если context.Выход_LimitCommand = Истина Тогда
		ВызватьИсключение NewExtExceptionСтрока(,"LimitCommand",,,,"LimitCommand");	
	КонецЕсли;
	Возврат Неопределено;
КонецФункции

// Функция block_multithreadloop_block_context_index_inc
//
// Параметры:
// block_context - Соответствие - Контекст текущего выполняемого блока
//
// Возвращаемое значение:
//  Неопределено - Результат успешного выполения функции
//
//DynamicDirective
Функция block_multithreadloop_block_context_index_inc(block_context)
	Если block_context.Свойство("index") Тогда
		block_context["index"] = block_context["index"] + 1;
	КонецЕсли;
	Возврат Неопределено;
КонецФункции

// Функция block_multithreadloop_wait_async_request
//
// Параметры:
// block_type - Строка - Название блока
// node - XML - Текущий обрабатываемый узел XML
// path - Строка - Абсолютный путь до исполняемого блока
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
//
// Возвращаемое значение:
//  Неопределено - Результат успешного выполения функции
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:FunctionReturnsSamePrimitive-off
// BSLLS:IfElseIfEndsWithElse-off
//DynamicDirective
Функция block_multithreadloop_wait_async_request(block_type, node, path, context, block_context) 
	block_multithreadloop_wait_async_request_init(context);
	block_check_step(context, block_context);
	Пока Истина Цикл
		Если context["reading_async_answers_mode"] = Истина Тогда
			Если (ТранспортИнтеграции.async_requests.Количество() = 0 
				И ТранспортИнтеграции.async_responces.Количество() = 0) Тогда 
				context.Вставить("multithread_mode", Ложь);
				context.Вставить("reading_async_answers_mode", Ложь);
				block_multithreadloop_check_LimitCommand(context);
				block_multithread_mode_end(context);
				Возврат Неопределено;
			КонецЕсли;
		ИначеЕсли context["limit_request"] > 0 Тогда
			// Непонятно, зачем тут прибавление индекса. Из-за этого не работает отладка в цикле
			// Если не выяснится, зачем сделано, удалить в 26.1100
			//block_multithreadloop_block_context_index_inc(block_context);			
			Попытка
				block_multithreadloop_execute_items(block_type, node, path, context, block_context);
				context.Вставить("reading_async_answers_mode", Истина);	
			Исключение  
				ИнфОбОшибке = ИнформацияОбОшибке();
				ПрерватьЦикл = Ложь; 	

				block_multithreadloop_wait_async_request_responce_exception(ИнфОбОшибке, block_type, context, block_context, ПрерватьЦикл);	

				Если ПрерватьЦикл Тогда 
					context["reading_async_answers_mode"] = Истина;
					Продолжить;
				КонецЕсли;

			КонецПопытки;
		КонецЕсли;		
		Если (context["limit_request"] <= 0 
			Или context["reading_async_answers_mode"] = Истина) Тогда 
			block_multithreadloop_deferred_async_request(block_type, node, path, context, block_context);
		КонецЕсли;		
	КонецЦикла;	
	block_multithread_mode_end(context);
	Возврат Неопределено;
КонецФункции

//DynamicDirective

Процедура block_multithreadloop_show_progress(block_context)
	CountObjectsProcessed = get_prop(block_context, "CountObjectsProcessed");
	Если get_prop(block_context, "CountObjectsProcessed") <> Неопределено Тогда 
		CountObjectsProcessed = CountObjectsProcessed + 1;
		block_context.Вставить("CountObjectsProcessed", CountObjectsProcessed);
		CountObjects = get_prop(block_context, "CountObjects", 0);
		Notification = get_prop(block_context, "Notification", "");
		ТекстСообщения = Notification + Формат(CountObjectsProcessed, "ЧГ=") + " из " + Формат(CountObjects, "ЧГ=");
		Процент = 0;
		Если CountObjects <> 0 Тогда 
			Процент = Окр(CountObjectsProcessed/CountObjects*100, 0);	
		КонецЕсли;   
		ДопПарамерыПрогресса = Новый Структура("Прогресс", Процент); //Градусник для обновления статусов

		СообщитьПрогрессОперации(Процент, ТекстСообщения, ДопПарамерыПрогресса);
	КонецЕсли;

КонецПроцедуры

// BSLLS:IfElseIfEndsWithElse-on
// BSLLS:FunctionReturnsSamePrimitive-on
	
// Функция block_multithreadloop_execute_items
//
// Параметры:
// block_type - Строка - Название блока
// node - XML - Текущий обрабатываемый узел XML
// path - Строка - Абсолютный путь до исполняемого блока
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
//
// Возвращаемое значение:
//  Неопределено - Результат успешного выполения функции
//
// Нет возможности красиво уменьшить когнитивную сложность
// BSLLS:FunctionReturnsSamePrimitive-off
// BSLLS:NestedStatements-off
// BSLLS:CognitiveComplexity-off
//DynamicDirective
Функция block_multithreadloop_execute_items(block_type, node, path, context, block_context)
		block_multithreadloop_on_before_loop(block_type, node, path, context, block_context); //Pyton true way
	//var_name = nnode.ДочерниеУзлы[0].ТекстовоеСодержимое; //не используется
	
	Попытка
		node_loop = node.ДочерниеУзлы[1];
	Исключение
		Возврат Неопределено;
	КонецПопытки;
			
	Если Не block_context.Свойство("items") Тогда
	    block_context.Вставить("items", Новый Массив());
	КонецЕсли;
	Если Не block_context.Свойство("index") Тогда
		block_context.Вставить("index", 0);
	КонецЕсли;
	local_context = Новый Структура();
	
	Пока Истина Цикл
	    Если block_context["items"].Количество() = 0 Тогда
	        Попытка
				block_context["page"] = block_context["page"] + 1;
	        Исключение
	            block_context.Вставить("page", 0);
			КонецПопытки;
						
			block_multithreadloop_execute_get_items(block_type, node, path, context, block_context, local_context);
						
		    block_context.Вставить("index", 0);
			
			Если block_context["items"].Количество() = 0 Тогда
				Если context["commands"].Количество() > 0 Тогда
					ВызватьИсключение NewExtExceptionСтрока(,"LimitCommand",,,,"LimitCommand");		
				КонецЕсли;
	            Возврат Неопределено;
			КонецЕсли;
		КонецЕсли;
	
	    Для i = block_context["index"] ПО block_context["items"].Количество()-1 Цикл
	        block_context["index"] = i;
			Попытка
				context_check_command_limit();
			Исключение
				block_multithreadloop_clear_child_context(block_context);
				ИнфОбОшибке = ИнформацияОбОшибке();
				ВызватьИсключение ИнфОбОшибке.Описание;
			КонецПопытки;
			
			block_multithreadloop_on_loop(block_type, node, path, context, block_context);
	        
			node_loop = get_statement_node(node);
			block_multithreadloop_show_progress(block_context);
			Попытка
				block_multithreadloop_execute_item(block_type, node_loop, path+".0_"+block_context["index"],context, block_context, Истина); 
			Исключение
				ИнфОбОшибке = ИнформацияОбОшибке();
				ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
				Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
					Если ОшибкаСтруктура.type = "DeferredOperation" Тогда  
						//Кузьмин
						ОшибкаСтруктура.dump.Вставить("multi_thread_loop_block_context", block_context);			
						ОшибкаСтруктура.dump.Вставить("multi_thread_loop_variable_scopes", Saby_КопияМассива(context.variable_scopes, context.variable_scope_deferred_index + 1));	
						context_add_deferred(context, ОшибкаСтруктура.dump);
						context_set_next_step(block_context.__id);
					Иначе
						ВызватьИсключение ИнфОбОшибке.Описание;  			
					КонецЕсли
				Иначе	
					ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context));	
				КонецЕсли;
			КонецПопытки;
			block_multithreadloop_clear_child_context(block_context);
			context_set_next_step(block_context.__id);
			
		КонецЦикла;
		
	    block_context.Вставить("items", Новый Массив);
		context_set_step(block_context.__id);
        block_multithreadloop_clear_child_context(block_context);
		block_check_step(context, block_context);
		
		Попытка
			context_check_command_limit(Истина);
		Исключение
			ИнфОбОшибке = ИнформацияОбОшибке();
			ВызватьИсключение ИнфОбОшибке.Описание;
		КонецПопытки;
	КонецЦикла;
	Возврат Неопределено;
КонецФункции
// BSLLS:CognitiveComplexity-on
// BSLLS:NestedStatements-on
// BSLLS:FunctionReturnsSamePrimitive-on

// Функция block_multithreadloop_on_loop
//
// Параметры:
// block_type - Строка - Название блока
// node - XML - Текущий обрабатываемый узел XML
// path - Строка - Абсолютный путь до исполняемого блока
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
//
// Возвращаемое значение:
//  Неопределено - Результат успешного выполения функции
//
//DynamicDirective
Функция block_multithreadloop_on_loop(block_type, node, path, context, block_context)
	Block_set_variable(context, node.ДочерниеУзлы[0].ТекстовоеСодержимое, block_context["items"][block_context["index"]]);
	Если block_type = "saby_task_list" Тогда
		doc = block_context["items"][block_context["index"]]["Документ"];
		ИмяСБИС = get_prop(doc, "ИмяСБИС");
		Примечание = get_prop(doc, "Примечание");
		ИмяСБИС = ТипОбъектаАПИПоТипуСБИС(ИмяСБИС, Примечание, Неопределено, context.params); 
		block_context["items"][block_context["index"]]["Документ"].Вставить("ИмяСБИС", ИмяСБИС);		
	КонецЕсли;
	Возврат Неопределено;
КонецФункции

// Функция block_multithreadloop_clear_child_context
//
// Параметры:
// block_context - Соответствие - Контекст текущего выполняемого блока
// result - Структура - Неспользуемый пока параметр
// delete_children - Булево - Признак удаления дочерних блоков
//
// Возвращаемое значение:
//  Неопределено - Результат успешного выполения функции
//
//DynamicDirective
Функция block_multithreadloop_clear_child_context(block_context, result=Неопределено, delete_children = Истина)
	Если delete_children Тогда
		block_context.Вставить("__child", Неопределено);
		block_context.Вставить("child", Новый Структура);
	КонецЕсли;
	Возврат Неопределено;
КонецФункции

#Область include_BlocklyExecutor_base_BlockTemplates_MultiThreadLoopItems
#КонецОбласти
