
Функция add_block_to_dump(block_context, dump = Неопределено)
	Если dump = Неопределено Тогда
		dump = Новый Структура("block_id, block_type, block_path", block_context.__id, block_context.__type, block_context.__path);
	Иначе
		ВставитьСвойствоЕслиНет(dump, "block_id", block_context.__id);
		ВставитьСвойствоЕслиНет(dump, "block_type", block_context.__type);
		ВставитьСвойствоЕслиНет(dump, "block_path", block_context.__path);
	КонецЕсли;
	Возврат dump;
КонецФункции

Функция block_obj_get_path_value(знач obj, obj_path, obj_name)  Экспорт
	delimiter = ".";
	_path = СтрРазделить82(obj_path, delimiter, Ложь);
	_obj = obj;
	
	i = 0;
	size = _path.Количество();
	Пока i < size Цикл
		elem = _path[i];
		Если ТипЗнч(_obj) =  Тип("Массив") или ТипЗнч(_obj) =  Тип("ТаблицаЗначений") Тогда
			Попытка  // это число
				_obj = _obj[Число(elem)];
			Исключение
				Если (i < size - 1) Тогда
					index = ArrayHelper_find(_obj, _path[i+ 1], elem);
				Иначе
					index = -1;
				КонецЕсли;
				Если index >= 0 Тогда
					_obj = _obj[index];
					i = i + 1;
				Иначе
					Возврат Неопределено;
				КонецЕсли;
			КонецПопытки;	
		Иначе
			Попытка
				_obj = get_prop(_obj, elem);
			Исключение	
				ВызватьИсключение NewExtExceptionСтрока(,"Не удалось получить свойство объекта","path "+obj_path+" not supported ("+obj_name+")","block_obj_get_path_value",obj);
			КонецПопытки;	
		КонецЕсли;	
		Если _obj = Неопределено Тогда
			Прервать;
		КонецЕсли;	
		i = i + 1;
	КонецЦикла;	
	Возврат _obj;
КонецФункции

Процедура block_obj_set_path_value(obj, obj_path, value)  Экспорт
	delimiter = ".";
	_path = СтрРазделить82(obj_path, delimiter, Ложь);
	_obj = obj;
	
	i = 0;
	size = _path.Количество() - 1;
	Пока i < size Цикл
		elem = _path[i];
		sub_obj = get_prop(_obj, elem);
		Если sub_obj = Неопределено Тогда
			_obj.Вставить(elem, Новый Соответствие); 	
		КонецЕсли;
        _obj = get_prop(_obj, elem);
		i = i + 1;
	КонецЦикла;
	_obj.Вставить(_path[size], value);
КонецПроцедуры

Функция ЭтоТипТабличнаяЧасть(ПроверяемоеЗнч)
	ПроверяемоеЗнчСтрокой = Строка(ПроверяемоеЗнч);
	Возврат ((Найти(ПроверяемоеЗнчСтрокой, "ДокументТабличнаяЧасть.") > 0)
				ИЛИ
			(Найти(ПроверяемоеЗнчСтрокой, "СправочникТабличнаяЧасть.") > 0));
КонецФункции

Процедура ПреобразоватьСтруктутуКДопустимымXDTOТипам(Переменные)
		
	Для Каждого Стр Из Переменные Цикл
		
		Если Найти(Строка(Стр.Значение),"ТабличнаяЧастьСтрока") Тогда //И СтрДлина(ТипЗнч(Стр.Значение)) > 6 Тогда
			Переменные[Стр.Ключ] = ПолучитьСтруктуруИзСтрокиТабличнойЧасти(Стр.Значение);					
		КонецЕсли;
		
		Если Найти(НРег(ТипЗнч(Стр.Значение)),"объект") Тогда
			Переменные[Стр.Ключ] = ПолучитьСтруктуруИзОбъекта(Стр.Значение);
		КонецЕсли; 
		
		Если Найти(НРег(get_prop(XMLТипЗнч(Стр.Значение),"ИмяТипа","")),"ref") > 0  Тогда
			Переменные[Стр.Ключ] = ПолучитьСтруктуруИзОбъекта(Стр.Значение);
		КонецЕсли;
		
		Если Строка(Стр.Значение) = "СтрокаТаблицыЗначений" Тогда
			Переменные[Стр.Ключ] = ПолучитьСтруктуруИзСтрокиТаблицыЗначений(Стр.Значение);
		КонецЕсли;	
		
		Если ЭтоТипТабличнаяЧасть(Стр.Значение) Тогда
			Переменные[Стр.Ключ] = Стр.Значение.Выгрузить();
		КонецЕсли;	
		
	КонецЦикла;
	
КонецПроцедуры	

Функция ПолучитьСтруктуруИзОбъекта(знач Объект)
	Структура = Новый Структура();     
	Если Найти(НРег(get_prop(XMLТипЗнч(Объект),"ИмяТипа","")),"enumref") > 0 Тогда 
		Возврат Объект;
	КонецЕсли;
	Для каждого Реквизит из Объект.Метаданные().СтандартныеРеквизиты Цикл
		Структура.Вставить(Реквизит.Имя, Объект[Реквизит.Имя]);
	КонецЦикла;    
	Для каждого Реквизит из Объект.Метаданные().Реквизиты Цикл
		Структура.Вставить(Реквизит.Имя, Объект[Реквизит.Имя]);
	КонецЦикла;
	Для каждого ТабличнаяЧасть из Объект.Метаданные().ТабличныеЧасти Цикл
		МассивЭлементов = Новый Массив;
		Для Каждого Стр ИЗ Объект[ТабличнаяЧасть.Имя].Выгрузить() Цикл
			МассивЭлементов.Добавить(ПолучитьСтруктуруИзСтрокиТаблицыЗначений(Стр));
		КонецЦикла;	
		Структура.Вставить(ТабличнаяЧасть.Имя, МассивЭлементов);
	КонецЦикла;    
	Возврат Структура;
КонецФункции

Функция ПолучитьСтруктуруИзСтрокиТабличнойЧасти(знач Объект)
	Структура = Новый Структура();
	ПозицияТЧ = Найти(Строка(Объект), "ТабличнаяЧастьСтрока");
	СтрокаОбъект= СтрЗаменить(Строка(Объект), "ТабличнаяЧастьСтрока", "");
	ПутьТЧ		= СтрРазделить82(СтрокаОбъект, ".", Ложь);
	Если ПозицияТЧ > 0 Тогда
		ПутьТЧ.Вставить(2, "ТабличныеЧасти");
	КонецЕсли;
	ТЧ = Метаданные;
	НомЭлем = 0;
	Для каждого Элем из ПутьТЧ Цикл
		Элем = ?(Элем = "Документ", "Документы", Элем);
		Если НомЭлем = 2 Тогда 	
		КонецЕсли;	
		ТЧ = ТЧ[Элем];
		НомЭлем = НомЭлем + 1;
	КонецЦикла;
	Для каждого Реквизит из ТЧ.Реквизиты Цикл
		Структура.Вставить(Реквизит.Имя, Объект[Реквизит.Имя]);	
	КонецЦикла;
	Для каждого Реквизит из ТЧ.СтандартныеРеквизиты Цикл
		Структура.Вставить(Реквизит.Имя, Объект[Реквизит.Имя]);	
	КонецЦикла;	
	Возврат Структура;
КонецФункции	

Функция ПолучитьСтруктуруИзСтрокиТаблицыЗначений(знач Объект)
	Структура = Новый Структура;
	Колонки = Объект.Владелец().Колонки;
	Для каждого Колонка Из Колонки Цикл
		Структура.Вставить(Колонка.Имя, Объект[Колонка.Имя]);
	КонецЦикла;	
	Возврат Структура;
КонецФункции	

Функция ПоискОшибокСериализации( Знч, Реквищзит, п3, Отмена ) Экспорт 
	//todoo выпилить функию после реальзации праильного кода. 
	//Функция удаляет все не сериализуемые реквизиты из структуры
	Возврат Неопределено;
КонецФункции

//DynamicDirective
Процедура ВставитьСвойствоЕслиНет(Объект, ИмяСвойства, Значение)
	Если ТипЗнч(Объект) = Тип("Соответствие") Тогда
		ПроверкаСвойства = ?(Объект[ИмяСвойства] = Неопределено, Ложь, Истина);
	ИначеЕсли ТипЗнч(Объект) = Тип("Структура") Тогда
		ПроверкаСвойства = ?(ЗначениеЗаполнено(Объект),Объект.Свойство(ИмяСвойства), Ложь);
	Иначе
		Возврат;
	КонецЕсли;	
	Если ПроверкаСвойства Тогда
		Объект[ИмяСвойства] = Значение;
	Иначе
		Объект.Вставить(ИмяСвойства, Значение);
	КонецЕсли;	
КонецПроцедуры	

Функция ПреобразоватьМассивСтруктурВСоответствие(Мас, ИмяКлюча)
	Результат = Новый Соответствие;
	Если ТипЗнч(Мас) = Тип("Массив") Тогда
		Для Каждого Элем из Мас Цикл
			Результат.Вставить(Элем[ИмяКлюча], Элем);				
		КонецЦикла;
	КонецЕсли;
	Возврат Результат;
КонецФункции

Функция ПолучитьДокументDOM(ХМЛРассчета)	
	ДокументDOM = Новый ПостроительDOM;
	Если ЗначениеЗаполнено(ХМЛРассчета) Тогда
		ЧтениеXML = Новый ЧтениеXML;
		ЧтениеXML.УстановитьСтроку(ХМЛРассчета);
		ПостроительDOM = Новый ПостроительDOM;
		ДокументDOM = ПостроительDOM.Прочитать(ЧтениеXML);
		ЧтениеXML.Закрыть();
		Workspace = ДокументDOM;
		размыватель = новый РазыменовательПространствИменDOM("b", "https://developers.google.com/blockly/xml");
	КонецЕсли;
	Возврат ДокументDOM;
КонецФункции
//TODO Depricated 
Функция ПрочитатьИзХранилища(КлючОбъекта, КлючНастройки="", ОписаниеНастройки=Неопределено, ПользовательНастройки=Неопределено)
	УстановитьПривилегированныйРежим(Истина);
	Возврат ХранилищеОбщихНастроек.Загрузить(КлючОбъекта, КлючНастройки, ОписаниеНастройки, ПользовательНастройки);
КонецФункции

Функция ЗаписатьВХранилище(КлючОбъекта, КлючНастройки="", Настройки, ОписаниеНастройки=Неопределено, ПользовательНастройки=Неопределено)
	УстановитьПривилегированныйРежим(Истина);
	ХранилищеОбщихНастроек.Сохранить(КлючОбъекта, КлючНастройки, Настройки, ОписаниеНастройки ,ПользовательНастройки);
КонецФункции

Функция ЗначениеВСтрокуВнутрНаСервере(Значение)
	Возврат ЗначениеВСтрокуВнутр(Значение);
КонецФункции

Функция КодироватьСтрокуНаСервере(СтрокаПереданная, СпособКодирования, КодировкаСтроки)
	Возврат КодироватьСтроку(СтрокаПереданная,СпособКодирования, КодировкаСтроки);
КонецФункции

// Проверяет наличие обязательных полей структуры по именам
//
// Параметры:
//  СтруктураИсточник - Структура, Соответствие - произвольная структура
//  ИменаКлючей - Строка - строка ключей структуры или соответствия, которые необходимо проверить. Разделитель ","
//  ПерфиксОшибки - Строка - префикс теста ошибки
//
// Возвращаемое значение:
//   Нет.
//
Процедура ПроверитьНаличиеОбязательныхПараметров(СтруктураИсточник, ИменаКлючей, ПерфиксОшибки = "")
	
	МассивИменПараметров = СтрРазделить82(ИменаКлючей,",");
	ТекстПараметров = "";
	Для каждого ИмяПараметра Из МассивИменПараметров Цикл
		Если ТипЗнч(СтруктураИсточник) = Тип("Структура") И НЕ СтруктураИсточник.Свойство(ИмяПараметра) 
			ИЛИ ТипЗнч(СтруктураИсточник) = Тип("Соответствие") И СтруктураИсточник.Получить(ИмяПараметра) = Неопределено Тогда
			
			ТекстПараметров = ТекстПараметров + ИмяПараметра + ", ";
		КонецЕсли;
	КонецЦикла;
	
	Если ЗначениеЗаполнено(ТекстПараметров) Тогда
		ТекстПараметров = Лев(ТекстПараметров, СтрДлина(ТекстПараметров)-2);
		ВызватьИсключение(NewExtExceptionСтрока(,"Не заполнены обязательные свойства объекта", ПерфиксОшибки+" ("+ТекстПараметров+")"));
	КонецЕсли;
	
КонецПроцедуры // ПроверитьНаличиеОбязательныхПараметров()

Функция helper_find_in_array(data, value, _field)
    i = 0;
    Для Каждого elem из data Цикл
        Попытка
            Если elem[_field] = value тогда
                Возврат i
			КонецЕсли;
		Исключение
			i = i + 1;
            Продолжить;
		КонецПопытки;
		i = i + 1;
	КонецЦикла;
    ВызватьИсключение "";
КонецФункции

Функция ПреобразоватьТаблицуЗначенийВМассивСтруктур(п_ТЗ) Экспорт
	
	Массив = Новый Массив();
	
	СтруктураСтрокой = "";
	НужнаЗапятая 	 = Ложь;
	
	Для Каждого Колонка Из п_ТЗ.Колонки Цикл
		
		Если НужнаЗапятая Тогда
			СтруктураСтрокой = СтруктураСтрокой + ",";
		КонецЕсли;
		
		СтруктураСтрокой = СтруктураСтрокой + Колонка.Имя;
		НужнаЗапятая     = Истина;
		
	КонецЦикла;
	
	Для Каждого Строка Из п_ТЗ Цикл
		
		НоваяСтрока = Новый Структура(СтруктураСтрокой);
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
		
		Массив.Добавить(НоваяСтрока);
		
	КонецЦикла;
	
	Возврат Массив;

КонецФункции 

// Дополняет массив МассивПриемник значениями из массива МассивИсточник.
//
// Параметры:
//  МассивПриемник - Массив - массив, в который необходимо добавить значения.
//  МассивИсточник - Массив - массив значений для заполнения.
//  ТолькоУникальныеЗначения - Булево - если истина, то в массив будут включены только уникальные значения.
//
Процедура ДополнитьМассив(МассивПриемник, МассивИсточник, ТолькоУникальныеЗначения = Ложь) Экспорт
	
	Если ТолькоУникальныеЗначения Тогда
		
		УникальныеЗначения = Новый Соответствие;
		
		Для Каждого Значение Из МассивПриемник Цикл
			УникальныеЗначения.Вставить(Значение, Истина);
		КонецЦикла;
		
		Для Каждого Значение Из МассивИсточник Цикл
			Если УникальныеЗначения[Значение] = Неопределено Тогда
				МассивПриемник.Добавить(Значение);
				УникальныеЗначения.Вставить(Значение, Истина);
			КонецЕсли;
		КонецЦикла;
		
	Иначе
		
		Для Каждого Значение Из МассивИсточник Цикл
			МассивПриемник.Добавить(Значение);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#Область include_BlocklyExecutor_base_Helper_DecodeEncode
#КонецОбласти

