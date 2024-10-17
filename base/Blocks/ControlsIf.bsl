//DynamicDirective
Функция block_controls_if_execute(block_type, node, path, context, block_context)
	if_count = Число(workspace_find_mutation_by_name(node, "elseif", 0));
	defined_else = Число(workspace_find_mutation_by_name(node, "else", 0));
	if_complete = Ложь;
	j = Неопределено;
	Для j = 0 По if_count Цикл
		_key = "IF"+j;
		complete = ?(block_context.Свойство(_key), Истина, Ложь);
		Если complete Тогда
			result = block_context[_key];
		Иначе
			node_if = workspace_find_input_by_name(node, "IF" + j);
			Если node_if = Неопределено Тогда
				ВызватьИсключение "Bad " + _key + path;
			КонецЕсли;	
			result = block_execute_all_next(node_if, path+"."+"if"+j, context, block_context);
			ВставитьСвойствоЕслиНет(block_context, _key, result);
		КонецЕсли;	
		Если ЗначениеЗаполнено(result) и не (ТипЗнч(result) = Тип("Булево") и не result) Тогда	
			if_complete = Истина;
			Прервать;
		КонецЕсли;	
	КонецЦикла;
	block_check_step(context, block_context);
	Если if_complete and j <> Неопределено Тогда
		Если НЕ block_context.Свойство("_do") Тогда
			node_do = workspace_find_statement_by_name(node, "DO" + j);
			Если node_do = Неопределено Тогда
				Возврат Неопределено;
			КонецЕсли;
			block_execute_all_next(node_do, path+"."+"do"+j, context, block_context, True);
			ВставитьСвойствоЕслиНет(block_context, "_do", Неопределено);
		КонецЕсли;
	Иначе
		Если defined_else Тогда
			Если НЕ block_context.Свойство("_do") Тогда
				node_do = workspace_find_statement_by_name(node, "ELSE");
				Если node_do = Неопределено Тогда
					Возврат Неопределено;
				КонецЕсли;	
				block_execute_all_next(node_do, path+"."+"else", context, block_context, True);
				ВставитьСвойствоЕслиНет(block_context, "_do", Неопределено);
			КонецЕсли;
		КонецЕсли;	
	КонецЕсли;
	
	Возврат Неопределено;	
КонецФункции

