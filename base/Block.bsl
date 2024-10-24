
//DynamicDirective
Функция block_execute(block_type, node, path, context, block_context)
	blockType = node.ПолучитьАтрибут("type");
	path = path+"."+blockType;
	block_context.Вставить("__id",node.ПолучитьАтрибут("id"));
	block_context.Вставить("__path",path);
	block_context.Вставить("__type",blockType);
	Попытка  
		result = block_execute_ontype(block_type, node, path, context, block_context);
	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
		ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
		Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
			ВызватьИсключение ИнфОбОшибке.Описание; // (исходное исключение) 			
		Иначе	
			ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + blockType + ")", add_block_to_dump(block_context));	
		КонецЕсли;
	КонецПопытки;
	Возврат result;
КонецФункции

//DynamicDirective
Функция block_execute_ontype(block_type, node, path, context, block_context)
	БлокВыполнен = Ложь;
	result = block_execute_function(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда 
		result = block_execute_logic(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_loop(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_math(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_text(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_list(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_obj(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_variables(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_c1(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_edo(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_settings(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = simple_block_execute_extsys(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = simple_block_execute_integration(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_indicator(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = simple_block_execute_test(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = simple_api3_block_execute(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		ВызватьИсключение NewExtExceptionСтрока(,"Нет реализации для блока", block_type);
	КонецЕсли;
	ВставитьСвойствоЕслиНет(block_context, "result", result);
	Возврат block_context["result"];
КонецФункции

//DynamicDirective
Функция ЭтоСлужебнаяОшибкаБлока(ТипОшибки)
	Если ТипОшибки = "StepForward" или ТипОшибки = "DeferredOperation" или ТипОшибки = "LimitCommand" или ТипОшибки = "AsyncRequest" Тогда
		Возврат Истина;		
	КонецЕсли;
	Возврат Ложь;
КонецФункции

//DynamicDirective
Функция block_execute_all_next(node, path, context, block_context, statement = Ложь)
	statement_number = 0;
	Если НЕ block_context.Свойство("child") Тогда
		block_context.Вставить("child", Новый Структура);
	КонецЕсли;
	child_context =  block_context.child;
	result = Неопределено;
	Пока Истина Цикл
		
		Если child_context.Свойство("i" + statement_number) Тогда  
			_child_context = child_context["i" + statement_number];
		Иначе 
			child_context.Вставить("i" + statement_number, Новый Структура);
		КонецЕсли;
		
		child = workspace_read_child_block(node);
		next_node = Неопределено; 
		Если НЕ child = Неопределено  Тогда
			next_node = ?(statement, workspace_find_next_statement(child), Неопределено);
			block_subtype = child.ПолучитьАтрибут("type");
			Если НЕ child_context.Свойство("__result") Тогда
				//path = path+"."+child.ПолучитьАтрибут("id");
				result = block_execute(block_subtype, child, path, context, child_context["i" + statement_number]);
			КонецЕсли;
			
		Иначе
			result = Неопределено;
		КонецЕсли;
		Если НЕ next_node = Неопределено Тогда
			Попытка
				node = next_node;
			Исключение
				node = неопределено;
				node = next_node;
				Возврат result;
			КонецПопытки;	
			child_context["i"+statement_number].Вставить("__result", True);
			statement_number = statement_number + 1;
		Иначе
			block_context.Удалить("child");
			Возврат result;
		КонецЕсли;	
	КонецЦикла;	
	Возврат result;
КонецФункции

//DynamicDirective
Процедура block_check_step(context, block_context)
	Если ЗначениеЗаполнено(context.debug_mode) Тогда
		Если context.is_next_step = Истина Тогда
			Если context.debug_mode = "step" Тогда
				dump = Новый Структура("block_id, context, block_context, workspace_name", block_context.__id, context, block_context, BlocklyExecutor.workspace.name);
				ВызватьИсключение NewExtExceptionСтрока(,,,, dump, "StepForward");
			Иначе
				context.current_block = block_context.__id;
				context.current_workspace = BlocklyExecutor.workspace.name
			КонецЕсли;
		КонецЕсли;
		Если block_context.__id = context.current_block И context.current_workspace = BlocklyExecutor.workspace.name Тогда
			Если BlocklyExecutor.current_algorithm_breakpoints <> Неопределено Тогда
				Если BlocklyExecutor.current_algorithm_breakpoints.Найти(block_context.__id) <> Неопределено И context.is_next_step = Истина Тогда
					dump = Новый Структура("block_id, context, block_context, workspace_name", block_context.__id, context, block_context, BlocklyExecutor.workspace.name);
					ВызватьИсключение NewExtExceptionСтрока(,,,, dump, "StepForward");
				КонецЕсли;
			КонецЕсли;
			Если context.debug_mode = "step" Тогда
				Если context.is_next_step = Ложь тогда  
					dump = Новый Структура("block_id, context, block_context, workspace_name", block_context.__id, context, block_context, BlocklyExecutor.workspace.name);
					ВызватьИсключение NewExtExceptionСтрока(,,,, dump, "StepForward");
				КонецЕсли;
			КонецЕсли;
			context.is_next_step = Истина
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

//DynamicDirective
Функция block_get_block_class(block_subtype, blocks=Неопределено)
	
	
КонецФункции	

//DynamicDirective
Функция block_set_variable(context, name, value)
	context_variables_get(context).Вставить(name, value);
	context.data.Вставить("variable_scopes", context.variable_scopes);
	Возврат Неопределено;
КонецФункции

//DynamicDirective
Функция block_get_variable(context, name)
	Возврат context_variables_get(context).Получить(name);
КонецФункции
	
