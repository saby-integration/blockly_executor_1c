
Функция block_procedures_defnoreturn_execute(block_type, node, path, context, block_context)
	block_check_step(context, block_context);
	code = workspace_find_statement_by_name(node, "STACK");
	name = workspace_find_field_by_name(node, "NAME");
	Если НЕ block_context.Свойство("_stack") И ТипЗнч(code) = Тип("ЭлементDOM") Тогда
		block_execute_all_next(code, path + "." + name, context, block_context, Истина);	
		ВставитьСвойствоЕслиНет(block_context, "_stack", Неопределено);
	КонецЕсли;
КонецФункции

