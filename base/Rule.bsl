// Новое правило конвертации 
//
// Возвращаемое значение:
//  - Структура - Экземпляр класса rule
//
//DynamicDirective
Функция new_rule()
	_rule = Новый Структура;

	_rule.Вставить("data", Новый Соответствие);
	_rule.Вставить("schemes", Новый Соответствие);
	_rule.Вставить("scope", Новый Соответствие);
	
	Возврат _rule;
КонецФункции

// Поднять заполненный экземпляр класса
//
// Параметры:
//  data - Соответствие - Данные правила
//
// Возвращаемое значение:
//  - Структура - Экземпляр класса rule
//
//DynamicDirective
Функция rule_init(data = Неопределено)
	
	_rule = new_rule();

	Если Не data = Неопределено Тогда
		_rule.data = data;
	КонецЕсли;	
	
	Возврат _rule;
КонецФункции

// Прочитать или поднять экземпляр класса rule
//
// Параметры:
// context - Соответствие - Контекст исполняемого блока
// block_context - Соответствие - Контекст текущего выполняемого блока
//
// Возвращаемое значение:
//  - Структура - Экземпляр класса rule
//
//DynamicDirective
Функция rule_init_rule(context, block_context)
	
	context_clients = get_prop(context, "clients");
	Если context_clients = Неопределено Тогда
		context.Вставить("clients", Новый Структура); 
	КонецЕсли;
	rule = get_prop(context_clients, "IntegrationRule");
	Если rule = Неопределено Тогда
		rule_context = block_get_variable(context, "RuleContext");
		rule = rule_init(rule_context);   
		context.clients.Вставить("IntegrationRule", rule);
	КонецЕсли;

	Возврат rule; 
КонецФункции

// Создать обработчик класса rule
//
// Параметры:
// handler_type - Строка - Тип объекта
// rule - Структура - Правила конвертации 
// data - Соответствие - Данные объекта
// scheme - Произвольный - Схема конвертации
// app - Произвольный - Приложение
//
// Возвращаемое значение:
//  - Структура - Обработчик класса rule
//
//DynamicDirective
Функция rule_create_handler(handler_type, rule, data, scheme = Неопределено, app = Неопределено)
	handler = Новый Структура;
	handler.Вставить("base_type", handler_type);
	handler.Вставить("data", data);
	handler.Вставить("scheme", scheme);
	handler.Вставить("app", app);
	
	Возврат handler; 
КонецФункции

// Получить обработчик класса rule по типу
//
// Параметры:
// rule - Структура - Правила конвертации 
// field_value - Соответствие - Данные объекта
//
// Возвращаемое значение:
//  - Структура - Обработчик класса rule
//
//DynamicDirective
Функция rule_get_field_handler_by_value(rule, field_value)
	Если field_value = Неопределено Тогда
    	obj_base_type = "Null";
	Иначе 
		obj_base_type = get_prop(field_value, "_Type", "Dict");
	КонецЕсли;
	Возврат rule_create_handler(obj_base_type, rule, field_value);
КонецФункции

// Установить значение правила
//
// Параметры:
// rule - Структура - Правила конвертации 
// name - Строка - Имя поля объекта назначения
// src_value - Произвольный - Значение поля объекта источника
//
// Возвращаемое значение:
//  - Структура - Значение поля объекта источника
//
//DynamicDirective
Функция rule_set_property(rule, name, src_value) 
	data =  get_prop(rule, "data", Новый Структура);
	Value = get_prop(data, "Value", Новый Соответствие);
	
	Если ТипЗнч(Value) = Тип("Структура") Тогда
		Если Value.Свойство(name) Тогда
			Value[name] = src_value;
		Иначе
			Value.Вставить(name, src_value);
		КонецЕсли;	
	ИначеЕсли ТипЗнч(Value) = Тип("Соответствие") Тогда
		Value.Вставить(name, src_value);	
	Иначе
		ВызватьИсключение NewExtExceptionСтрока(, "Не удалось установить значение");	
	КонецЕсли;
	
	Возврат src_value; 
КонецФункции	

// Добавить область правила
//
// Параметры:
// rule - Структура - Правила конвертации 
// root - Строка - Имя объекта
// name - Строка - Имя поля объекта
//
// Возвращаемое значение:
//  - Структура - Область правила
//
//DynamicDirective
Функция rule_scope_add(rule, root, name) Экспорт
	_scope = get_prop(rule, "scope", Новый Соответствие);
	scope_list = get_prop(_scope, root);

	Если scope_list = Неопределено Тогда
		_data = get_prop(rule, "data", Новый Соответствие);
        value = rule_get_field_handler_by_value(rule, get_prop(_data, root));

        scope_list = Новый Массив;
        root_scope = Новый Структура;

        root_path = Новый Массив;
        root_path.Добавить(root);

        root_scope.Вставить("path", root_path);
        root_scope.Вставить("value", value);
        root_scope.Вставить("scheme", Неопределено); // todo scheme_read()
        root_scope.Вставить("uid", "");  // todo f"{value.app_obj_type}/{value.app_obj_id}" if value.app_obj_id else ''

        scope_list.Добавить(root_scope);

        _scope.Вставить(root, scope_list);

    КонецЕсли;

    last_scope = scope_list[scope_list.Количество() - 1];

    child_scope = Новый Структура;
    child_path = Новый Массив;

    Для Каждого i Из get_prop(last_scope, "path", Новый Массив) Цикл
        child_path.Добавить(i);
    КонецЦикла;

    child_path.Добавить(name);

    child_scope.Вставить("path", child_path);
	last_scope_data = get_prop(last_scope.value, "data", Новый Соответствие);
	last_scope_data_Value = get_prop(last_scope_data, "Value", Новый Структура); 
	
	child_scope_Value = get_prop(last_scope_data_Value, name);
	child_scope_data = Новый Соответствие;
	child_scope_data.Вставить("Value", child_scope_Value);
	child_scope_val = Новый Структура;
	child_scope_val.Вставить("data", child_scope_data); 
	child_scope.Вставить("value", child_scope_val);

    child_scope.Вставить("scheme", Неопределено);
    child_scope.Вставить("uid", "");

    scope_list.Добавить(child_scope);

    Возврат child_scope;

КонецФункции

// Удалить область правила
//
// Параметры:
// rule - Структура - Правила конвертации 
// root - Строка - Имя объекта
//
//DynamicDirective
Процедура rule_scope_remove(rule, root) Экспорт
	_scope = get_prop(rule, "scope", Новый Соответствие);
	scope_list = get_prop(_scope, root);
	scope_list.Удалить(scope_list.Количество()-1);
КонецПроцедуры

// Получить значение поля объекта источника из правила
//
// Параметры:
// src_scope - Соответствие - Область объекта источника
//
// Возвращаемое значение:
//  - Структура - Значение поля объекта источника
//
//DynamicDirective
Функция rule_field_src_calc_value(src_scope) Экспорт
	
	_value = get_prop(src_scope, "value", Новый Структура);
	_data = get_prop(_value, "data", Новый Соответствие);
	Value = get_prop(_data, "Value"); 
	Возврат Value;
КонецФункции

