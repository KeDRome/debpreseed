# Debian APU, {Auto.Auto, Auto.Parted, Auto.User} +GUI
Файл-конфигурации, с помощью которого можно автоматизировать установку и преднастроить рабочее место
Выполняет:
- Автоматическую настройку
- Автоматически разбивает диск
- Автоматически создает пользователя

# Скрипт автоматической сборки образа

Автоматическая установка ATHENA на ОС Debian 10 

## Подготовка
Чтобы собрать свой образ, нам потребуется:
- Файл .iso (Debian)    # Образ который будет являться основой
- Preseed.cfg           # Хранящий в себе конфигурацию будущей системы

## Использование
> PRESEED_FILE=/path/to/preseed.cfg \
> INPUT_ISO=/path/to/debian.iso \
> OUTPUT_ISO=/path/to/output.iso \
>./makeiso.sh $PRESEED_FILE $INPUT_ISO $OUTPUT_ISO