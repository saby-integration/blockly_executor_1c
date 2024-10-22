//DynamicDirective
Функция block_procedures_defreturn_execute(block_type, node, path, context, block_context)
	block_procedures_defnoreturn_execute("procedures_defnoreturn", node, path, context, block_context);
	
	_return_node = workspace_find_input_by_name(node, "RETURN");
	name = workspace_find_field_by_name(node, "NAME");
	res = block_execute_all_next(_return_node, path + "." + name, context, block_context);
	Возврат res;;
КонецФункции

