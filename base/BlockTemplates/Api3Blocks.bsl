
//DynamicDirective
Функция simple_api3_block_execute(block_type, node, path, context, block_context, БлокВыполнен)
	// BSLLS:CognitiveComplexity-off
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
	ИначеЕсли block_type = "api3_person" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_person_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_person_localization" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_person_localization_calc_value(block_type, node, path, context, block_context);
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
	ИначеЕсли block_type = "api3_contacttype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_contacttype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_cadresother" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_cadresother_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_accrualtype" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_accrualtype_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_staffingtable" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_staffingtable_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_terrconditions" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_terrconditions_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_accruals" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_accruals_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_incentive" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_incentive_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_businesstriplist" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_businesstriplist_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_btcorrection" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_btcorrection_calc_value(block_type, node, path, context, block_context);	
	ИначеЕсли block_type = "api3_downtime" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_downtime_calc_value(block_type, node, path, context, block_context);
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
	ИначеЕсли block_type = "api3_implementationadjustment" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_implementation_adjustment_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_writing_off_act" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_writing_off_act_calc_value(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "api3_receiptadjustment" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_api3_receipt_adjustment_calc_value(block_type, node, path, context, block_context);
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
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	Возврат result;
	// BSLLS:CognitiveComplexity-on
КонецФункции


