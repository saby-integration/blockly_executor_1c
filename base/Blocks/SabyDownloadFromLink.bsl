//DynamicDirective
Функция block_saby_download_from_link_execute(block_type, node, path, context, block_context)
	Попытка
		res = Транспорт.local_helper_download_from_link(context.params, block_context["link"]);
		Возврат Base64Строка(res);
	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
		ВызватьИсключение(NewExtExceptionСтрока(ИнфОбОшибке,,,"Ошибка в блоке (" + block_type + ")", add_block_to_dump(block_context)));
	КонецПопытки;
КонецФункции
