
// Функция block_controls_for_each_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Неопределено - Результат работы метода
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS:NestedStatements-off
// BSLLS:FunctionReturnsSamePrimitive-off
//DynamicDirective
Функция block_controls_for_each_calc_value(block_type, node, path, context, block_context)
	
	required_param = Новый Массив;
	required_param.Добавить("VAR");
	required_param.Добавить("LIST");
	block_check_required_param_in_block_context(required_param, block_context);
	
	Если Не block_context.Свойство("INDEX") Тогда
		block_context.Вставить("INDEX", 0);                 
	КонецЕсли;
	Если Не block_context.Свойство("DeferredOperationIndexes") Тогда
		block_context.Вставить("DeferredOperationIndexes", Новый Соответствие);
	КонецЕсли;

	Список = block_context["LIST"];
	Если Не ЭтоСписочныйТип(Список) Тогда
		dump = Новый Структура("Список",Список);
		ВызватьИсключение NewExtExceptionСтрока(, "В блок цикла передано не итерируемое значение.", 
		get_prop(block_context, "__path"),, dump);
	КонецЕсли;
	
	Пока block_context["INDEX"] < Список.Количество() Цикл
		ДочернийУзел = get_statement_node(node);			
		block_set_variable(context, block_context["VAR"], block_context["INDEX"]);
		Попытка
			block_execute_all_next(ДочернийУзел, path, context, block_context, True); 
		Исключение
			ИнфОбОшибке = ИнформацияОбОшибке();
			ПрерватьЦикл = Ложь;
			ОбработатьОшибкуЦиклическогоБлока(context, block_type, block_context, ИнфОбОшибке, ПрерватьЦикл); 
			Если ПрерватьЦикл Тогда
				Прервать;
			КонецЕсли;				
		КонецПопытки;
		block_context["INDEX"] = block_context["INDEX"] + 1;
	КонецЦикла;
	Возврат Неопределено;
КонецФункции
// BSLLS:NestedStatements-on
// BSLLS:FunctionReturnsSamePrimitive-on

// Функция block_controls_for_each2_calc_value
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//
// Возвращаемое значение:
//  - Неопределено - Результат работы метода
//
//DynamicDirective
// BSLLS:FunctionReturnsSamePrimitive-off
Функция block_controls_for_each2_calc_value(block_type, node, path, context, block_context)
	
	required_param = новый массив;
	required_param.Добавить("VAR");
	required_param.Добавить("LIST");
	block_check_required_param_in_block_context(required_param, block_context);
	
	Если Не block_context.Свойство("INDEX") Тогда
		block_context.Вставить("INDEX", 0);		
	КонецЕсли;
	
	Список = block_context["LIST"];
	//Проверка на ТЧ документа //ТабличнаяЧасть
	Если ЭтоСписочныйТип(Список) Тогда
		Пока block_context["INDEX"] < Список.Количество() Цикл
			ДочернийУзел = get_statement_node(node);
			block_set_variable(context, block_context["VAR"], Список[block_context["INDEX"]]);
			Попытка
				block_execute_all_next(ДочернийУзел, path, context, block_context, True); 
			Исключение
				ИнфОбОшибке = ИнформацияОбОшибке();
				ПрерватьЦикл = Ложь;
				ОбработатьОшибкуЦиклическогоБлока(context, block_type, block_context, ИнфОбОшибке, ПрерватьЦикл); 
				Если ПрерватьЦикл Тогда
					Прервать;
				КонецЕсли;	
			КонецПопытки;

			block_context["INDEX"] = block_context["INDEX"] + 1;
		КонецЦикла;	
	Иначе
		dump = Новый Структура("Список",Список);
		ВызватьИсключение NewExtExceptionСтрока(, "В блок цикла передано не итерируемое значение.", 
													get_prop(block_context, "__path"), , dump);
	КонецЕсли;
	Возврат Неопределено;
КонецФункции
// BSLLS:FunctionReturnsSamePrimitive-on

// Функция get_statement_node
//
// Параметры:
// 	node - Структура - Dom структура хмл
//
// Возвращаемое значение:
//  - XML - Результат работы метода
//DynamicDirective
Функция get_statement_node(node)
	// BSLLS:MissingCodeTryCatchEx-off
	// Сохраняем идентичность со структурой кода в Питоне
	// Код должен отработать
	Return_node = Неопределено;
	Попытка
		Return_node = Workspace.ВычислитьВыражениеXpath("./b:statement", node, размыватель).ПолучитьСледующий();	
	Исключение
	КонецПопытки;	
	// BSLLS:MissingCodeTryCatchEx-on
	Возврат Return_node;
КонецФункции

// Функция ЭтоСписочныйТип
//
// Параметры:
// 	Список - Проверяемый объект
//
// Возвращаемое значение:
//  - Булево - Результат работы метода
//DynamicDirective
Функция ЭтоСписочныйТип(Список)
	Возврат	ТипЗнч(Список) = Тип("Массив") 
		ИЛИ ТипЗнч(Список) = Тип("СписокЗначений") 
		ИЛИ ТипЗнч(Список) = Тип("ТаблицаЗначений")
		ИЛИ ЭтоТипТабличнаяЧасть(Список);
КонецФункции
