
Функция block_lists_concatenate_get_list_size(node)
	mutation = Workspace.ВычислитьВыражениеXpath("./b:mutation", node, размыватель).ПолучитьСледующий();
	Если mutation = Неопределено Тогда
		Возврат 0;
	КонецЕсли;	
	Возврат Число(?(ЗначениеЗаполнено(mutation.ПолучитьАтрибут("items")),mutation.ПолучитьАтрибут("items"),0));	
КонецФункции

Процедура block_lists_concatenate_add(block_context,add_list)
	valuelist = get_prop(block_context,"value", Новый Массив);
	Если ТипЗнч(add_list) = Тип("ТаблицаЗначений") Тогда
		add_list = ПреобразоватьТаблицуЗначенийВМассивСтруктур(add_list);	
	КонецЕсли;
	Если ТипЗнч(add_list) <> Тип("Массив") Тогда
		ВызватьИсключение "В блоке lists_concatenate ошибка: не является списком "+get_prop(block_context,"indexlist", "")+ "элемент";
	КонецЕсли;  
	ДополнитьМассив(valuelist, add_list);
	block_context.Вставить("value", valuelist);	
КонецПроцедуры

Функция block_lists_concatenate_execute(block_type, node, path, context, block_context)
	total_size = block_lists_concatenate_get_list_size(node);
	result = Новый Массив;
	Если Не total_size Тогда
		Возврат result;
	КонецЕсли;	
	Если Не block_context.свойство("indexlist") Тогда
		block_context.Вставить("indexlist", 0);
	КонецЕсли;	
	current_size = block_context["indexlist"];
	Если current_size <> total_size Тогда
		Для j=current_size По total_size-1 Цикл
			block_context["indexlist"] = j;
			node_value = workspace_find_input_by_name(node, "ADD" + j);
			Если node_value = Неопределено Тогда
				Продолжить;
			КонецЕсли;	
			result = block_execute_all_next(node_value, path+"."+j, context, block_context);
			Если result = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			block_lists_concatenate_add(block_context,result);	
		КонецЦикла;
	КонецЕсли;		
	block_check_step(context, block_context);
	Возврат block_context["value"];	
КонецФункции

