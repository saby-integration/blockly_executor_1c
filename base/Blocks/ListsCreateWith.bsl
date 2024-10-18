//DynamicDirective
Функция block_lists_create_with_get_list_size(node)
	mutation = Workspace.ВычислитьВыражениеXpath("./b:mutation", node, размыватель).ПолучитьСледующий();
	Если mutation = Неопределено Тогда
		Возврат 0;
	КонецЕсли;	
	Возврат Число(?(ЗначениеЗаполнено(mutation.ПолучитьАтрибут("items")),mutation.ПолучитьАтрибут("items"),0));	
КонецФункции

//DynamicDirective
Функция block_lists_create_with_execute(block_type, node, path, context, block_context)
	total_size = block_lists_create_with_get_list_size(node);
	result = Новый Массив;
	Если Не total_size Тогда
		Возврат result;
	КонецЕсли;	
	Если Не block_context.свойство("value") Тогда
		block_context.Вставить("value", Новый Массив);
	КонецЕсли;	
	current_size = block_context["value"].Количество();
	Если current_size <> total_size Тогда
		Для j=current_size По total_size-1 Цикл
			node_value = workspace_find_input_by_name(node, "ADD" + j);
			Если node_value = Неопределено Тогда
				Продолжить;
			КонецЕсли;	
			result = block_execute_all_next(node_value, path+"."+j, context, block_context);
			block_context["value"].Добавить(result);
		КонецЦикла;	
	КонецЕсли;		
	block_check_step(context, block_context);
	Возврат block_context["value"];	
КонецФункции
