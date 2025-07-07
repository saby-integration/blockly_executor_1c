 
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
	Если ТипОшибки = "StepForward" или ТипОшибки = "DeferredOperation" или ТипОшибки = "LimitCommand" или ТипОшибки = "AsyncRequest" Тогда
		Возврат Истина;		
	КонецЕсли;
	Возврат Ложь;
КонецФункции

// Рассчитывает вложенные блоки
//
// Параметры:
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//  statement - Булево - Дополнительные параметры обсчета блока
//
// Возвращаемое значение:
//  - Структура - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
//DynamicDirective
Функция block_execute_all_next(node, path, context, block_context, statement = Ложь)
	statement_number = 0;
	Если НЕ block_context.Свойство("child") Тогда
		block_context.Вставить("child", Новый Структура);
	КонецЕсли;
	child_context =  block_context.child;
	result = Неопределено;
	Пока Истина Цикл
		result = РассчитатьСледующийШаг(node, path, context, block_context, child_context, statement, statement_number);
		Если get_prop(result, "Прервать") = Истина Тогда
			Возврат get_prop(result, "Результат");
		КонецЕсли;	
	КонецЦикла;                    
	Возврат get_prop(result, "Результат");
КонецФункции

//DynamicDirective
Функция РассчитатьСледующийШаг(node, path, context, block_context, child_context, statement, statement_number)
	Если Не child_context.Свойство("i" + statement_number) Тогда  
		child_context.Вставить("i" + statement_number, Новый Структура);
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
	context_variables_get(context).Вставить(name, value);
	context.data.Вставить("variable_scopes", context.variable_scopes);
	Возврат Неопределено;
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
	Возврат context_variables_get(context).Получить(name);
КонецФункции
	
#Область include_BlocklyExecutor_base_Helper_СобытияИнтеграции
#КонецОбласти	
