//DynamicDirective
Функция block_controls_while_until_execute(block_type, node, path, context, block_context)
	Если НЕ block_context.Свойство("result") Тогда
		Result = Неопределено;
		block_check_step(context, block_context);
		value_node = Workspace.ВычислитьВыражениеXpath("./b:value", node, размыватель).ПолучитьСледующий(); // узел с условием цикла
		Если Не block_context.Свойство("WHILE") Тогда
			block_context.Вставить("WHILE", block_format_get_node_field(node));
		КонецЕсли;	
		
		Пока Истина Цикл
			Если Не block_context.Свойство("BOOL") или block_context["BOOL"] = Неопределено Тогда
				block_context.Вставить("BOOL", block_execute_all_next(value_node, path, context, block_context, True));
			КонецЕсли;	
			Если block_context["WHILE"] = "WHILE" Тогда
				Условие = block_context["BOOL"];
			Иначе 
				Условие = Не block_context["BOOL"];
			КонецЕсли;
			Если Условие Тогда
				statement_node = get_statement_node(node);
				block_execute_all_next(statement_node, path, context, block_context, True);
				
				block_context.Вставить("BOOL", Неопределено);
				block_context.Вставить("__child", Неопределено);
				context_set_step(block_context.__id);
				block_check_step(context, block_context);
			Иначе
				result = block_context["BOOL"];
				Прервать;
			КонецЕсли;
		КонецЦикла;	
		ВставитьСвойствоЕслиНет(block_context, "result", result);
	КонецЕсли;	
	Возврат block_context["result"];	
КонецФункции
