
Функция simple_api3_block_execute(block_type, node, path, context, block_context, БлокВыполнен)
	БлокВыполнен = Истина;
	simple_block_get_args(node, path, context, block_context);
	simple_block_get_fields(node, path, context, block_context);
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;
	
	block_check_step(context, block_context);
	
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
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
КонецФункции


