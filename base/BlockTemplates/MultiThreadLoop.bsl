
Процедура block_multithreadloop_switch_multithread_mode(context, block_type, block_context, multithread_mode)
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
	Если Не context.Свойство("limit_request") Тогда 
		context.Вставить("limit_request", 10);
	КонецЕсли;	
КонецПроцедуры

Функция block_multithreadloop_execute(block_type, node, path, context, block_context, multithread_mode = Ложь)
	
	block_multithreadloop_switch_multithread_mode(context, block_type, block_context, multithread_mode);
	
	Если context.is_deferred Тогда
        node_loop = node.ДочерниеУзлы[1];
		block_multithreadloop_on_loop(node, path, context, block_context);
		
		Попытка 
			block_multithreadloop_execute_item(block_type, node_loop, path+".0_"+block_context["index"], context, block_context, Истина);
      		context_set_step(block_context.__id);
  		Исключение   
			ИнфОбОшибке = ИнформацияОбОшибке();
			ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
			Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
				Если ОшибкаСтруктура.type = "AsyncRequest" Тогда 
					context["limit_request"] = context["limit_request"] - 1;
					context_add_request(ОшибкаСтруктура, block_context);
				Иначе
					ВызватьИсключение ИнфОбОшибке.Описание;  			
				КонецЕсли
			Иначе	
				ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context));	
			КонецЕсли;		
		КонецПопытки;	
        Возврат Неопределено;
	КонецЕсли;
	Возврат block_multithreadloop_wait_async_request(block_type, node, path, context, block_context);
	
КонецФункции

Функция block_multithreadloop_on_before_loop(block_type, node, path, context, block_context)
	Если block_type = "accounting_entries_list" Тогда
        workspace_execute_inputs(node, path, context, block_context);
	ИначеЕсли block_type = "accounting_entries_list2" Тогда
        workspace_execute_inputs(node, path, context, block_context);
	КонецЕсли;
КонецФункции	
	
Процедура block_multithreadloop_wait_async_request_init(context) 
	async_responces = Новый Соответствие; 
	async_requests = Новый Соответствие;
	Если Не context.Свойство("reading_async_answers_mode") Тогда 
		context.Вставить("reading_async_answers_mode", Ложь);
	КонецЕсли;	
	Если Не context.Свойство("Выход_LimitCommand") Тогда 
		context.Вставить("Выход_LimitCommand", Ложь);
	КонецЕсли;	
КонецПроцедуры	

Процедура block_multithreadloop_deferred_async_request(block_type, node, path, context, block_context)
	Если (async_requests.Количество() = 0 
		И async_responces.Количество() = 0) Тогда
		Возврат 
	КонецЕсли;	
	block_multithreadloop_get_async_request();
	
	Если async_responces.Количество() = 0 Тогда  
		Возврат; 	
	КонецЕсли;
	
	QueryId = Неопределено;
	Для Каждого Запись_responce ИЗ async_responces Цикл
		QueryId = Запись_responce.Ключ;
		Прервать
	КонецЦикла;
	
	Если QueryId = Неопределено Тогда
		Возврат; 
	КонецЕсли;	
	
	Запись_responce = async_responces.Получить(QueryId); 
	ПараметрыЗапроса = get_prop(Запись_responce,"ПараметрыЗапроса",Неопределено);
	block_context_request = get_prop(ПараметрыЗапроса,"block_context",Неопределено);
	node_loop = node.ДочерниеУзлы[1];
	Попытка
		ЗаписьЖурналаРегистрации("block_multithreadloop", УровеньЖурналаРегистрации.Информация, ,, "Обрабатываем "+block_context_request["page"] + " _" + block_context_request["index"]);
		block_multithreadloop_on_loop(node, path, context, block_context_request);  
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
	async_responces.Удалить(QueryId);
КонецПроцедуры	

Процедура block_multithreadloop_wait_async_request_responce_exception(ИнфОбОшибке, block_type, context, block_context)  
	ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
	Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
		Если ОшибкаСтруктура.type = "AsyncRequest" Тогда 
			context["limit_request"] = context["limit_request"] - 1;
			context_add_request(ОшибкаСтруктура,block_context);
			block_multithreadloop_clear_child_context(block_context);
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
КонецПроцедуры

Функция block_multithreadloop_check_LimitCommand(context)
	Если context.Выход_LimitCommand = Истина Тогда
		ВызватьИсключение NewExtExceptionСтрока(,"LimitCommand",,,,"LimitCommand");	
	КонецЕсли;
КонецФункции

Функция block_multithreadloop_block_context_index_inc(block_context)
	Если block_context.Свойство("index") Тогда
		block_context["index"] = block_context["index"] + 1;
	КонецЕсли;
КонецФункции

Функция block_multithreadloop_wait_async_request(block_type, node, path, context, block_context) 
	block_multithreadloop_wait_async_request_init(context);	
	Пока Истина Цикл
		Если context["reading_async_answers_mode"] = Истина Тогда
			Если (async_requests.Количество() = 0 
				И async_responces.Количество() = 0) Тогда 
				context.Вставить("multithread_mode", Ложь);
				context.Вставить("reading_async_answers_mode", Ложь);
				block_multithreadloop_check_LimitCommand(context);
				Возврат Неопределено;
			КонецЕсли;
		ИначеЕсли context["limit_request"] > 0 Тогда
			block_multithreadloop_block_context_index_inc(block_context);			
			Попытка
				block_multithreadloop_execute_items(block_type, node, path, context, block_context);
				context.Вставить("reading_async_answers_mode", Истина);	
			Исключение  
				ИнфОбОшибке = ИнформацияОбОшибке();
				block_multithreadloop_wait_async_request_responce_exception(ИнфОбОшибке, block_type, context, block_context);	
			КонецПопытки;
		КонецЕсли;		
		Если (context["limit_request"] <= 0 
			Или context["reading_async_answers_mode"] = Истина) Тогда 
			block_multithreadloop_deferred_async_request(block_type, node, path, context, block_context);
		КонецЕсли;		
	КонецЦикла;	
	context.Вставить("multithread_mode", Ложь);
КонецФункции
	
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
			
			block_multithreadloop_on_loop(node, path, context, block_context);
	        block_check_step(context, block_context);
			node_loop = get_statement_node(node);
			
			Попытка
				block_multithreadloop_execute_item(block_type, node_loop, path+".0_"+block_context["index"],context, block_context, Истина); 
			Исключение
				ИнфОбОшибке = ИнформацияОбОшибке();
				ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
				Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
					Если ОшибкаСтруктура.type = "DeferredOperation" Тогда
						context_add_deferred(ОшибкаСтруктура);
						context_set_next_step(block_context.__id);
					Иначе
						ВызватьИсключение ИнфОбОшибке.Описание;  			
					КонецЕсли
				Иначе	
					ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context));	
				КонецЕсли;
			КонецПопытки;
			
			context_set_step(block_context.__id);
	        block_multithreadloop_clear_child_context(block_context);
		КонецЦикла;
		
	    block_context.Вставить("items", Новый Массив);
		
		Попытка
			context_check_command_limit();
		Исключение
			ИнфОбОшибке = ИнформацияОбОшибке();
			ВызватьИсключение ИнфОбОшибке.Описание;
		КонецПопытки;
	КонецЦикла;
КонецФункции

Функция block_multithreadloop_on_loop(node, path, context, block_context)
	Block_set_variable(context, node.ДочерниеУзлы[0].ТекстовоеСодержимое, block_context["items"][block_context["index"]]);
КонецФункции

Функция block_multithreadloop_clear_child_context(block_context, result=Неопределено, delete_children = Истина)
	Если delete_children Тогда
		block_context.Вставить("__child", Неопределено);
		block_context.Вставить("child", Новый Структура);
	КонецЕсли;
КонецФункции

#Область include_BlocklyExecutor_base_BlockTemplates_MultiThreadLoopItems
#КонецОбласти
