
#Область include_BlocklyExecutor_base_BlockTemplates_Api3Blocks 
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_C1Blocks 
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_EDOBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_ExtsyncdocBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_ExtsysBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_FunctionBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_IndicatorBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_IntegrationBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_ListBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_LogicBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_LoopBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_MathBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_ObjBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_SettingsBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_TestBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_TextBlocks
#КонецОбласти

#Область include_BlocklyExecutor_base_BlockTemplates_VariablesBlocks
#КонецОбласти

Функция simple_block_get_nodes_fields(node, block_context)
	fields = Новый Массив;
	Попытка
		РезультатXpath = Root.ВычислитьВыражениеXpath("./b:field", node, размыватель);	
		Пока Истина Цикл
			Узел = РезультатXpath.ПолучитьСледующий();
			Если Узел=Неопределено Тогда Прервать КонецЕсли;
			fields.Добавить(Узел);		
		КонецЦикла;
	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
		ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке,,,,add_block_to_dump(block_context));
	КонецПопытки;
	
	Возврат fields;	
КонецФункции	

Функция simple_block_get_nodes_args(node)	
	args = Новый Массив;
	РезультатXpath = Root.ВычислитьВыражениеXpath("./b:value", node, размыватель);	
	Пока Истина Цикл
		Узел = РезультатXpath.ПолучитьСледующий();
		Если Узел=Неопределено Тогда Прервать КонецЕсли;
		args.Добавить(Узел);		
	КонецЦикла;
	Возврат args; 	
КонецФункции

Процедура simple_block_get_fields(node, path, context, block_context)
	fields = simple_block_get_nodes_fields(node, block_context);
	Если Не fields = Неопределено Тогда
		Для i=0 По fields.Количество()-1 Цикл
			_param_name = fields[i].ПолучитьАтрибут("name");
			ВставитьСвойствоЕслиНет(block_context, _param_name, fields[i].ТекстовоеСодержимое);
		КонецЦикла;	
	КонецЕсли;		
КонецПроцедуры	

Процедура simple_block_get_args(node, path, context, block_context)
	Args = simple_block_get_nodes_args(node);
	blockType =  block_context.__type;
	Если Не args = Неопределено Тогда
		Для i=0 По args.Количество()-1 Цикл
			_param_name = args[i].ПолучитьАтрибут("name");
			Если Не block_context.Свойство(_param_name) Тогда
				Попытка
					value = block_execute_all_next(Args[i], path +"."+_param_name, context, block_context)
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
	КонецЕсли;						
КонецПроцедуры	

Функция block_check_required_param_in_block_context(required_param, block_context)
	Для каждого param Из required_param Цикл
		Если Не block_context.Свойство(param) Тогда
			raise "Параметр " + param + " не определен"
		КонецЕсли;	
	КонецЦикла;	
КонецФункции	
