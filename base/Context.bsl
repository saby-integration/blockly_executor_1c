//DynamicDirective
Функция BlocklyContext_init(uid = Неопределено, debug_mode = Неопределено, current_block = Неопределено, current_workspace = Неопределено, workspace_name = Неопределено,
                   workspace_own = Неопределено, workspace_file_type = "xml", data = Неопределено, report = Неопределено, service = Неопределено)
	context_data = ?(ЗначениеЗаполнено(report), report.blockly_context, data);			   
	_context = context_init(uid, debug_mode, current_block, current_workspace, workspace_name,
                   workspace_own, workspace_file_type, context_data);
	_context.Вставить("service", service);
	_context.Вставить("report", report);
	_context.Вставить("params", Новый Структура);
    return _context
КонецФункции

//DynamicDirective
Функция new_context()
	_context = Новый Структура("command_result, commands", Новый Соответствие, Новый Массив);
	_context.Вставить("uid", Неопределено);	
	_context.Вставить("data", Новый Структура());
	_context.Вставить("action", Action_init());
	_context.Вставить("current_thread", Неопределено);
	_context.Вставить("debug_mode", Неопределено);
	_context.Вставить("current_block", Неопределено);
	_context.Вставить("current_workspace", Неопределено);
	_context.Вставить("workspace_name", Неопределено);
	_context.Вставить("workspace_own", Неопределено);
	_context.Вставить("workspace_file_type", Неопределено);
	_context.Вставить("is_deferred", Ложь);
	_context.Вставить("is_next_step", Неопределено);
	_context.Вставить("deferred_result", Неопределено);
	_context.Вставить("deferred", Новый Массив);
	_context.Вставить("limit_commands", 25);
	
	_context.Вставить("current_variable_scope", 0);
	_context.Вставить("variables", Новый Соответствие);
	_context.Вставить("current_variables", Новый Соответствие);
	_context.Вставить("variable_scopes", Новый Массив);
	_context.variable_scopes.Добавить(Новый Соответствие);
	_context.Вставить("block_context", Новый Структура);
	_context.Вставить("result", Новый Соответствие);
	_context.Вставить("status", "");
	
	_context.Вставить("operation", Новый Структура);
	Возврат _context;
КонецФункции

//DynamicDirective
Функция context_init(uid = Неопределено, debug_mode = Неопределено, current_block = Неопределено, current_workspace = Неопределено, workspace_name = Неопределено,
                   workspace_own = Неопределено, workspace_file_type = "json", data = Неопределено)
	_context = new_context();
	_context.uid = ?(uid <> Неопределено, uid, Строка(Новый УникальныйИдентификатор()));
    _context.data = ?(data <> Неопределено, data, Новый Структура()); 
	// ???
	Если data <> Неопределено Тогда
		_context.variable_scopes = data.variable_scopes;
		_context.block_context = data.block_context;
		_context.current_variables = data.current_variables;
		_context.deferred = data.deferred;
		_context.result = data.result;
	Иначе
		_context.data.Вставить("block_context", _context.block_context);
		_context.data.Вставить("current_variables", _context.current_variables);
		_context.data.Вставить("deferred", _context.deferred);
		_context.data.Вставить("result", _context.result);
	КонецЕсли;
	_context.data.Вставить("variable_scopes", _context.variable_scopes);
	
	_context.debug_mode = debug_mode;
    _context.current_block = current_block;
    _context.current_workspace = ?(current_workspace <> Неопределено, current_workspace, workspace_name);
    _context.workspace_name = workspace_name;
    _context.workspace_own = workspace_own;
    _context.workspace_file_type = workspace_file_type;
    _context.is_next_step = ?(current_block = Неопределено И ЗначениеЗаполнено(debug_mode), Истина, Неопределено);
    return _context
КонецФункции

//DynamicDirective
Функция context_init_nested(block_context, workspace_name)
	_self = BlocklyContext_init();
    _self.data = get_prop(block_context, "_child", Новый Структура);
	// ???
	_self.variable_scopes = _self.data.variable_scopes;
	
    _self.workspace_name = workspace_name;
	_self.workspace_file_type = context.workspace_file_type;

    _self.is_deferred = context.is_deferred;
    _self.debug_mode = context.debug_mode;
    _self.current_block = context.current_block;
    _self.current_workspace = context.current_workspace;
    _self.is_next_step = context.is_next_step;
	
	// ???
	_self.operation.Вставить("connection_uuid",context.operation.connection_uuid);
	_self.params = context.params;
	//_self.service = context.service;
	//_self.report = context.report;
	return _self;
КонецФункции

//DynamicDirective
Функция context_workspace_read()
	Load_ini(context.workspace_name);
	ДокDOM = ПолучитьДокументDOM(IniGet(context.workspace_name));
	Возврат ДокDOM;
КонецФункции

//DynamicDirective
Функция context_init_deferred(deferred)
	_context = BlocklyContext_init();
	_context.params = context.params;
    _context.block_context = deferred["block_context"];
    _context.is_deferred = Истина;
    _context.data = context.data;
	context_variables_set(_context, context_variables_get(context));
    _context.operation = context.operation;
    _context.deferred = context.deferred;
	_context.command_result = context.command_result;
    return _context
КонецФункции

//DynamicDirective
Функция context_to_result()
	res = Новый Структура("uid, result, status, commands", context.uid, context.result, context.status, context.commands);
	Если ЗначениеЗаполнено(context.debug_mode) Тогда
		res.Вставить("current_variables", context.current_variables);
		res.Вставить("current_block", context.current_block);
		res.Вставить("current_workspace", context.current_workspace);
	КонецЕсли;
	
	return res;
КонецФункции

//DynamicDirective
Процедура context_set_next_step(block_id = Неопределено)
	Если ЗначениеЗаполнено(context.debug_mode) Тогда
		Если block_id = Неопределено Или (block_id = context.current_block И context.current_workspace = context.workspace_name) Тогда
			context.is_next_step = Истина;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

//DynamicDirective
Процедура context_set_step(block_id)
	Если ЗначениеЗаполнено(context.debug_mode) Тогда
		context.is_next_step = Ложь;
		context.current_block = block_id;
		context.current_workspace = context.workspace_name;	
	КонецЕсли;
КонецПроцедуры

//DynamicDirective
Функция context_check_command_limit()
	Если context["commands"].Количество() >= context["limit_commands"] Тогда
		ВызватьИсключение NewExtExceptionСтрока(,"LimitCommand",,,,"LimitCommand");		
	КонецЕсли;
КонецФункции

//DynamicDirective
Функция context_set_command_limit(debug_mode)
	context.limit_commands = ?(ЗначениеЗаполнено(debug_mode), 1, 25);
КонецФункции

//DynamicDirective
Процедура context_variable_scope_add(block_context, params)
	Если get_prop(block_context, "_variable_scope") <> Неопределено Тогда
		context.current_variable_scope = block_context["_variable_scope"];
	Иначе
		context.variable_scopes.Добавить(params);
		context.current_variable_scope = context.variable_scopes.Количество() - 1;
		block_context.Вставить("_variable_scope", context.current_variable_scope);
	КонецЕсли;
КонецПроцедуры

//DynamicDirective
Процедура context_variable_scope_remove(block_context)
	Если block_context["_variable_scope"] <> context.current_variable_scope 
		Или context.variable_scopes.Количество() - 1 <> context.current_variable_scope Тогда
		ВызватьИсключение NewExtExceptionСтрока(,"Какая то фигня с variable_scope");
	КонецЕсли;
	context.variable_scopes.Удалить(context.current_variable_scope);
	// ???
	//context.data.variable_scopes.Удалить(context.current_variable_scope);
	context.current_variable_scope = context.current_variable_scope - 1;
	// ???
	//context.variables = context.variable_scopes[context.current_variable_scope];
КонецПроцедуры

//DynamicDirective
Функция context_add_deferred(deferred_exception)
	_local_context = deferred_exception.dump.block_context;
    _operation_context = deferred_exception.dump.context;
    Попытка
        i = helper_find_in_array(context.deferred, _local_context["__deferred"], "__deferred");
    Исключение
        context.deferred.Добавить(Новый Структура);
        i = context.deferred.Количество() - 1;
	КонецПопытки;

    context.deferred[i] = Новый Структура("__deferred, block_context", _local_context["__deferred"], _operation_context.block_context);	
КонецФункции

//DynamicDirective
Функция context_add_request(request_exception,block_context)
	QueryId = request_exception.dump.QueryId;
	deadline = request_exception.dump.deadline;
	block_context_request = Новый Структура;
	Для Каждого Элемент Из block_context Цикл
		block_context_request.Вставить(Элемент.Ключ, Элемент.Значение);	
	КонецЦикла; 
	//ЗаписьЖурналаРегистрации("block_multithreadloop", УровеньЖурналаРегистрации.Информация, ,, "Отложенный запрос "+block_context_request["page"] + " _" + block_context_request["index"]);
    //context.requests.Добавить(Новый Структура("id_request, block_context", id_request, block_context_request));
	Запись_QueryId = request_exception.dump; 
	Запись_QueryId.Вставить("block_context",block_context_request);
	async_requests.Вставить(QueryId,Запись_QueryId);
КонецФункции

//DynamicDirective
Процедура context_variables_set(_context, value)
	_context.variable_scopes[_context.current_variable_scope] = value;
	// ???
	_context.data.variable_scopes[_context.current_variable_scope] = value;
КонецПроцедуры

//DynamicDirective
Функция context_variables_get(_context)
	Возврат _context.variable_scopes[_context.current_variable_scope]
КонецФункции

//DynamicDirective
Функция add_new_context()
	save_last_context();
	context	= BlocklyContext_init();
	context.params	= contexts[contexts.Количество()-1].params;
	context.operation	= contexts[contexts.Количество()-1].operation;
КонецФункции

//DynamicDirective
Функция save_last_context()
	Если 	contexts = Неопределено ТОгда 	
		contexts = Новый Массив;
	КонецЕсли;
	Если 	workspaces = Неопределено ТОгда 	
		workspaces = Новый Массив;
	КонецЕсли;
	workspaces.Добавить(BlocklyExecutor.workspace);
	contexts.Добавить(context);
КонецФункции

//DynamicDirective
Функция delete_last_context()
	context	= contexts[contexts.Количество() - 1];
	contexts.Удалить(contexts.Количество() - 1);
	BlocklyExecutor.workspace	= workspaces[workspaces.Количество() - 1];
	Workspace = BlocklyExecutor.workspace.data;
	workspaces.Удалить(workspaces.Количество() - 1);
КонецФункции
