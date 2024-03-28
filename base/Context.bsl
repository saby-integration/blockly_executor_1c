Функция context_init_deferred(deferred)
	_context = new_context();
	_context.params = context.params;
    _context.debug = deferred["debug"];
    _context.is_deferred = Истина;
    _context.data = context.data;
    _context.variables = context.variables;
    _context.operation = context.operation;
    _context.deferred = context.deferred;
    _context.connection = context.connection;
	_context.command_result = context.command_result;
    return _context
КонецФункции

Функция context_check_command_limit()
	Если context["commands"].Количество() >= context["limit_commands"] Тогда
		ВызватьИсключение NewExtExceptionСтрока(,"LimitCommand",,,,"LimitCommand");		
	КонецЕсли;
КонецФункции

Функция context_add_deferred(deferred_exception)
	_local_context = deferred_exception.dump.block_context;
    _operation_context = deferred_exception.dump.context;
    Попытка
        i = helper_find_in_array(context.deferred, _local_context["__deferred"], "__deferred");
    Исключение
        context.deferred.Добавить(Новый Структура);
        i = context.deferred.Количество() - 1;
	КонецПопытки;

    context.deferred[i] = Новый Структура("__deferred, debug", _local_context["__deferred"], _operation_context.debug);

	//Попытка
	//    i = helper_find_in_array(context["commands"], _local_context["__path"], key=2)
	//Исключение
	//    context["commands"].append(Новый Массив);
	//    i = context["commands"].Количество() - 1;
	//КонецПопытки;
	//context.operation["commands"][i] = deferred_exception.to_command()	
КонецФункции

Функция context_add_request(request_exception,block_context)
	QueryId = request_exception.dump.QueryId;
	deadline = request_exception.dump.deadline;
	block_context_request = Новый Структура;
	Для Каждого Элемент Из block_context Цикл
		block_context_request.Вставить(Элемент.Ключ, Элемент.Значение);	
	КонецЦикла; 
	ЗаписьЖурналаРегистрации("block_multithreadloop", УровеньЖурналаРегистрации.Информация, ,, "Отложенный запрос "+block_context_request["page"] + " _" + block_context_request["index"]);
    //context.requests.Добавить(Новый Структура("id_request, block_context", id_request, block_context_request));
	Запись_QueryId = request_exception.dump; 
	Запись_QueryId.Вставить("block_context",block_context_request);
	async_requests.Вставить(QueryId,Запись_QueryId);
КонецФункции
