
Функция simple_block_execute_logic_loop_math(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "logic_compare" Тогда
		result = block_logic_compare_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "logic_boolean" Тогда
		result = block_logic_boolean_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "logic_operation" Тогда
		result = block_logic_operation_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "logic_null" Тогда
		result = Неопределено;
	ИначеЕсли block_type = "logic_negate" Тогда
		result = block_logic_negate_calc_value(block_type, node, path, context, block_context);				
	ИначеЕсли block_type = "controls_for" Тогда
		result = block_controls_for_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "controls_forEach2" Тогда
		result = block_controls_for_each2_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "controls_forEach" Тогда
		result = block_controls_for_each_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "math_number" Тогда
		result = block_math_number_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "math_arithmetic" Тогда
		result = block_math_arithmetic_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "math_round" Тогда
		result = block_math_round_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции		

Функция simple_block_execute_text(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "concatenate" Тогда
		result = block_concatenate_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "split" Тогда
		result = block_split_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "text_getSubstring" Тогда
		result = block_text_getSubstring_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "re_search" Тогда
		result = block_re_search_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "text_charAt" Тогда
		result = block_text_charAt_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли  block_type = "text_indexOf" Тогда
		result = block_text_indexOf_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;		
КонецФункции

Функция simple_block_execute_list(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "lists_get_index" Тогда
		result = block_lists_get_index_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "lists_set_index" Тогда
		result = block_lists_set_index_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "lists_length" Тогда
		result = block_lists_length_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "list_obj_group" Тогда
		result = block_list_obj_group_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result; 
КонецФункции

Функция simple_block_execute_variables(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина; 
	result = Неопределено;
	Если block_type = "variables_set" Тогда
		result = block_variables_set_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "variables_get" Тогда
		result = block_variables_get_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "format" Тогда
		result = block_format_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;	
	КонецЕсли;
	Возврат result;
КонецФункции

Функция simple_block_execute_object(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "obj_prop_set" Тогда
		result = block_obj_prop_set_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_prop_set2" Тогда
		result = block_obj_prop_set_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_prop_get" Тогда
		result = block_obj_prop_get_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_prop_get2" Тогда
		result = block_obj_prop_get_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_prop_append" Тогда
		result = block_obj_prop_append_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции 

Функция simple_block_execute_others(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	
	Если block_type = "format" Тогда
		result = block_format_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "get_current_datetime" Тогда
		result = block_get_current_datetime_calc_value(block_type, node, path, context, block_context);		
	ИначеЕсли block_type = "uuid4" Тогда
		result = block_uuid4_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "accordion_item" Тогда
		result = block_accordion_item_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view" Тогда
		result = block_obj_action_list_view_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view_filter" Тогда
		result = block_obj_action_list_view_filter_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view_column" Тогда
		result = block_obj_action_list_view_column_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "obj_action_list_view_toolbar" Тогда
		result = block_obj_action_list_view_toolbar_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "execute_workspace" Тогда
		result = block_execute_workspace_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "public_param_get" Тогда
		result = block_public_param_get_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "try" Тогда
		result = block_try_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;
КонецФункции

Функция simple_block_execute_1c(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "c1_ref_to_obj" Тогда
		result = block_c1_ref_to_obj_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_ref_from_id" Тогда
		result = block_c1_ref_from_id_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_doc_read_print_forms" Тогда
		result = block_c1_doc_read_print_forms_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_ref" Тогда
		result = block_c1_ref_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_meta_read" Тогда
		result = block_c1_meta_read_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_meta_update" Тогда
		result = block_c1_meta_update_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_call_filter" Тогда
		result = block_c1_call_filter_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_get_uuid" Тогда
		result = block_c1_get_uuid_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_ref_from_api3" Тогда
		result = block_c1_ref_from_api3_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_predefine" Тогда
		result = block_c1_predefine_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_register_update" Тогда
		result = block_c1_register_update_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_strip" Тогда
		result = block_c1_strip_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "c1_attach_attachment" Тогда
		result = block_c1_attach_attachment_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;	
КонецФункции 

Функция simple_block_execute_edo(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "saby_edo_start" Тогда
		result = block_saby_edo_start_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "fed_convert_object_to_xml" Тогда
		result = block_fed_convert_object_to_xml_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "fed_convert_xml_to_object" Тогда
		result = block_fed_convert_xml_to_object_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;	
КонецФункции

Функция simple_block_execute_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "extsyncdoc_write" Тогда
		result = block_extsyncdoc_write_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsyncdoc_run" Тогда
		result = block_extsyncdoc_run_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsyncdoc_create" Тогда
		result = block_extsyncdoc_create_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsyncdoc_fillchangedsbisobjects" Тогда
		result = block_extsyncdoc_extsyncdoc_fillchangedsbisobjects_calc_value(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;
КонецФункции

Функция simple_block_execute_extsys(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "extsys_read" Тогда
		result = block_extsys_read_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_update_status" Тогда
		result = block_saby_extsys_update_status_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_update_status2" Тогда
		result = block_saby_extsys_update_status2_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_read_changes" Тогда
		result = block_extsys_read_changes_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "extsys_calc_ini" Тогда
		result = block_extsys_calc_ini_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "saby_execute_action" Тогда
		result = block_saby_execute_action_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_find" Тогда
		result = block_saby_find_calc_value(block_type, node, path, context, block_context); 
	ИначеЕсли block_type = "saby_read" Тогда
		result = block_saby_read_calc_value(block_type, node, path, context, block_context); 
	ИначеЕсли block_type = "test_read_saby_object" Тогда
		result = block_test_read_saby_object_calc_value(block_type, node, path, context, block_context);	
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;		
КонецФункции

Функция simple_block_execute_saby(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "saby_upload_files" Тогда
		result = block_saby_upload_files_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_convert_files_to_pdf" Тогда
		result = block_saby_convert_files_to_pdf_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_read_document" Тогда
		result = block_saby_read_document_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_write_document" Тогда
		result = block_saby_write_document_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_download_from_link" Тогда
		result = block_saby_download_from_link_execute(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_document_list" Тогда
		result = block_saby_document_list_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_document_event_list" Тогда
		result = block_saby_document_event_list_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "saby_query" Тогда
		result = block_saby_query_calc_value(block_type, node, path, context, block_context);	 
	ИначеЕсли block_type = "invite_user" Тогда
		result = block_invite_user_calc_value(block_type, node, path, context, block_context);	 
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;		
КонецФункции

Функция simple_block_execute_indicator(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	result = Неопределено;
	Если block_type = "indicator_from_accounting_entry_side" Тогда
		result = block_indicator_from_accounting_entry_side_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;	
	Возврат result;		
КонецФункции

Функция simple_block_execute(block_type, node, path, context, block_context, БлокВыполнен)
	simple_block_get_args(node, path, context, block_context);
	simple_block_get_fields(node, path, context, block_context);
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	block_check_step(context, block_context);
	Result = Неопределено;
	БлокВыполнен = Ложь;
	result = simple_block_execute_logic_loop_math(block_type, node, path, context, block_context, БлокВыполнен);
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_text(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;		
    Если Не БлокВыполнен Тогда
		result = simple_block_execute_list(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;		
    Если Не БлокВыполнен Тогда
		result = simple_block_execute_variables(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_object(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_others(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_1c(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_edo(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_extsyncdoc(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_extsys(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_saby(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда
		result = simple_block_execute_indicator(block_type, node, path, context, block_context, БлокВыполнен);
	КонецЕсли;
	Если Не БлокВыполнен Тогда
		result = simple_api3_block_execute(block_type, node, path, context, block_context);
	КонецЕсли;
	ВставитьСвойствоЕслиНет(block_context, "result", result);
	Возврат block_context["result"];	
КонецФункции

Функция simple_api3_block_execute(block_type, node, path, context, block_context)
	Если block_type = "api3_link" Тогда
		result = block_api3_link_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_hiring" Тогда
		result = block_api3_hiring_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_changeposition" Тогда
		result = block_api3_changeposition_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_dismissal" Тогда
		result = block_api3_dismissal_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leave" Тогда
		result = block_api3_leave_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_person" Тогда
		result = block_api3_person_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_person_localization" Тогда
		result = block_api3_person_localization_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_employee" Тогда
		result = block_api3_employee_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_org" Тогда
		result = block_api3_org_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_department" Тогда
		result = block_api3_department_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_department_localization" Тогда
		result = block_api3_department_localization_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_position" Тогда
		result = block_api3_position_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_position_localization" Тогда
		result = block_api3_position_localization_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_planworkshedule" Тогда
		result = block_api3_planworkshedule_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leavetype" Тогда
		result = block_api3_leavetype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_kinship" Тогда
		result = block_api3_kinship_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_truancy" Тогда
		result = block_api3_truancy_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_documenttype" Тогда
		result = block_api3_documenttype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_businesstrip" Тогда
		result = block_api3_businesstrip_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timesheets" Тогда
		result = block_api3_timesheets_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timesheetcorrection" Тогда
		result = block_api3_timesheetcorrection_calc_value(block_type, node, path, context, block_context);		
	ИначеЕсли block_type = "api3_timesheets_table" Тогда
		result = block_api3_timesheets_table_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timesheets_time" Тогда
		result = block_api3_timesheets_time_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_sicknessreason" Тогда
		result = block_api3_sicknessreason_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_familymember" Тогда
		result = block_api3_familymember_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timeoff" Тогда
		result = block_api3_timeoff_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timeofftype" Тогда
		result = block_api3_timeofftype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_vacationschedule" Тогда
		result = block_api3_vacationschedule_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_indexation" Тогда
		result = block_api3_indexation_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_childcareleave" Тогда
		result = block_api3_childcareleave_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_reason" Тогда
		result = block_api3_reason_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_sickleave" Тогда
		result = block_api3_sickleave_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_sickleave_period" Тогда
		result = block_api3_sickleave_period_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_sickleave_accrual" Тогда
		result = block_api3_sickleave_accrual_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_changetermsemploym" Тогда
		result = block_api3_changetermsemploym_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_employmenttype" Тогда
		result = block_api3_employmenttype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_paymentcharacter" Тогда
		result = block_api3_paymentcharacter_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leave_type" Тогда
		result = block_api3_leave_type_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_predefined" Тогда
		result = block_api3_predefined_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_overtime" Тогда
		result = block_api3_overtime_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timesheets_tag" Тогда
		result = block_api3_timesheets_tag_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leaveschedule_table" Тогда
		result = block_api3_leaveschedule_table_calc_value(block_type, node, path, context, block_context);		
	ИначеЕсли block_type = "api3_leaveschedule" Тогда
		result = block_api3_leaveschedule_calc_value(block_type, node, path, context, block_context);		
	ИначеЕсли block_type = "api3_contacttype" Тогда
		result = block_api3_contacttype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_cadresother" Тогда
		result = block_api3_cadresother_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_accrualtype" Тогда
		result = block_api3_accrualtype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_staffingtable" Тогда
		result = block_api3_staffingtable_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_terrconditions" Тогда
			result = block_api3_terrconditions_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_accruals" Тогда
		result = block_api3_accruals_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_incentive" Тогда
		result = block_api3_incentive_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_businesstriplist" Тогда
		result = block_api3_businesstriplist_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_btcorrection" Тогда
		result = block_api3_btcorrection_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "api3_downtime" Тогда
		result = block_api3_downtime_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_additionalassignment" Тогда
		result = block_api3_additionalassignment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_acceptanceact" Тогда
		result = block_api3_acceptanceact_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_accountingreference" Тогда
		result = block_api3_accountingreference_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_counterparty" Тогда
		result = block_api3_counterparty_calc_value(block_type, node, path, context, block_context); 
	ИначеЕсли block_type = "api3_selling" Тогда
		result = block_api3_selling_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_contract" Тогда
		result = block_api3_contract_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_implementation_adjustment" Тогда
		result = block_api3_implementation_adjustment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_writing_off_act" Тогда
		result = block_api3_writing_off_act_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_receipt_adjustment" Тогда
		result = block_api3_receipt_adjustment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_receipts" ИЛИ block_type = "api3_admission" Тогда // т.к. в текущей версии зовется api3_admission, а будет api3_receipts
		result = block_api3_receipts_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_stock" Тогда
		result = block_api3_stock_calc_value(block_type, node, path, context, block_context); 
	ИначеЕсли block_type = "api3_typeofincome" Тогда
		result = block_api3_type_of_income_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_expenseitem" Тогда
		result = block_api3_expense_item_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_releaseact" Тогда
		result = block_api3_release_act_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_incomingpayment" Тогда
		result = block_api3_incoming_payment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_outgoingpayment" Тогда
		result = block_api3_outgoing_payment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_cashinorder" Тогда
		result = block_api3_cash_in_order_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_cashissuenote" Тогда
		result = block_api3_cash_issue_note_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_advancereport" Тогда
		result = block_api3_advance_report_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_depreciation" Тогда
		result = block_api3_depreciation_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_combinationcancel" Тогда
		result = block_api3_combinationcancel_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_country" Тогда
		result = block_api3_country_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "api3_warehouse" Тогда
		result = block_api3_warehouse_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_nomenclature" Тогда
		result = block_api3_nomenclature_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leaveleftovers" Тогда
		result = block_api3_leaveleftovers_calc_value(block_type, node, path, context, block_context);
	Иначе
		ВызватьИсключение NewExtExceptionСтрока(,"Нет реализации для блока", block_type);
	КонецЕсли;
	Возврат result;
КонецФункции

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
