
//DynamicDirective
Функция Action_init(name = Неопределено, begin = Истина, group="other")
	_action = Новый Структура();
	_action.Вставить("name", name);
    _action.Вставить("param", Новый Структура());
    _action.Вставить("group", group);
    _action.Вставить("result", Неопределено);
    _action.Вставить("begin", Неопределено);
    _action.Вставить("end", Неопределено);
    _action.Вставить("time", 0);
    _action.Вставить("total_time", 0);
    _action.Вставить("stat", Новый Структура());
    Если begin Тогда
        Action_set_begin(_action);
	КонецЕсли;
    return _action
КонецФункции

//DynamicDirective
Функция Action_set_begin(_action)
	_action.begin =  ТекущаяУниверсальнаяДатаВМиллисекундах();	
КонецФункции
