Функция block_procedures_callreturn_execute(block_type, node, path, context, block_context)
	Если НЕ block_context.Свойство("result") Тогда
		endpoint_args_values = procedures_callreturn_get_params(node);
		Если ЗначениеЗаполнено(endpoint_args_values.values) Тогда
			Для i = 0 По endpoint_args_values.args.Количество() - 1 Цикл
				Если Не block_context.Свойство(endpoint_args_values.args[i]) Тогда
					Если endpoint_args_values.values.Количество() <= i Тогда
						_value = Неопределено;
					Иначе
						_value = block_execute_all_next(endpoint_args_values.values[i], path + "." + i, context, block_context);
					КонецЕсли;
					context.variables.Вставить(endpoint_args_values.args[i], _value );
					block_context.Вставить(endpoint_args_values.args[i], context.variables[endpoint_args_values.args[i]]);
				КонецЕсли;
			КонецЦикла;	
		КонецЕсли;
		blockly_executor_read_procedures_and_functions();	
		handler = Functions[endpoint_args_values.endpoint];
		res = block_execute(handler.type,handler.node, path, context, block_context);
		ВставитьСвойствоЕслиНет(block_context, "result", res);
	КонецЕсли;
	
	Возврат block_context.result;
КонецФункции

Функция procedures_callreturn_get_params(node)
	mutation = Root.ВычислитьВыражениеXpath("./b:mutation", node, размыватель).ПолучитьСледующий();
	Если mutation = Неопределено Тогда
		Сообщить("Не поддерживаемый callreturn");
	КонецЕсли;
	func_name = mutation.ПолучитьАтрибут("name");
	args_name_nodes = Новый Массив;
	РезультатXpath = Root.ВычислитьВыражениеXpath("./b:arg", mutation, размыватель);	
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
		РезультатXpath = Root.ВычислитьВыражениеXpath("./b:value", node, размыватель);	
		Пока Истина Цикл
			Узел = РезультатXpath.ПолучитьСледующий();
			Если Узел=Неопределено Тогда Прервать КонецЕсли;
			value_nodes.Добавить(Узел);		
		КонецЦикла;
	КонецЕсли;
	Возврат Новый Структура("endpoint, args, values", func_name, args, value_nodes);
КонецФункции
