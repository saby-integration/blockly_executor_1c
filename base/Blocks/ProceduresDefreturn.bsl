Функция block_procedures_defreturn_execute(block_type, node, path, context, block_context)
	_none = block_procedures_defnoreturn_execute("procedures_defnoreturn", node, path, context, block_context);
	//Если НЕ block_context.Свойство("result") Тогда
	_return_node = block_procedures_defreturn_block_get_node_return(node);
	ИмяФункции = block_procedures_defnoreturn_get_func_name(node);
	res = block_execute_all_next(_return_node, path + "." + ИмяФункции, context, block_context);
	//	ВставитьСвойствоЕслиНет(block_context, "result", res);
	//КонецЕсли;
	Возврат res;
КонецФункции

Функция block_procedures_defreturn_block_get_node_return(node)
	
	Возврат Root.ВычислитьВыражениеXpath("./b:value[@name='RETURN']", node, размыватель).ПолучитьСледующий(); 
КонецФункции	
