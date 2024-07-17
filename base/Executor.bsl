Функция blockly_executor_execute(ДокументDOM, endpoint = Неопределено) Экспорт
	blockly_executor_read_procedures_and_functions();
	Если ЗначениеЗаполнено(endpoint) Тогда
		Попытка
			endpoint_node = Functions[endpoint];
		Исключение
			ИнфОбОшибке = ИнформацияОбОшибке();
			ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке,"Не найден endpoint " + endpoint, endpoint,,,"NotFound");
			Возврат Новый Структура("data, status", ОшибкаСтруктура, "error");
		КонецПопытки;
	Иначе
		Попытка
			endpoint_node = Functions["main"];
		Исключение
			ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке,"Не найден endpoint main", "main",,,"NotFound");
			Возврат Новый Структура("data, status", ОшибкаСтруктура, "error");
		КонецПопытки;
	КонецЕсли;
	
	Попытка
		Если context.deferred.Количество() > 0 Тогда
			blockly_executor_execute_deferred(endpoint_node, context);	
		КонецЕсли;
		
		result = block_execute(endpoint_node.type, endpoint_node.node, "", context, context.debug);
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
			commands_data = ПоместитьВоВременноеХранилище(ДанныеДляКоманд, get_prop(context.variables, "ВложенияАдресВХранилище", Новый УникальныйИдентификатор()));
			
			ПреобразоватьСтруктутуКДопустимымXDTOТипам(context.variables);
			Возврат Новый Структура ("step, stepByStep, variables, data, status, commands, commands_data", Currentblock_context.__id, StepByStep, context.variables, Currentblock_context, "run", context.commands, commands_data); 			
		Иначе
			Возврат Новый Структура("data, status", ОшибкаСтруктура, "error");
		КонецЕсли;
		
	КонецПопытки;
	ПреобразоватьСтруктутуКДопустимымXDTOТипам(context.variables);
	Возврат Новый Структура("data, variables, status", result, context.variables, "complete");
КонецФункции

Функция blockly_executor_execute_deferred(endpoint_node, context)
	//_deferred = context.deferred;
	//_commands = context.operation['commands']
	//context.operation['commands'] = []
    Для Каждого _deferred Из context.deferred Цикл
        _context = context_init_deferred(_deferred);
        Попытка
            block_execute(endpoint_node.type, endpoint_node.node, "", _context, _context.debug);
        Исключение 
			//context.context_add_deferred(operation)
			//_delete.append(i)
			//continue
		КонецПопытки
	КонецЦикла;
    context.deferred = Новый массив;
	context.Вставить("Выход_LimitCommand", Ложь);	
КонецФункции

Процедура blockly_executor_read_procedures_and_functions()
	
	Functions = Новый Структура;
	РезультатXpath = Root.ВычислитьВыражениеXpath("./b:block[@type='procedures_defreturn']", Root, размыватель);	
	Пока Истина Цикл
		Узел = РезультатXpath.ПолучитьСледующий();
		Если Узел=Неопределено Тогда Прервать КонецЕсли;
		Name = Root.ВычислитьВыражениеXpath("./b:field[@name='NAME']", Узел, размыватель).ПолучитьСледующий();
		Functions.Вставить(Name.ТекстовоеСодержимое,Новый Структура("node,type",Узел,"procedures_defreturn"));		
	КонецЦикла;
	
	РезультатXpath = Root.ВычислитьВыражениеXpath("./b:block[@type='procedures_defnoreturn']", Root, размыватель);	
	Пока Истина Цикл
		Узел = РезультатXpath.ПолучитьСледующий();
		Если Узел=Неопределено Тогда Прервать КонецЕсли;
		Name = Root.ВычислитьВыражениеXpath("./b:field[@name='NAME']", Узел, размыватель).ПолучитьСледующий();
		Functions.Вставить(Name.ТекстовоеСодержимое,Новый Структура("node,type",Узел,"procedures_defnoreturn"));		
	КонецЦикла;
КонецПроцедуры
