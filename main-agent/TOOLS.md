# TOOLS.md — Инструменты категорийного менеджера

Скрипты автоматизации в `scripts/`. Большинство запускается по cron, некоторые — вручную.

---

## 💬 Telegram (Pyrogram / MTProto)

Подключение к рабочему Telegram-аккаунту категорийного менеджера через Pyrogram.

| Скрипт | Назначение | Запуск |
|--------|------------|:------:|
| `telegram_client.py` | Чтение/отправка сообщений, список чатов | по вызову |
| `telegram_login.py` | Авторизация нового аккаунта/обновление сессии | при необходимости |
| `telegram_weekly_digest.py` | Еженедельный сбор сообщений из 5 чатов → суммаризация | cron пт 18:00 |

```bash
.venv-telethon/bin/python3 scripts/telegram_client.py me       # инфо об аккаунте
.venv-telethon/bin/python3 scripts/telegram_client.py dialogs  # список чатов
.venv-telethon/bin/python3 scripts/telegram_client.py read --index 4 --limit 5  # прочитать чат
.venv-telethon/bin/python3 scripts/telegram_client.py send --index 1 "текст"    # отправить
```

- **api_id:** 2040 (Telegram Desktop public)
- **Сессия:** `~/.openclaw/telegram/session` (symlink из основного workspace)
- **Маскировка:** Telegram Desktop 5.10.7 x64 / Windows 10 x64
- **Прокси:** не используется (прямое подключение из РФ)

## 📬 Почта и коммуникации

| Скрипт | Назначение | Запуск |
|--------|------------|:------:|
| `fetch_mail.py` | Забор входящей почты с Exchange (IMAP) | cron 30 мин |
| `find_new_incoming.py` | Поиск новых писем для категорийного менеджера | cron |
| `process_incoming_mail.py` | Единый обработчик входящих писем от поставщиков | cron 10 мин |
| `check_mail_and_notify.py` | Проверка почты + уведомление в Telegram | вручную |
| `send_mail.py` | Отправка писем через SMTP (Exchange) + защита цен | по вызову |
| `auto_process_pricelist_replies.py` | Автообработка ответов на запросы прайсов | cron 10 мин |
| `fetch_attachment.py` | Скачать вложение из письма по UID | по вызову |

## 📊 Цены и реестр прайсов

| Скрипт | Назначение | Запуск |
|--------|------------|:------:|
| `update_price_registry.py` | Обновление реестра прайс-листов (SQLite) | по вызову |
| `process_purchase_prices.py` | Обработка отчёта «Анализ закупок [AI]» | при поступлении |
| `process_pricelist_requests.py` | Авторассылка запросов прайсов (черновики) + проверка даты прайса в БД | cron 8-го числа (initial) / пн-пт (reminders) |
| `update_mapping_from_registry.py` | Обновление сопоставлений номенклатуры после прайса | по вызову |
| `build_mapping_candidates.py` | Построение кандидатов маппинга номенклатуры ↔ реестр | по вызову |

## 📦 1С — отчёты и загрузка данных

| Скрипт | Назначение | Запуск |
|--------|------------|:------:|
| `fetch_db_reports.py` | Забор отчётов из 1С (папка DB) | при поступлении |
| `fetch_db_attachments.py` | Скачать вложения отчётов 1С по UID | по вызову |
| `process_nomenclature.py` | Обработка выгрузки номенклатуры из 1С | при поступлении |
| `process_sales.py` | Обработка отчёта «Продажи по номенклатуре [AI]» | при поступлении |
| `process_stock.py` | Обработка отчёта «Остатки и доступность [AI]» | при поступлении |
| `process_suppliers.py` | Обработка отчёта «Уровень сервиса поставщиков [AI]» | при поступлении |
| `process_db_daily.py` | Ежедневная обработка всех файлов БД от mailshot@tdlfb.ru | cron |

## 🔍 OCR договоров

| Скрипт | Назначение | Запуск |
|--------|------------|:------:|
| `okan_new_ocr.py` | OCR — финальная версия (основной) | по вызову |
| `ocr_contracts_tesseract.py` | OCR договоров через Tesseract (rus+eng) | по вызову |
| `ocr_contracts.py` | OCR сканирование договоров | по вызову |
| `process_one_contract_supplier.py` | EasyOCR → классификация → сохранение | по вызову |
| `rebuild_all_contracts.py` | Полный пересбор всех договоров → .md | вручную |
| `fix_rotated_ocr.py` | Переобработка поставщиков с поворотом 90° | по вызову |
| `run_fix_rotation.sh` | Запуск fix_rotated_ocr.py (cron 4:00) | cron 4:00 |

## 🗄️ База данных

| Скрипт | Назначение | Запуск |
|--------|------------|:------:|
| `db.py` | Модуль инициализации и работы с SQLite (category.db) | импорт |
| `db_migrate.py` | Перенос данных из CSV/XLSX в SQLite | по вызову |

## ☁️ Google Drive

| Скрипт | Назначение | Запуск |
|--------|------------|:------:|
| `gdrive.py` | Upload / download / list файлов | по вызову |
| `download_folder.py` | Рекурсивно скачать все файлы из папки | по вызову |
| `download_single_folder.py` | Скачать одну папку Google Drive | по вызову |

## 🔧 Утилиты

| Скрипт | Назначение | Запуск |
|--------|------------|:------:|
| `convert_to_md.py` | Конвертер файлов (CSV, XLSX, PDF, DOCX) в Markdown | по вызову |

---

**Ключ:** `secrets/google_drive_key.json`
**БД:** `data/category.db` (SQLite, ~191 МБ)
