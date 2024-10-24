
//DynamicDirective
Функция simple_esd_block(block_type, node, path, context, block_context, БлокВыполнен)
	
	БлокВыполнен = Истина;
	
	Если block_context.Свойство("result") Тогда
		Возврат block_context["result"];
	КонецЕсли;

	result = Неопределено;
	
	ЭкранироватьРазделительИерархииЭПД(node, path, context, block_context);
	
	Если block_type = "esd_order_for_shipping" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_esd_order_for_shipping(block_type, node, path, context, block_context);
	ИначеЕсли block_type = "esd_route_point" Тогда
		simple_block_before_execute(node, path, context, block_context);
		result = block_esd_route_point(block_type, node, path, context, block_context);
	Иначе
		БлокВыполнен = Ложь;
	КонецЕсли;
	
	Возврат result;
	
КонецФункции

//DynamicDirective
Процедура ЭкранироватьРазделительИерархииЭПД(node, path, context, block_context)
	
	ВходыБлока = Workspace.ВычислитьВыражениеXpath("./b:value", node, размыватель);	
	
	ПараметрыЭкранированияИерархииЭПД = ПараметрыЭкранированияИерархииЭПД();
	
	Пока Истина Цикл
		Узел = ВходыБлока.ПолучитьСледующий();
		Если Узел = Неопределено Тогда 
			Прервать;
		КонецЕсли;
		
		ИмяАтрибута = "name";
		
		ЗначениеАтрибута = Узел.ПолучитьАтрибут(ИмяАтрибута);
		
		Если Найти(ЗначениеАтрибута, ".") > 0 Тогда
			
			Для Каждого ПараметрЭкранирования Из ПараметрыЭкранированияИерархииЭПД Цикл
				ЗначениеАтрибута = СтрЗаменить(ЗначениеАтрибута, ПараметрЭкранирования.Ключ, ПараметрЭкранирования.Значение);
			КонецЦикла;
			
			Узел.УдалитьАтрибут(ИмяАтрибута);
			Узел.УстановитьАтрибут(ИмяАтрибута, ЗначениеАтрибута);
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ПараметрыЭкранированияИерархииЭПД()
	
	РезультатФункции = Новый Соответствие;
	РезультатФункции.Вставить(".", "_0_");
	
	Возврат РезультатФункции;
	
КонецФункции

