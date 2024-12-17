//DynamicDirective
Функция block_invite_user_calc_value(block_type, node, path, context, block_context)
	Если context.params.public.send_invitations = Ложь Тогда
		Возврат Новый Структура("data, status", "Отправка приглашений отключена в настройках", "error");
	ИначеЕсли Найти(context.params.public.send_invitations, "my" ) > 0 Тогда
		RedirectApplicationId = "b2b356e2-daa8-4fe7-b86e-0e2dd353f8c6";	
	ИначеЕсли Найти(context.params.public.send_invitations, "staff" ) > 0 Тогда
		RedirectApplicationId = "71627822-061a-42a9-9ad0-b90112a2d2a3";
	ИначеЕсли Найти(context.params.public.send_invitations, "lk" ) > 0 Тогда
		RedirectApplicationId = "7c1ff9a6-69ef-4908-ac7c-5dfcf52ae2a7";
	Иначе
		RedirectApplicationId = "d7b1d6a5-e59d-4b03-b823-726fbdc35d09";	
	КонецЕсли;
	
	InputData = Новый Структура ("FaceId, RedirectApplicationId, LastName, TransportType, DoNotInviteIfUserLoggedOnce",
								Число(block_context.FaceId),
								RedirectApplicationId,
								"Пользователь",
								get_prop(get_prop(context.params, "public"), "send_type", "Email"),
								Ложь);
	Если ЗначениеЗаполнено(block_context.Phone) Тогда
		InputData.Вставить("Phone", block_context.Phone);	
	КонецЕсли;
	Если ЗначениеЗаполнено(block_context.Email) Тогда
		InputData.Вставить("Email", block_context.Email);
	КонецЕсли; 
	Попытка
		Транспорт.local_helper_invite_user_ext(context.params, InputData);
	Исключение   
		ИнфОбОшибке = ИнформацияОбОшибке();
		ОшибкаСтруктура = NewExtExceptionСтруктура(ИнфОбОшибке);
		Если не ОшибкаСтруктура.message = "Приглашение не отправлено, т.к. у пользователя уже есть доступ" Тогда	
			ВызватьИсключение NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context));	
		КонецЕсли;	
	КонецПопытки;	
КонецФункции	
