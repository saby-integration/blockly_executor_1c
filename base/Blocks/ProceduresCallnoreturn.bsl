//DynamicDirective
Функция block_procedures_callnoreturn_execute(block_type, node, path, context, block_context)
	result = block_procedures_callreturn_execute(block_type, node, path, context, block_context);
	Возврат workspace_find_next_statement(node);
КонецФункции
	
