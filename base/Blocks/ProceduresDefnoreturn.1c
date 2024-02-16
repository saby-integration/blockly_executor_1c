
Функция block_procedures_defnoreturn_execute(block_type, node, path, context, block_context)
	block_check_step(context, block_context);
	code = block_get_node_stack(node);
	Если НЕ block_context.Свойство("_stack") И ТипЗнч(code) = Тип("ЭлементDOM") Тогда
		ИмяФункции = block_procedures_defnoreturn_get_func_name(node);
		block_execute_all_next(code, path + "." + ИмяФункции, context, block_context, Истина);	
		ВставитьСвойствоЕслиНет(block_context, "_stack", Неопределено);
	КонецЕсли;
КонецФункции

Функция block_procedures_defnoreturn_get_func_name(node)
	
	Возврат Root.ВычислитьВыражениеXpath("./b:field[@name='NAME']", node, размыватель).ПолучитьСледующий().ТекстовоеСодержимое;
КонецФункции

Функция block_procedures_defnoreturn_get_node_stack(node)
	
	Возврат Неопределено;
КонецФункции
