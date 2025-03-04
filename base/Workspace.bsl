
// workspace_init
//
// Параметры:
//  data - Структура - data
//  name - Строка - name
//  logger - Структура - logger
//  own - Структура - own
//
// Возвращаемое значение:
// Структура - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
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
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on

// Функция ********************************
//
// Возвращаемое значение:
//  - Неопределено - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
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
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on

// Функция workspace_init_procedure_block
//
// Параметры:
//  name - Строка - Имя блока
//
// Возвращаемое значение:
//  - block_node - Результат обсчета алгоритма
//DynamicDirective
Функция workspace_init_procedure_block(name)
	block_node = BlocklyExecutor.Workspace.functions[name];
	Возврат block_node;
КонецФункции

// workspace_read_variables
//
// Параметры:
//  _workspace - Структура - workspace
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
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
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on

// Функция workspace_read_child_block
//
// Параметры:
//  node - Структура - Dom структура хмл
//
// Возвращаемое значение:
//  - РезультатXPath - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingCodeTryCatchEx-off
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
// BSLLS:MissingCodeTryCatchEx-on
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on

// Функция workspace_find_field_by_name
//
// Параметры:
//  node - Структура - Dom структура хмл
//  name - Строка - Имя блока
//
// Возвращаемое значение:
//  - РезультатXPath - Результат обсчета алгоритма
//
//DynamicDirective
Функция workspace_find_field_by_name(node, name)
	Возврат Workspace.ВычислитьВыражениеXpath("./b:field[@name='"+name+"']", node, размыватель).ПолучитьСледующий().ТекстовоеСодержимое;
КонецФункции

// Функция workspace_find_statement_by_name
//
// Параметры:
//  node - Структура - Dom структура хмл
//  name - Строка - Имя блока
//
// Возвращаемое значение:
//  - РезультатXPath - Результат обсчета алгоритма
//
//DynamicDirective
Функция workspace_find_statement_by_name(node, name)
	Если ЗначениеЗаполнено(name) Тогда
		Возврат Workspace.ВычислитьВыражениеXpath("./b:statement[@name='"+name+"']", node, размыватель).ПолучитьСледующий();
	Иначе
		Возврат Workspace.ВычислитьВыражениеXpath("./b:statement", node, размыватель).ПолучитьСледующий();
	КонецЕсли;
КонецФункции

// Функция ********************************
//
// Параметры:
//  node - Структура - Dom структура хмл
//
// Возвращаемое значение:
//  - РезультатXPath - Результат обсчета алгоритма
//
//DynamicDirective
Функция workspace_find_next_statement(node)
	Возврат Workspace.ВычислитьВыражениеXpath("./b:next", node, размыватель).ПолучитьСледующий();	
КонецФункции	

// Функция workspace_find_mutation_by_name
//
// Параметры:
//  node - Структура - Dom структура хмл
//  name - Строка - Имя блока
//  default - Составное - Значение по умолчанию
//
// Возвращаемое значение:
//  - Составное - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:UnusedLocalVariable-off
// BSLLS:FunctionShouldHaveReturn-off
// BSLLS:MissingParameterDescription-off
//DynamicDirective
Функция workspace_find_mutation_by_name(node, name, default = Неопределено)
    mutation = Workspace.ВычислитьВыражениеXpath("./b:mutation", node, размыватель).ПолучитьСледующий();
	Если mutation <> Неопределено Тогда
		Mutation_value = mutation.ПолучитьАтрибут(name);
		Возврат ?(Mutation_value = Неопределено, default, Mutation_value);
	КонецЕсли;	
	Возврат default;
КонецФункции
// BSLLS:UnusedLocalVariable-on
// BSLLS:FunctionShouldHaveReturn-on
// BSLLS:MissingParameterDescription-on

// Функция workspace_find_mutation_args
//
// Параметры:
//  node - Структура - Dom структура хмл
//
// Возвращаемое значение:
//  - РезультатXPath - ВычислитьВыражениеXpath
//
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
    Возврат result;
КонецФункции

// Функция workspace_find_inputs
//
// Параметры:
//  node - Структура - Dom структура хмл
//
// Возвращаемое значение:
//  - Структура - result
//
//DynamicDirective
Функция workspace_find_inputs(node)
	result = Новый Структура;
	Для Каждого child Из node.ДочерниеУзлы Цикл
		Если child.ИмяУзла = "value" Или child.ИмяУзла = "statement" Тогда
			input_name = child.ПолучитьАтрибут("name");
			result.Вставить(input_name, child); 
		КонецЕсли;
	КонецЦикла;
    Возврат result;
КонецФункции

// Функция workspace_find_input_by_name
//
// Параметры:
//  node - Структура - Dom структура хмл
//  name - Строка - Имя блока
//
// Возвращаемое значение:
//  - ПостроительDOM - Результат обсчета алгоритма
//
//DynamicDirective
Функция workspace_find_input_by_name(node, name)
	Возврат Workspace.ВычислитьВыражениеXpath("./b:value[@name='"+name+"']", node, размыватель).ПолучитьСледующий();
КонецФункции

// Функция workspace_find_fields
//
// Параметры:
//  node - Структура - Dom структура хмл
//  result - Структура - result
//
// Возвращаемое значение:
//  - ПостроительDOM - result
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:FunctionOutParameter-off
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
    Возврат result;
КонецФункции
// BSLLS:FunctionOutParameter-on

// Функция workspace_execute_inputs
//
// Параметры:
//  node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Неопределено - Результат обсчета алгоритма
//
// BSLLS:CognitiveComplexity-off
// Сохраняем идентичность со структурой кода в Питоне
//DynamicDirective
Функция workspace_execute_inputs(node, path, context, block_context)
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
	Возврат Неопределено;
КонецФункции
// BSLLS:CognitiveComplexity-on

// Функция workspace_get_start_block
//
// Параметры:
//  endpoint - Строка - Точка входа
//  context - Структура - Общий контекст алгоритма
//
// Возвращаемое значение:
//  - ДокументDOM - block
//
//DynamicDirective
Функция workspace_get_start_block(endpoint, context)
	workspace_read_procedures_and_functions();
	Если ЗначениеЗаполнено(endpoint) Тогда
		block = workspace_init_procedure_block(endpoint);
		Если block = Неопределено Тогда
			ВызватьИсключение NewExtExceptionСтрока(, "Не найден endpoint " + endpoint, , , ,"NotFound");
		КонецЕсли;
	Иначе
		block = workspace_init_procedure_block("main");
		Если block = Неопределено Тогда
			ВызватьИсключение NewExtExceptionСтрока(, "Не найден endpoint main", , , ,"NotFound");
		КонецЕсли;
	КонецЕсли;
	Возврат block;
КонецФункции

// Функция ПолучитьДокументDOM
//
// Параметры:
//  ХМЛРассчета - XML - ХМЛ Рассчета
//
// Возвращаемое значение:
//  - ПостроительDOM - ДокументDOM
//
//DynamicDirective
Функция ПолучитьДокументDOM(ХМЛРассчета)	
	ДокументDOM = Новый ПостроительDOM;
	Если ЗначениеЗаполнено(ХМЛРассчета) Тогда
		ЧтениеXML = Новый ЧтениеXML;
		ЧтениеXML.УстановитьСтроку(ХМЛРассчета);
		ПостроительDOM = Новый ПостроительDOM;
		ДокументDOM = ПостроительDOM.Прочитать(ЧтениеXML);
		ЧтениеXML.Закрыть();
// BSLLS:UnusedLocalVariable-off
// глобальная переменная модуля
		Workspace = ДокументDOM;
		размыватель = Новый РазыменовательПространствИменDOM("b", "https://developers.google.com/blockly/xml");
// BSLLS:UnusedLocalVariable-on		
	КонецЕсли;
	Возврат ДокументDOM;
КонецФункции
