 
 //DynamicDirective

Функция get_subtitle_from_comment_id(node, block_context)
	Subtitle = workspace_find_comment(node);
	Если Не ЗначениеЗаполнено(Subtitle) Тогда
		Subtitle = get_prop(block_context, "__id");
	КонецЕсли;
	Возврат Subtitle; 
КонецФункции
 
// Запускает обсчет алгоритма
//
// Параметры:
//  block_context - Структура - Контекст исполняемого блока
//  dump - Структура - Вложенность взаимосвязанных ошибок
//
// Возвращаемое значение:
//  - Структура - Вложенность взаимосвязанных ошибок
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:FunctionOutParameter-off
//
//DynamicDirective
Функция add_block_to_dump(block_context, dump = Неопределено)
	Если dump = Неопределено Тогда
		dump = Новый Структура("block_id, block_type, block_path", block_context.__id, block_context.__type, block_context.__path);
	Иначе
		ВставитьСвойствоЕслиНет(dump, "block_id", block_context.__id);
		ВставитьСвойствоЕслиНет(dump, "block_type", block_context.__type);
		ВставитьСвойствоЕслиНет(dump, "block_path", block_context.__path);
	КонецЕсли;
	Результат = dump;
	Возврат Результат;
КонецФункции
// BSLLS:FunctionOutParameter-on

// Запускает обсчет алгоритма
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Структура - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:FunctionOutParameter-off
//
//DynamicDirective
Функция block_execute(block_type, node, path, context, block_context)
	block_disabled = node.ПолучитьАтрибут("disabled");
	Если block_disabled = "true" Тогда
		Возврат Неопределено;
	КонецЕсли;
	blockType = node.ПолучитьАтрибут("type");
	path = path + "." + blockType;
	block_context.Вставить("__id", node.ПолучитьАтрибут("id"));
	block_context.Вставить("__path", path);
	block_context.Вставить("__type", blockType);
	Попытка  
		result = block_execute_ontype(block_type, node, path, context, block_context);
	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
		ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
		Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
			ВызватьИсключение ИнфОбОшибке.Описание; // (исходное исключение) 			
		Иначе	
			ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке, , , "Ошибка в блоке (" + blockType + ")", add_block_to_dump(block_context));	
		КонецЕсли;
	КонецПопытки;
	Возврат result;
КонецФункции
// BSLLS:FunctionOutParameter-on

// Запускает обсчет алгоритма
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Структура - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
//DynamicDirective
Функция block_execute_ontype(block_type, node, path, context, block_context)
	БлокВыполнен = Ложь;
	Если Не БлокВыполнен Тогда
		result = block_execute_function(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;	
	Если Не БлокВыполнен Тогда
		result = block_execute_base(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;	
	Если Не БлокВыполнен Тогда 
		result = block_execute_c1(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_edo(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_settings(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = simple_block_execute_extsys(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = simple_block_execute_integration(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_indicator(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = simple_block_execute_test(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = simple_api3_block_execute(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = simple_esd_block(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		ВызватьИсключение NewExtExceptionСтрока(, "Нет реализации для блока", block_type);
	КонецЕсли;
	ВставитьСвойствоЕслиНет(block_context, "result", result);
	ВставитьСвойствоЕслиНет(block_context, "_result", result);
	Возврат result;
КонецФункции

//DynamicDirective
Функция block_execute_base(block_type, node, path, context, block_context, БлокВыполнен)
	Если Не БлокВыполнен Тогда 
		result = block_execute_logic(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_loop(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_math(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_text(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_list(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_obj(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_variables(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда 
		result = block_execute_datetime(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Возврат result;
КонецФункции

// Служебная, предопределнная и ожидаемая ошибка в блоке, требующая дальнейшей обработки
//
// Параметры:
//  ТипОшибки - Строка - Название ошибки
//
// Возвращаемое значение:
//  - Булево - Проверка типа ошибки
//
//DynamicDirective
Функция ЭтоСлужебнаяОшибкаБлока(ТипОшибки)
	СлужебныеТипыОшибок = Новый Массив;
	СлужебныеТипыОшибок.Добавить("StepForward");
	СлужебныеТипыОшибок.Добавить("DeferredOperation");
	СлужебныеТипыОшибок.Добавить("DeferredComplete");
	СлужебныеТипыОшибок.Добавить("LimitCommand");
	СлужебныеТипыОшибок.Добавить("AsyncRequest");
	СлужебныеТипыОшибок.Добавить("LoopBreak");
	СлужебныеТипыОшибок.Добавить("LoopContinue");
	
	Если СлужебныеТипыОшибок.Найти(ТипОшибки) <> Неопределено Тогда
		Возврат Истина;		
	КонецЕсли;
	Возврат Ложь;

КонецФункции

//DynamicDirective

Функция ЭтоПроблемаСДоступомКСервису(ИмяИсключения)
	МассивПользовательскихИсключений = Новый Массив;
	МассивПользовательскихИсключений.Добавить("TimeOut");
	МассивПользовательскихИсключений.Добавить("ServiceUnavailable");
	Если МассивПользовательскихИсключений.Найти(ИмяИсключения) = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	Возврат Истина;
КонецФункции

//DynamicDirective

Функция ЭтоПользовательскоеИсключение(ИмяИсключения)
	МассивПользовательскихИсключений = Новый Массив;
	МассивПользовательскихИсключений.Добавить("UserException");
	МассивПользовательскихИсключений.Добавить("UserKeyNotFound");
	МассивПользовательскихИсключений.Добавить("Unauthorized");
	МассивПользовательскихИсключений.Добавить("UserCancel");
	Если МассивПользовательскихИсключений.Найти(ИмяИсключения) = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	Возврат Истина;
КонецФункции

// Рассчитывает вложенные блоки
//
// Параметры:
// 	node - Структура - Dom структура хмл
//  path - Строка - Путь до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//  statement - Булево - Дополнительные параметры обсчета блока
//  default_child_context - Структура - контекст по умолчанию для вложенных блоков
//
// Возвращаемое значение:
//  - Структура - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
//DynamicDirective
Функция block_execute_all_next(node, path, context, block_context, statement = Ложь, Знач default_child_context = Неопределено)
	statement_number = 0;
	Если НЕ block_context.Свойство("child") Тогда
		block_context.Вставить("child", Новый Структура);
	КонецЕсли;
	child_context =  block_context.child;
	result = Неопределено;
	Пока Истина Цикл
		result = РассчитатьСледующийШаг(node, path, context, block_context, child_context, statement, statement_number, default_child_context);
		Если get_prop(result, "Прервать") = Истина Тогда
			Возврат get_prop(result, "Результат");
		КонецЕсли;	
	КонецЦикла;                    
	Возврат get_prop(result, "Результат");
КонецФункции

//DynamicDirective

Функция РассчитатьСледующийШаг(node, path, context, block_context, child_context, statement, statement_number, Знач default_child_context)
	Если default_child_context = Неопределено Тогда
		default_child_context = Новый Структура;
	КонецЕсли;
	Если Не child_context.Свойство("i" + statement_number) Тогда  
		child_context.Вставить("i" + statement_number, default_child_context);
	КонецЕсли;
	child = workspace_read_child_block(node);
	next_node = Неопределено;
	Если НЕ child = Неопределено  Тогда
		next_node = ?(statement, workspace_find_next_statement(child), Неопределено);
		block_subtype = child.ПолучитьАтрибут("type");
		Если НЕ child_context.Свойство("__result") Тогда
			result = block_execute(block_subtype, child, path, context, child_context["i" + statement_number]);
		КонецЕсли;
		
	Иначе
		result = Неопределено;
	КонецЕсли;
	Если НЕ next_node = Неопределено Тогда
		// BSLLS:FunctionOutParameter-off
		// Сохраняем идентичность со структурой кода в Питоне			
		Попытка
			node = next_node;
		Исключение
			node = Неопределено;
			node = next_node;
			Возврат Новый Структура("Прервать, Результат", Истина, result);
		КонецПопытки;
		// BSLLS:FunctionOutParameter-on			
		child_context["i" + statement_number].Вставить("__result", True);
		statement_number = statement_number + 1;
	Иначе
		block_context.Удалить("child");
		Возврат Новый Структура("Прервать, Результат", Истина, result);
	КонецЕсли;
	Возврат Новый Структура("Прервать, Результат", Ложь, result);
КонецФункции

// Проверить на отладку текущий блок, и остановиться, если требуется
//
// Параметры:
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Сохраняем идентичность со структурой кода в Питоне
//DynamicDirective
Процедура block_check_step(context, block_context)	
	Если ЗначениеЗаполнено(context.debug_mode) Тогда
		Если context.is_next_step = Истина Тогда
			Если context.debug_mode = "step" Тогда
				dump = СформироватьДамп(block_context.__id, context, block_context, BlocklyExecutor.workspace.name);
				ВызватьИсключение NewExtExceptionСтрока(, , , , dump, "StepForward");
			Иначе
				context.current_block = block_context.__id;
				context.current_workspace = BlocklyExecutor.workspace.name;
			КонецЕсли;
		КонецЕсли;
		check_step_current_algorithm_breakpoints(context, block_context);		
	КонецЕсли;
КонецПроцедуры

//DynamicDirective
Процедура check_step_current_algorithm_breakpoints(context, block_context)
	Если block_context.__id = context.current_block И context.current_workspace = BlocklyExecutor.workspace.name Тогда
		Если BlocklyExecutor.current_algorithm_breakpoints <> Неопределено Тогда
			Если BlocklyExecutor.current_algorithm_breakpoints.Найти(block_context.__id) <> Неопределено 
				И context.is_next_step = Истина Тогда
				dump = СформироватьДамп(block_context.__id, context, block_context, BlocklyExecutor.workspace.name);
				ВызватьИсключение NewExtExceptionСтрока(, , , , dump, "StepForward");
			КонецЕсли;
		КонецЕсли;
		Если context.debug_mode = "step" Тогда
			Если context.is_next_step = Ложь Тогда  
				dump = СформироватьДамп(block_context.__id, context, block_context, BlocklyExecutor.workspace.name);
				ВызватьИсключение NewExtExceptionСтрока(, , , , dump, "StepForward");
			КонецЕсли;
		КонецЕсли;
		context.is_next_step = Истина;
	КонецЕсли;	
КонецПроцедуры

//DynamicDirective
Функция СформироватьДамп(id, context, block_context, workspace_name)
	dump = Новый Структура("block_id, context, block_context, workspace_name");
	dump.block_id = id;
	dump.context = context;
	dump.block_context = block_context; 
	dump.workspace_name = workspace_name;
	Возврат dump; 	
КонецФункции

// Получить класс блоков
//
// Параметры:
//  block_subtype - Строка - Тип блока
//  blocks - Структура - Список блоков
//
// Возвращаемое значение:
//  - Структура - класс блока
//
//DynamicDirective
Функция block_get_block_class(block_subtype, blocks=Неопределено)
	Возврат Неопределено;
КонецФункции	

// BSLLS:FunctionReturnsSamePrimitive-off

// Установить значение переменной
//
// Параметры:
//  context - Структура - Общий контекст алгоритма
//  name - Строка - Название переменной
//  value - Произвольный - Значение переменной
//
// Возвращаемое значение:
//  - Неопределено - Блок ничего не возвращает
//
//DynamicDirective
Функция block_set_variable(context, name, value)
	Результат = Неопределено;	
	Если get_prop(context, "variable_scope_deferred_index") <> Неопределено
		И get_prop(context.block_context, "__variables_outside_deferred") <> Неопределено
		И context.variable_scope_deferred_index = context.variable_scope_current
	    И ЕстьСвойствоВСоответствии(name, context.block_context["__variables_outside_deferred"]) Тогда
		
		context.block_context["__variables_outside_deferred"].Вставить(name, value);
	КонецЕсли;
	context_variables_get(context).Вставить(name, value);
	context.data.Вставить("variable_scopes", context.variable_scopes); 
   	Возврат Результат;
КонецФункции
// BSLLS:FunctionReturnsSamePrimitive-on

//DynamicDirective

Функция ЕстьСвойствоВСоответствии(Свойство, Знач Соотв)
	Если get_prop(Соотв, Свойство) <> Неопределено Тогда
		Возврат Истина;
	Иначе
		КоличествоПеременныхДо = Соотв.Количество();
		Соотв.Вставить(Свойство, Неопределено);
		КоличествоПеременныхПосле = Соотв.Количество();
		Если КоличествоПеременныхДо = КоличествоПеременныхПосле Тогда
			Возврат	Истина;	
		КонецЕсли;
		Соотв.Удалить(Свойство);
		Возврат Ложь;
	КонецЕсли;
КонецФункции


// Получить значение переменной
//
// Параметры:
//  context - Структура - Общий контекст алгоритма
//  name - Строка - Название переменной     
//
// Возвращаемое значение:
//  - Произвольный - Переменная
//
//DynamicDirective
Функция block_get_variable(context, name)
	Если get_prop(context, "variable_scope_deferred_index") <> Неопределено
		И context.variable_scope_deferred_index = context.variable_scope_current Тогда 
		
		Попытка
			Возврат context.block_context["__variables_outside_deferred"].Получить(name);
		Исключение 
			Возврат context_variables_get(context).Получить(name)	
		КонецПопытки;		 	
	КонецЕсли; 
	
	Возврат context_variables_get(context).Получить(name);
КонецФункции
	
//DynamicDirective

Процедура ОбработатьОшибкуЦиклическогоБлока(context, block_type, block_context, ИнфОбОшибке, ПрерватьЦикл, РаботаетСОтложеннымиДействиями = Ложь)
	ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
	Если ЭтоСлужебнаяОшибкаБлока(ОшибкаСтруктура.type) Тогда
		Если ОшибкаСтруктура.type = "DeferredOperation" И РаботаетСОтложеннымиДействиями Тогда
			ОшибкаСтруктура.dump.Вставить("multi_thread_loop_block_context", block_context);			
			ОшибкаСтруктура.dump.Вставить("multi_thread_loop_variable_scopes", Saby_КопияМассива(context.variable_scopes, context.variable_scope_deferred_index + 1));		
			context_add_deferred(context, ОшибкаСтруктура.dump);
			block_context.Удалить("child");
		ИначеЕсли ОшибкаСтруктура.type = "LoopBreak" Тогда
			block_multithreadloop_clear_child_context(block_context); 
			ПрерватьЦикл = Истина;
			Возврат;
		ИначеЕсли ОшибкаСтруктура.type = "LoopContinue" Тогда
			block_multithreadloop_clear_child_context(block_context); 
			Возврат;
		Иначе
			ВызватьИсключение ИнфОбОшибке.Описание;  			
		КонецЕсли
	Иначе	
		ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context));	
	КонецЕсли;		
КонецПроцедуры	
	
#Область include_BlocklyExecutor_base_Helper_СобытияИнтеграции
#КонецОбласти	
