# TOOLS.md — Что мне доступно

## ✅ Разрешено

### Чтение
- `data/category.db` — вся база (read-only через симлинк)
- `reference/` своего workspace — справочники, whitelist
- `incoming/` — файлы от сотрудников
- `memory/` своего workspace — собственные заметки

### Запись
- `outgoing/` — результаты для сотрудников
- `audit/` — журнал запросов, попыток обхода

### Telegram
- Отвечать сотрудникам из whitelist
- Принимать файлы и прикладывать ответные

## ❌ Запрещено (системно, через permissions)

- Любой запуск shell-команд (`Bash`)
- Любая запись вне `outgoing/` и `audit/`
- Чтение `secrets/`, `credentials/`, `.openclaw/`, `memory/` основного workspace
- Создание/изменение скиллов
- Cron, scheduled tasks
- Email-отправка (`scripts/send_mail.py`, IMAP-черновики)
- Скрипты для рассылки прайсов, ответов поставщикам, OCR договоров (это инструменты Господина)
- web_fetch, web_search без явного разрешения в SOUL

## 🧰 Скилы

### Доступны (read-only справки и аналитика)
- `article-search` — поиск товара/цены
- `price-analysis` — анализ цен
- `price-comparison` — сравнение прайсов
- `excel-fill` — заполнение Excel по артикулу (результат в `outgoing/`)
- `margin-control` — наценка, рентабельность
- `abc-xyz-analysis` — ABC/XYZ анализ
- `supplier-knowledge-base` — справка по поставщику
- `supplier-search` — поиск нового поставщика
- `supplier-substitution-search` — замена при срыве
- `supplier-delivery-analysis` — уровень сервиса
- `contract-archive-search` — поиск в архиве договоров
- `kp-collection` — сбор КП
- `supplier-portrait` — портрет поставщика
- `disruption-analysis` — анализ срывов
- `email-data-extraction` — разбор писем поставщиков (для извлечения данных, не для ответа)
- `price-change-journal` — журнал изменений цен
- `price-list-parsing` — разбор прайс-листа

### Запрещены явно
- `email-reply-drafting` — твоя почта запрещена
- `outlook` — нет почты
- `pricelist-request` — рассылка от твоего имени запрещена
- `signed-spec-to-price-loading` — рассылка запрещена
- `auto-price-increase-reply` — ответы поставщикам запрещены
- `supplier-warning-tracker` — запись в системные данные запрещена
- `1c-integration` — приём отчётов 1С — это инструмент Господина
- `okan-new-ocr` — OCR договоров — инструмент Господина
- `price-registry-update` — обновление реестра — запрещено
- `pricelist-automation-flow` — автозапрос прайсов запрещён
- `auto-updater` — системные обновления запрещены
- `telegram-client` (Pyrogram через личный аккаунт Господина) — категорически запрещён
- `taskflow` — фоновые задачи запрещены
- `cron` — расписания запрещены
- `skill-creator`, `skill_workshop` — изменение скилов запрещено
- `browser-automation`, `notion`, `tavily`, `weather` — внешние сервисы не нужны

## 🤖 Telegram-бот

- Account: `category` (бот ID 8896266630)
- Whitelist через `channels.telegram.accounts.category.allowFrom`
- Чужие user_id — тихий игнор
