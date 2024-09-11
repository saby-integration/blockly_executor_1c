
Функция blockly_executor_init(logger = Неопределено, plugins = Неопределено, breakpoints = Неопределено)
	_executor = Новый Структура();
	_executor.Вставить("breakpoints", breakpoints);
    _executor.Вставить("logger", logger);
    _executor.Вставить("extend_plugins", plugins);
    _executor.Вставить("multi_thread_mode", Ложь);
    _executor.Вставить("gather", Новый Массив);
    _executor.Вставить("commands_result", Новый Соответствие);
    _executor.Вставить("action", Неопределено);
    _executor.Вставить("workspace", Неопределено);
    Возврат _executor
КонецФункции

Функция blockly_executor_init_workspace(data, name, logger, own = Неопределено)
	_workspace = workspace_init(data, name, logger, own);
	
	Возврат _workspace;
КонецФункции

Функция blockly_executor_execute(ДокументDOM, endpoint = Неопределено) Экспорт
	BlocklyExecutor.workspace = blockly_executor_init_workspace(ДокументDOM, context.workspace_name, BlocklyExecutor.logger);
	BlocklyExecutor.Вставить("current_algorithm_breakpoints", BlocklyExecutor.breakpoints[BlocklyExecutor.workspace.name]);
	context.status = "run";
    context_set_command_limit(context.debug_mode);
	BlocklyExecutor.action = Action_init("BlocklyExecutor.execute");
	
	Попытка
		start_block = workspace_get_start_block(endpoint, context);
		ЗаполнитьПубличныеПараметры(context);        
		Если context.deferred.Количество() > 0 Тогда
			blockly_executor_execute_deferred(start_block, context);	
		КонецЕсли;
		context_check_command_limit();
		
		result = block_execute(start_block.type, start_block.node, "", context, context.block_context);
		ЗаписатьПубличныеПараметры(context);
	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
		ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
		Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
			Если get_prop(Currentblock_context,"value") <> Неопределено И Найти(ТипЗнч(Currentblock_context.value),"объект") Тогда
				Currentblock_context.value = ПолучитьСтруктуруИзОбъекта(Currentblock_context.value);
			КонецЕсли; 
			
			Если get_prop(Currentblock_context,"value") <> Неопределено Тогда
				
				newvalue = Новый Структура;
				newvalue.Вставить("value",Currentblock_context.value);
				
				ПреобразоватьСтруктутуКДопустимымXDTOТипам(newvalue);
				Currentblock_context.Вставить("value", newvalue.value);
				
			КонецЕсли;
		
			ДанныеДляКоманд = Новый Соответствие;
			Для Каждого command Из context.commands Цикл
				Если get_prop(command, "data") <> Неопределено Тогда
					ДанныеДляКоманд.Вставить(command.uuid, command.data);
					command.Удалить("data");
				КонецЕсли
			КонецЦикла;
			
			// Получение данных по вложениям, всегда 0 уровень
			commands_data = ПоместитьВоВременноеХранилище(ДанныеДляКоманд, get_prop(context.variable_scopes[0], "ВложенияАдресВХранилище", Новый УникальныйИдентификатор()));
			ПреобразоватьСтруктутуКДопустимымXDTOТипам(context_variables_get(context));

			Если ОшибкаСтруктура.type = "StepForward" Тогда
				context.result = ОшибкаСтруктура.dump.block_context;
				context.current_variables = context_variables_get(ОшибкаСтруктура.dump.context);
	            context.current_block = ОшибкаСтруктура.dump.block_id;
	            context.current_workspace = ОшибкаСтруктура.dump.workspace_name;
				//self.logger.debug('raise StepForward')
				Возврат context_to_result(); 			
			КонецЕсли;
			Возврат Новый Структура ("step, variables, data, status, commands, commands_data", Currentblock_context.__id, context_variables_get(context), Currentblock_context, "run", context.commands, commands_data); 			
		Иначе
			Возврат Новый Структура("data, status", ОшибкаСтруктура, "error");
		КонецЕсли;
		
	КонецПопытки;
	ПреобразоватьСтруктутуКДопустимымXDTOТипам(context_variables_get(context));
	Возврат Новый Структура("data, variables, status", result, context_variables_get(context), "complete");
КонецФункции

Функция blockly_executor_execute_nested(context, endpoint, commands_result)
	workspace_raw = context_workspace_read();
	BlocklyExecutor.workspace = blockly_executor_init_workspace(workspace_raw, context.workspace_name, BlocklyExecutor.logger);
	BlocklyExecutor.Вставить("current_algorithm_breakpoints", BlocklyExecutor.breakpoints[BlocklyExecutor.workspace.name]);
	// ???
	context.status = "run";
	start_block = workspace_get_start_block(endpoint, context);
	result = block_execute(start_block.type, start_block.node, "", context, context.block_context);
	Возврат result;
КонецФункции

Функция blockly_executor_execute_deferred(endpoint_node, context)
	//_deferred = context.deferred;
	//_commands = context.operation['commands']
	//context.operation['commands'] = []
    Для Каждого _deferred Из context.deferred Цикл
        _context = context_init_deferred(_deferred);
        Попытка
            block_execute(endpoint_node.type, endpoint_node.node, "", _context, _context.block_context);
        Исключение 
			Ошибка = ИнформацияОбОшибке();
			//context.context_add_deferred(operation)
			//_delete.append(i)
			//continue
		КонецПопытки
	КонецЦикла;
    context.deferred = Новый массив;
	context.Вставить("Выход_LimitCommand", Ложь);	
КонецФункции

#Область include_BlocklyExecutor_base_ConnectionPublicParam
#КонецОбласти
