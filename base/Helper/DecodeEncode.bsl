
Функция encode_xdto_xml(ОбъектДляСериализации) Экспорт
	
	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.Отступ = Ложь;
	ЗаписьXML.УстановитьСтроку();
	НовыйСериализаторXDTO = Новый СериализаторXDTO(ФабрикаXDTO);
	НовыйСериализаторXDTO.ЗаписатьXML(ЗаписьXML, ОбъектДляСериализации);
	
	Возврат ЗаписьXML.Закрыть();
	
КонецФункции 

Функция encode_xdto_json(ОбъектДляСериализации) Экспорт
	ЗаписьJSON = Новый ЗаписьJSON;
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет);
	ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписиJSON);
	//ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON,ОбъектДляСериализации,,"ПоискОшибокСериализации", ЭтотОбъектНаСервере());
	Возврат ЗаписьJSON.Закрыть();	
КонецФункции

Функция decode_xml_xdto(СтрокаXML) Экспорт
	
	Чтение = Новый ЧтениеXML;
	Чтение.УстановитьСтроку(СтрокаXML);
	НовыйСериализаторXDTO = Новый СериализаторXDTO(ФабрикаXDTO);
	Возврат НовыйСериализаторXDTO.ПрочитатьXML(Чтение);
	
КонецФункции 

