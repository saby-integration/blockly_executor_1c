
//DynamicDirective
Процедура simple_block_before_execute(node, path, context, block_context)
	
	workspace_find_fields(node, block_context);
    workspace_execute_inputs(node, path, context, block_context);
	
	block_check_step(context, block_context);

КонецПроцедуры

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

Функция block_check_required_param_in_block_context(required_param, block_context)
	Для каждого param Из required_param Цикл
		Если Не block_context.Свойство(param) Тогда
			raise "Параметр " + param + " не определен"
		КонецЕсли;	
	КонецЦикла;	
КонецФункции	
