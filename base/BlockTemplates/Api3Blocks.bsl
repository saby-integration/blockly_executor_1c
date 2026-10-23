
// Функция simple_api3_block_execute
//
// Параметры:
//  block_type - Строка - Название блока
// 	node - Структура - Dom структура хмл
//  path - Строка - Пусть до блока по алгоритму
//  context - Структура - Общий контекст алгоритма
//  block_context - Структура - Контекст исполняемого блока
//  БлокВыполнен - Булево - Признак выполнения блока
//
// Возвращаемое значение:
//  - Структура - Результат обсчета алгоритма
//
// Сохраняем идентичность со структурой кода в Питоне
// BSLLS-off
//DynamicDirective
Функция simple_api3_block_execute(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	Если block_type = "api3_link" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_link_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_hiring" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_hiring_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_changeposition" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_changeposition_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_dismissal" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_dismissal_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leave" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_leave_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leave_table" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_leave_table_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_person" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_person_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_person_localization" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_person_localization_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_person_education" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_person_education_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_employee" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_employee_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_org" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_org_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_department" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_department_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_departmentadmin" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_departmentadmin_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_department_localization" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_department_localization_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_position" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_position_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_position_localization" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_position_localization_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_planworkshedule" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_planworkshedule_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leavetype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_leavetype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leavetypeadditional" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_leavetypeadditional_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_kinship" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_kinship_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_truancy" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_truancy_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_documenttype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_documenttype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_businesstrip" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_businesstrip_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timesheets" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_timesheets_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timesheetcorrection" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_timesheetcorrection_calc_value(block_type, node, path, context, block_context);		
	ИначеЕсли block_type = "api3_timesheets_table" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_timesheets_table_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timesheets_time" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_timesheets_time_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_sicknessreason" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_sicknessreason_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_familymember" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_familymember_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timeoff" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_timeoff_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timeofftype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_timeofftype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_vacationschedule" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_vacationschedule_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_indexation" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_indexation_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_childcareleave" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_childcareleave_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_reason" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_reason_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_sickleave" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_sickleave_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_sickleave_period" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_sickleave_period_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_sickleave_accrual" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_sickleave_accrual_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_changetermsemploym" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_changetermsemploym_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_employmenttype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_employmenttype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_paymentcharacter" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_paymentcharacter_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leave_type" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_leave_type_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_predefined" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_predefined_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_overtime" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_overtime_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_overtime_table" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_overtime_table_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_overtime_day" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_overtime_day_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_timesheets_tag" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_timesheets_tag_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leaveschedule_table" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_leaveschedule_table_calc_value(block_type, node, path, context, block_context);		
	ИначеЕсли block_type = "api3_leaveschedule" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_leaveschedule_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_changeleaveschedule" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_changeleaveschedule_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_changeleaveschedule_table" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_changeleaveschedule_table_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_contacttype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_contacttype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_cadresother" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_cadresother_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_accrualtype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_accrualtype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_application" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_application_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_staffingtable" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_staffingtable_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_terrconditions" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_terrconditions_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_accruals" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_accruals_calc_value(block_type, node, path, context, block_context); 
	ИначеЕсли block_type = "api3_accruals_table" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_accruals_table_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_incentive" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_incentive_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_incentive_recipient" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_incentive_recipient_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_businesstriplist" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_businesstriplist_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_businesstrip_destination" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_businesstrip_destination_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_businesstrip_participant" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_businesstrip_participant_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_btcorrection" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_btcorrection_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "api3_downtime" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_downtime_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_downtime_table" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_downtime_table_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_additionalassignment" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_additionalassignment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_acceptanceact" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_acceptanceact_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_accountingreference" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_accountingreference_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_counterparty" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_counterparty_calc_value(block_type, node, path, context, block_context); 
	ИначеЕсли block_type = "api3_selling" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_selling_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_sales" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_sales_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_contract" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_contract_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_implementationadjustment" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_implementation_adjustment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_writing_off_act" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_writing_off_act_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_receiptadjustment" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_receipt_adjustment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_receipts" ИЛИ block_type = "api3_admission" Тогда // т.к. в текущей версии зовется api3_admission, а будет api3_receipts
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_receipts_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_stock" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_stock_calc_value(block_type, node, path, context, block_context); 
	ИначеЕсли block_type = "api3_typeofincome" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_type_of_income_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_expenseitem" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_expense_item_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_releaseact" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_release_act_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_incomingpayment" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_incoming_payment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_outgoingpayment" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_outgoing_payment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_cashinorder" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_cash_in_order_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_cashissuenote" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_cash_issue_note_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_advancereport" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_advance_report_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_depreciation" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_depreciation_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_combinationcancel" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_combinationcancel_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_country" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_country_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "api3_warehouse" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_warehouse_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_nomenclature" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_nomenclature_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_nomenclaturetype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_nomenclaturetype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_leaveleftovers" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_leaveleftovers_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_returntosupplier" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_returntosupplier_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_invoice" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_invoice_calc_value(block_type, node, path, context, block_context); 
	ИначеЕсли block_type = "api3_offset" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_offset_calc_value(block_type, node, path, context, block_context); 
	ИначеЕсли block_type = "api3_vatinvoice_outgoing" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_vatinvoice_outgoing_calc_value(block_type, node, path, context, block_context);  
	ИначеЕсли block_type = "api3_internaltransfer" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_internaltransfer_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_interestonloansrecieved" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_interestonloansrecieved_calc_value(block_type, node, path, context, block_context);		
	ИначеЕсли block_type = "api3_vatinvoice_incoming" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_vatinvoice_incoming_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_militaryrank" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_militaryrank_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_taxstatus" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_taxstatus_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_eligibilitycategory" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_eligibilitycategory_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_stockcategory" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_stockcategory_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_militaryattitude" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_militaryattitude_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_accountingattitude" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_accountingattitude_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_gender" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_gender_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_purchaseorder" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_purchaseorder_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_bank" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_bank_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_currency" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_currency_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_extrapayformergingpositions" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_extrapayformergingpositions_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_propertytype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_propertytype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_combinationtype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_combinationtype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_accountingperiodtype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_accountingperiodtype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_loanagreementissued" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_loanagreementissued_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_loanagreementobtaining" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_loanagreementobtaining_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_educationdocumenttype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_educationdocumenttype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_educationtype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_educationtype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_property" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_property_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_personalaccount" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_personalaccount_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_salaryconfiguration" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_salaryconfiguration_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_ourcurrentaccount" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_ourcurrentaccount_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_manuallyenteredtransaction" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_manuallyenteredtransaction_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_basisfixedtermcontract" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_basisfixedtermcontract_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_specialworkingconditions" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_specialworkingconditions_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_propertymoving" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_propertymoving_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_indicatoraccounting" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_indicatoraccounting_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_customdocument" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_customdocument_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_propertyreceipt" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_propertyreceipt_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_revocationreason" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_revocationreason_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_propertysales" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_propertysales_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_currentaccount" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_currentaccount_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_taxsystem" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_taxsystem_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_propertywriteoff" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_propertywriteoff_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_methodsfillingschedule" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_methodsfillingschedule_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_basic_pay" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_basic_pay_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_accountingsettings" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_accountingsettings_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_acquiringagreement" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_acquiringagreement_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_acquiringdocument" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_acquiringdocument_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_advancepaymentprocedure" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_advancepaymentprocedure_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_allowance" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_allowance_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_allowancetype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_allowancetype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_apportionrecord" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_apportionrecord_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_cashregister" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_cashregister_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_childtaxdeduction" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_childtaxdeduction_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_civilcontract" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_civilcontract_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_contactpersoncounterparty" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_contactpersoncounterparty_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_costaccountingmethod" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_costaccountingmethod_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_counterpartytype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_counterpartytype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_customerorder" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_customerorder_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_customerorder_table" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_customerorder_table_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_individualcounterparty" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_individualcounterparty_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_insurancepremiumratestype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_insurancepremiumratestype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_inventoryact" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_inventoryact_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_inventorymanagementtype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_inventorymanagementtype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_invoiceadvancepaymentprocedure" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_invoiceadvancepaymentprocedure_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_payrollprogram" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_payrollprogram_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_propertyissuereason" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_propertyissuereason_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_propertyreceipt_fixedassets" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_propertyreceipt_fixedassets_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_purchaseorder_table" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_purchaseorder_table_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_salarydeductions" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_salarydeductions_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_salarypayment" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_salarypayment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_salarypayment_payments" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_salarypayment_payments_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_salarypaymentmethod" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_salarypaymentmethod_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_sales_tabldoc" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_sales_tabldoc_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_receipt_table" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_receipt_table_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_returnfrombuyer" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_returnfrombuyer_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_laborfunction" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_laborfunction_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_vatrate" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_vatrate_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_candidate" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_candidate_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_maternityleavereturn" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_maternityleavereturn_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_maritalstatus" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_maritalstatus_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_reportfts" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_reportfts_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_salarylist_tabldoc" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_salarylist_tabldoc_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_salarylist_accruals_deductions" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_salarylist_accruals_deductions_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_salarylist" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_salarylist_calc_value(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции
// BSLLS-on
