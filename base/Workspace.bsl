//DynamicDirective
Функция workspace_init(data, name, logger, own)
	_workspace = Новый Структура();
	_workspace.Вставить("name", name);
	_workspace.Вставить("own", own);
	_workspace.Вставить("data", data);
    _workspace.Вставить("blocks", data);
	_workspace.Вставить("functions", Неопределено);
	_workspace.Вставить("variables", Неопределено);
	workspace_read_variables(_workspace);
	_workspace.Вставить("logger", logger);
    Возврат _workspace
КонецФункции

//DynamicDirective
Функция workspace_read_procedures_and_functions()
	BlocklyExecutor.Workspace.functions = Новый Соответствие;
	РезультатXpath = Workspace.ВычислитьВыражениеXpath("./b:block[@type='procedures_defreturn']", Workspace, размыватель);	
	Пока Истина Цикл
		Узел = РезультатXpath.ПолучитьСледующий();
		Если Узел=Неопределено Тогда Прервать КонецЕсли;
		Name = Workspace.ВычислитьВыражениеXpath("./b:field[@name='NAME']", Узел, размыватель).ПолучитьСледующий();
		BlocklyExecutor.Workspace.functions.Вставить(Name.ТекстовоеСодержимое,Новый Структура("node,type",Узел,"procedures_defreturn"));		
	КонецЦикла;
	
	РезультатXpath = Workspace.ВычислитьВыражениеXpath("./b:block[@type='procedures_defnoreturn']", Workspace, размыватель);	
	Пока Истина Цикл
		Узел = РезультатXpath.ПолучитьСледующий();
		Если Узел=Неопределено Тогда Прервать КонецЕсли;
		Name = Workspace.ВычислитьВыражениеXpath("./b:field[@name='NAME']", Узел, размыватель).ПолучитьСледующий();
		BlocklyExecutor.Workspace.functions.Вставить(Name.ТекстовоеСодержимое,Новый Структура("node,type",Узел,"procedures_defnoreturn"));		
	КонецЦикла;	
КонецФункции

//DynamicDirective
Функция workspace_init_procedure_block(name)
	block_node = BlocklyExecutor.Workspace.functions[name];
	Возврат block_node;
КонецФункции

//DynamicDirective
Процедура workspace_read_variables(_workspace)
	_workspace.variables = Новый Соответствие;
	РезультатXpath = Workspace.ВычислитьВыражениеXpath("./b:variables/b:variable", Workspace, размыватель);	
	Пока Истина Цикл
		Узел = РезультатXpath.ПолучитьСледующий();
		Если Узел = Неопределено Тогда 
			Прервать 
		КонецЕсли;
		name = Узел.ТекстовоеСодержимое;
        _id = Узел.Атрибуты.ПолучитьИменованныйЭлемент("id").ТекстовоеСодержимое;
        _workspace.variables.Вставить(_id, name);
	КонецЦикла;
КонецПроцедуры

//DynamicDirective
Функция workspace_read_child_block(node)
	child = Неопределено;
	Попытка
		child = Workspace.ВычислитьВыражениеXpath("./b:block", node, размыватель).ПолучитьСледующий();
		Если child = Неопределено Тогда 
			Попытка
				child = Workspace.ВычислитьВыражениеXpath("./b:shadow", node, размыватель).ПолучитьСледующий();	
			Исключение
			КонецПопытки;	
		КонецЕсли;	
	Исключение
	КонецПопытки;	
	Возврат child;
КонецФункции

//DynamicDirective
Функция workspace_find_field_by_name(node, name)
	Возврат Workspace.ВычислитьВыражениеXpath("./b:field[@name='"+name+"']", node, размыватель).ПолучитьСледующий().ТекстовоеСодержимое;
КонецФункции

//DynamicDirective
Функция workspace_find_statement_by_name(node, name)
	Если ЗначениеЗаполнено(name) Тогда
		Возврат Workspace.ВычислитьВыражениеXpath("./b:statement[@name='"+name+"']", node, размыватель).ПолучитьСледующий();
	Иначе
		Возврат Workspace.ВычислитьВыражениеXpath("./b:statement", node, размыватель).ПолучитьСледующий();
	КонецЕсли;
КонецФункции

//DynamicDirective
Функция workspace_find_next_statement(node)
	Возврат Workspace.ВычислитьВыражениеXpath("./b:next", node, размыватель).ПолучитьСледующий();	
КонецФункции	

//DynamicDirective
Функция workspace_find_mutation_by_name(node, name, default = Неопределено)
    mutation = Workspace.ВычислитьВыражениеXpath("./b:mutation", node, размыватель).ПолучитьСледующий();
	Если mutation <> Неопределено Тогда
		Mutation_value = mutation.ПолучитьАтрибут(name);
		Возврат ?(Mutation_value = Неопределено, default, Mutation_value);
	КонецЕсли;	
	Возврат default;
КонецФункции

//DynamicDirective
Функция workspace_find_mutation_args(node)
	result = Новый Массив;
	РезультатXpath = Workspace.ВычислитьВыражениеXpath("./b:mutation/b:arg", node, размыватель);	
	Пока Истина Цикл
		Узел = РезультатXpath.ПолучитьСледующий();
		Если Узел=Неопределено Тогда 
			Прервать; 
		КонецЕсли;
		result.Добавить(Узел.ПолучитьАтрибут("name"));		
	КонецЦикла;
    Возврат result
КонецФункции

//DynamicDirective
Функция workspace_find_inputs(node)
	result = Новый Структура;
	Для Каждого child Из node.ДочерниеУзлы Цикл
		Если child.ИмяУзла = "value" Или child.ИмяУзла = "statement" Тогда
			input_name = child.ПолучитьАтрибут("name");
			result.Вставить(input_name, child); 
		КонецЕсли;
	КонецЦикла;
    Возврат result	
КонецФункции

//DynamicDirective
Функция workspace_find_input_by_name(node, name)
	Возврат Workspace.ВычислитьВыражениеXpath("./b:value[@name='"+name+"']", node, размыватель).ПолучитьСледующий();
КонецФункции

//DynamicDirective
Функция workspace_find_fields(node, result = Неопределено)
    result = ?(ЗначениеЗаполнено(result), result, Новый Структура);
    fields = Workspace.ВычислитьВыражениеXpath("./b:field", node, размыватель);	

	Пока Истина Цикл
		Узел = fields.ПолучитьСледующий();
		Если Узел=Неопределено Тогда 
			Прервать 
		КонецЕсли;
		_param_name = Узел.ПолучитьАтрибут("name");
		ВставитьСвойствоЕслиНет(result, _param_name, Узел.ТекстовоеСодержимое);		
	КонецЦикла;
    return result
КонецФункции

//DynamicDirective
Функция workspace_execute_inputs(node, path, context, block_context)
	// BSLLS:CognitiveComplexity-off
	inputs = Workspace.ВычислитьВыражениеXpath("./b:value", node, размыватель);	
	
	Пока Истина Цикл
		Узел = inputs.ПолучитьСледующий();
		Если Узел=Неопределено Тогда 
			Прервать 
		КонецЕсли;
		_param_name = Узел.ПолучитьАтрибут("name");
		blockType =  block_context.__type;
		Если Не block_context.Свойство(_param_name) Тогда
			Попытка
				value = block_execute_all_next(Узел, path +"."+_param_name, context, block_context)
			Исключение
				ИнфОбОшибке = ИнформацияОбОшибке();
				ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
				Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
					ВызватьИсключение ИнфОбОшибке.Описание; // (исходное исключение) 			
				Иначе
					ВызватьИсключение(NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в расчете параметра блока (" + blockType + "."+_param_name+")", add_block_to_dump(block_context)));
				КонецЕсли;
			КонецПопытки;
			Попытка
				ВставитьСвойствоЕслиНет(block_context, _param_name, value);
			Исключение
				ИнфОбОшибке = ИнформацияОбОшибке();
				ВызватьИсключение(NewExtExceptionСтрока(ИнфОбОшибке,,,"Невалидное имя параметра блока (" + blockType + "."+_param_name+ ")", add_block_to_dump(block_context)));
			КонецПопытки;
		КонецЕсли;
	КонецЦикла;
	// BSLLS:CognitiveComplexity-on
КонецФункции

//DynamicDirective
Функция workspace_get_start_block(endpoint, context)
	workspace_read_procedures_and_functions();
	Если ЗначениеЗаполнено(endpoint) Тогда
		block = workspace_init_procedure_block(endpoint);
		Если block = Неопределено Тогда
			ВызватьИсключение NewExtExceptionСтрока(,"Не найден endpoint " + endpoint,,,,"NotFound");
		КонецЕсли;
	Иначе
		block = workspace_init_procedure_block("main");
		Если block = Неопределено Тогда
			ВызватьИсключение NewExtExceptionСтрока(,"Не найден endpoint main",,,,"NotFound");
		КонецЕсли;
	КонецЕсли;
	Возврат block;
КонецФункции

//DynamicDirective
Функция ПолучитьДокументDOM(ХМЛРассчета)	
	ДокументDOM = Новый ПостроительDOM;
	Если ЗначениеЗаполнено(ХМЛРассчета) Тогда
		ЧтениеXML = Новый ЧтениеXML;
		ЧтениеXML.УстановитьСтроку(ХМЛРассчета);
		ПостроительDOM = Новый ПостроительDOM;
		ДокументDOM = ПостроительDOM.Прочитать(ЧтениеXML);
		ЧтениеXML.Закрыть();
		Workspace = ДокументDOM;
		размыватель = новый РазыменовательПространствИменDOM("b", "https://developers.google.com/blockly/xml");
	КонецЕсли;
	Возврат ДокументDOM;
КонецФункции
