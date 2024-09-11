Функция block_procedures_callreturn_execute(block_type, node, path, context, block_context)
	Если НЕ block_context.Свойство("result") Тогда
		endpoint = workspace_find_mutation_by_name(node, "name");
		Если НЕ block_context.Свойство("__params") Тогда
			block_context.Вставить("__params", procedures_callreturn_calc_param_value(node, path, context, block_context));
		КонецЕсли;
		handler = workspace_init_procedure_block(endpoint);
		block_check_step(context, block_context);
		context_variable_scope_add(block_context, block_context["__params"]);
		res = block_execute(handler.type, handler.node, "", context, block_context);
		block_context.Вставить("result", res);
		context_variable_scope_remove(block_context);
    КонецЕсли;
	
	Возврат block_context.result;
КонецФункции

Функция procedures_callreturn_calc_param_value(node, path, context, block_context)
	args = workspace_find_mutation_args(node);
    inputs = workspace_find_inputs(node);
    function_params = Новый Соответствие;
	Если ЗначениеЗаполнено(inputs) Тогда
		Для i = 0 По args.Количество() - 1 Цикл
			arg_name = args[i];
			Если НЕ block_context.Свойство(arg_name) Тогда
				arg_node = get_prop(inputs, "ARG" + i);
				_value = Неопределено;			       
				Если arg_node <> Неопределено Тогда
					_value = block_execute_all_next(arg_node, path + "." + i, context, block_context);	
				КонецЕсли;
				block_context.Вставить(arg_name, _value);
				function_params.Вставить(arg_name, _value);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
    Возврат function_params
КонецФункции

Функция procedures_callreturn_get_params(node)
	mutation = Workspace.ВычислитьВыражениеXpath("./b:mutation", node, размыватель).ПолучитьСледующий();
	Если mutation = Неопределено Тогда
		Сообщить("Не поддерживаемый callreturn");
	КонецЕсли;
	func_name = mutation.ПолучитьАтрибут("name");
	args_name_nodes = Новый Массив;
	РезультатXpath = Workspace.ВычислитьВыражениеXpath("./b:arg", mutation, размыватель);	
	Пока Истина Цикл
		Узел = РезультатXpath.ПолучитьСледующий();
		Если Узел=Неопределено Тогда Прервать КонецЕсли;
		args_name_nodes.Добавить(Узел);		
	КонецЦикла;
	args = Новый Массив;
	value_nodes = Неопределено;
	Если ЗначениеЗаполнено(args_name_nodes) Тогда
		count_args = args_name_nodes.Количество();
		Для i = 0 По count_args - 1 Цикл
			args.Добавить(args_name_nodes[i].ПолучитьАтрибут("name"));
		КонецЦикла;
		value_nodes = Новый Массив;
		РезультатXpath = Workspace.ВычислитьВыражениеXpath("./b:value", node, размыватель);	
		Пока Истина Цикл
			Узел = РезультатXpath.ПолучитьСледующий();
			Если Узел=Неопределено Тогда Прервать КонецЕсли;
			value_nodes.Добавить(Узел);		
		КонецЦикла;
	КонецЕсли;
	Возврат Новый Структура("endpoint, args, values", func_name, args, value_nodes);
КонецФункции
