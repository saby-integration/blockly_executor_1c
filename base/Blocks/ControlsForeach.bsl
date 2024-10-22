//DynamicDirective
Функция block_controls_for_each_calc_value(block_type, node, path, context, block_context)
	Если context.is_deferred Тогда
        ДочернийУзел = get_statement_node(node);
		block_set_variable(context, block_context["VAR"], block_context["INDEX"]);
		block_execute_all_next(ДочернийУзел, path, context, block_context, True);
        Возврат Неопределено;
	КонецЕсли;
	
	required_param = новый массив;
	required_param.Добавить("VAR");
	required_param.Добавить("LIST");
	block_check_required_param_in_block_context(required_param, block_context);
	
	Если Не block_context.Свойство("INDEX") Тогда
		block_context.Вставить("INDEX", 0);                 
	КонецЕсли;
	Если Не block_context.Свойство("DeferredOperationIndexes") Тогда
		block_context.Вставить("DeferredOperationIndexes", Новый Соответствие);
	КонецЕсли;
	
	Список = get_prop(block_context, "LIST");
	Если Список = Неопределено Тогда
		Возврат Неопределено;
	ИначеЕсли 	ТипЗнч(Список) = Тип("Массив") 
				ИЛИ ТипЗнч(Список) = Тип("СписокЗначений") 
				ИЛИ ТипЗнч(Список) = Тип("ТаблицаЗначений")
				ИЛИ ЭтоТипТабличнаяЧасть(Список) Тогда
		Пока block_context["INDEX"] < Список.Количество() Цикл
			Попытка
				context_check_command_limit();
			Исключение
				block_multithreadloop_clear_child_context(block_context);
				ИнфОбОшибке = ИнформацияОбОшибке();
				ВызватьИсключение ИнфОбОшибке.Описание;
			КонецПопытки;
			ДочернийУзел = get_statement_node(node);			
			block_set_variable(context, block_context["VAR"], block_context["INDEX"]);
			Попытка
				block_execute_all_next(ДочернийУзел, path, context, block_context, True); 
			Исключение
				ИнфОбОшибке = ИнформацияОбОшибке();
				ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
				Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
					Если ОшибкаСтруктура.type = "DeferredOperation" Тогда
						context_add_deferred(ОшибкаСтруктура);
						block_context.Удалить("child");
					Иначе
						ВызватьИсключение ИнфОбОшибке.Описание;  			
					КонецЕсли
				Иначе	
					ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context));	
				КонецЕсли;
			КонецПопытки;
			block_context["INDEX"] = block_context["INDEX"] + 1;
		КонецЦикла;
		Если context["commands"].Количество() > 0 Тогда
			ВызватьИсключение NewExtExceptionСтрока(,"LimitCommand",,,,"LimitCommand");		
		КонецЕсли;
	Иначе
		dump = Новый Структура("Список",Список);
		ВызватьИсключение NewExtExceptionСтрока(,"В блок цикла передано не итерируемое значение.", block_context["_path"],,dump );
	КонецЕсли;
КонецФункции

//DynamicDirective
Функция block_controls_for_each2_calc_value(block_type, node, path, context, block_context)
	required_param = новый массив;
	required_param.Добавить("VAR");
	required_param.Добавить("LIST");
	block_check_required_param_in_block_context(required_param, block_context);
	
	Если Не block_context.Свойство("INDEX") Тогда
		block_context.Вставить("INDEX", 0);		
	КонецЕсли;
	
	Список = get_prop(block_context, "LIST");
	Если Список = Неопределено Тогда
		Возврат Неопределено;
	ИначеЕсли 	ТипЗнч(Список) = Тип("Массив") 
		//Проверка на ТЧ документа //ТабличнаяЧасть
				ИЛИ ТипЗнч(Список) = Тип("СписокЗначений") 
				ИЛИ ТипЗнч(Список) = Тип("ТаблицаЗначений")	
				ИЛИ ЭтоТипТабличнаяЧасть(Список) Тогда
		Пока block_context["INDEX"] < Список.Количество() Цикл
			ДочернийУзел = get_statement_node(node);
			block_set_variable(context, block_context["VAR"], Список[block_context["INDEX"]]);
			block_execute_all_next(ДочернийУзел, path, context, block_context, True);
			block_context["INDEX"] = block_context["INDEX"] + 1;
		КонецЦикла;	
	Иначе
		dump = Новый Структура("Список",Список);
		ВызватьИсключение NewExtExceptionСтрока(,"В блок цикла передано не итерируемое значение.", get_prop(block_context, "__path"),,dump );
	КонецЕсли;
КонецФункции

//DynamicDirective
Функция get_statement_node(node)
	Return_node = Неопределено;
	Попытка
		Return_node = Workspace.ВычислитьВыражениеXpath("./b:statement", node, размыватель).ПолучитьСледующий();	
	Исключение
	КонецПопытки;	
	Возврат Return_node;
КонецФункции
