Функция  block_multithreadloop_execute_item(block_type, node, path, context, block_context, statement=False)
	Если block_type = "saby_read_changes" Тогда
		saby_read_changes_execute_item(node, path, context, block_context);
	Иначе	
		Block_execute_all_next(node, path, context, block_context, statement);
	КонецЕсли;
КонецФункции

Функция  block_multithreadloop_execute_get_items(block_type, node_loop, path, context, block_context, local_context)
	Если block_type = "saby_read_changes" Тогда
        block_context.Вставить("items", saby_read_changes_get_items(context, block_context));
	ИначеЕсли block_type = "saby_extsyncobj_list" Тогда
        block_context.Вставить("items", saby_extsyncobj_list_items(context, block_context));
	ИначеЕсли block_type = "saby_task_list" Тогда
        block_context.Вставить("items", saby_task_list_items(context, block_context));
	ИначеЕсли block_type = "accounting_entries_list" Тогда
        block_context.Вставить("items", accounting_entries_list_items(context, block_context, local_context));
	ИначеЕсли block_type = "controls_forEachAsync" Тогда
        block_context.Вставить("items", controls_forEachAsync_get_items(context, block_context));
	КонецЕсли;
КонецФункции
	
