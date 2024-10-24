
//DynamicDirective
Функция simple_block_execute_obj(block_type, node, path, context, block_context, БлокВыполнен) 
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	Если block_type = "obj_prop_set" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_obj_prop_set_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_prop_set2" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_obj_prop_set_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_prop_get" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_obj_prop_get_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_prop_get2" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_obj_prop_get_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_prop_append" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_obj_prop_append_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "list_obj_group" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_list_obj_group_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции  

//DynamicDirective
Функция block_execute_core_obj(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "new_obj" Тогда
		result = block_new_obj_execute(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;	
КонецФункции

//DynamicDirective
Функция block_execute_obj(block_type, node, path, context, block_context, БлокВыполнен)
	result = block_execute_core_obj(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_obj(block_type, node, path, context, block_context, БлокВыполнен);	
	КонецЕсли;
	Возврат result;	
КонецФункции

