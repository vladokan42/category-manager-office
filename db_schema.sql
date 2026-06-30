CREATE TABLE nomenclature (
    code_1c         TEXT PRIMARY KEY,
    name            TEXT,
    unit            TEXT,
    sale_type       TEXT,
    weight_unit     TEXT,
    article         TEXT,
    quality         TEXT,
    description     TEXT,
    vat_rate        TEXT,
    image_file      TEXT,
    site_descr_file TEXT,
    volume          TEXT,
    tnved_code      TEXT,
    okpd2_code      TEXT,
    category        TEXT,
    label_text      TEXT,
    retired         TEXT,
    is_frozen       TEXT,
    is_accessory    TEXT,
    is_perishable   TEXT,
    is_consignment  TEXT,
    barcode         TEXT,
    shelf_life_m18  TEXT,
    shelf_life_p2p6 TEXT,
    shelf_life_p22  TEXT,
    kmafanm         TEXT,
    bgkp            TEXT,
    mold            TEXT,
    saureus         TEXT,
    proteus         TEXT,
    pathogens       TEXT,
    shelf_life_link TEXT,
    created_at      TEXT,
    modified_at     TEXT,
    cook_shelf_4    TEXT,
    cook_shelf_20   TEXT,
    badge_layout    TEXT,
    tech_card       TEXT,
    supplier_article TEXT,
    dds_article     TEXT,
    shelf_life_days TEXT,
    qty_in_pack     TEXT,
    boxes_per_pallet TEXT,
    pcs_per_pallet  TEXT,
    shelf_life_days_num TEXT,
    weight_netto_kg TEXT,
    pack_weight_netto TEXT,
    pcs_in_individual_pack TEXT,
    individual_packs_per_box TEXT,
    data_hash       TEXT,
    loaded_at       TEXT
, name_clean TEXT);
CREATE TABLE sales (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name    TEXT,
    article         TEXT,
    code_1c         TEXT,
    document        TEXT,
    document_date   TEXT,
    customer        TEXT,
    qty             INTEGER,
    total_with_vat  REAL,
    price_with_vat  REAL,
    price_no_vat    REAL,
    vat_rate        REAL,
    source_file     TEXT,
    UNIQUE(document, code_1c, customer, qty, total_with_vat)
);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE purchase_prices (
    id                      INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier                TEXT,
    product_name            TEXT,
    code_1c                 TEXT,
    article                 TEXT,
    price_with_vat          REAL,
    price_no_vat            REAL,
    document                TEXT,
    qty_packages            INTEGER,
    total_no_vat            REAL,
    vat_amount              REAL,
    total_with_vat          REAL,
    qty_pieces              INTEGER,
    price_per_piece_no_vat  REAL,
    price_per_piece_with_vat REAL,
    UNIQUE(document, article, price_per_piece_no_vat, qty_pieces)
);
CREATE TABLE suppliers (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier        TEXT,
    document        TEXT,
    ordered_qty     REAL,
    ordered_sum     REAL,
    received_qty    REAL,
    received_sum    REAL,
    cancelled_qty   REAL,
    cancelled_sum   REAL,
    cancel_reason   TEXT,
    qty_with_cancel REAL,
    fulfillment_pct REAL,
    fulfillment_sum_pct REAL,
    receipt_date    TEXT,
    desired_date    TEXT,
    delay_days      REAL,
    source_file     TEXT,
    UNIQUE(document, supplier)
);
CREATE TABLE price_registry (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier        TEXT NOT NULL,
    name            TEXT,
    price           REAL,
    article         TEXT,
    date            TEXT,
    UNIQUE(supplier, article)
);
CREATE INDEX idx_nomenclature_code_1c   ON nomenclature(code_1c);
CREATE INDEX idx_nomenclature_article   ON nomenclature(article);
CREATE INDEX idx_sales_code_1c          ON sales(code_1c);
CREATE INDEX idx_sales_document         ON sales(document);
CREATE INDEX idx_purchase_prices_article   ON purchase_prices(article);
CREATE INDEX idx_purchase_prices_document  ON purchase_prices(document);
CREATE INDEX idx_suppliers_supplier     ON suppliers(supplier);
CREATE INDEX idx_suppliers_document     ON suppliers(document);
CREATE INDEX idx_price_registry_supplier   ON price_registry(supplier);
CREATE INDEX idx_price_registry_article    ON price_registry(article);
CREATE INDEX idx_pp_code ON purchase_prices(code_1c);
CREATE TABLE IF NOT EXISTS "stock" (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    code_1c         TEXT NOT NULL,
    article         TEXT,
    product_name    TEXT,
    warehouse       TEXT,
    available       REAL,
    on_hand         REAL,
    shipping        REAL,
    reserved        REAL,
    expected        REAL,
    source_file     TEXT NOT NULL,
    loaded_at       TEXT,
    UNIQUE(code_1c, warehouse, source_file)
);
CREATE INDEX idx_stock_code_1c ON stock(code_1c);
CREATE TABLE supplier_profiles (
        id              INTEGER PRIMARY KEY AUTOINCREMENT,
        supplier_name   TEXT UNIQUE,
        price_type      TEXT,
        price_type_without_vat TEXT,
        contact_name    TEXT,
        contact_phone   TEXT,
        contact_email   TEXT,
        payment_terms   TEXT,
        notes           TEXT,
        updated_at      TEXT DEFAULT (datetime('now'))
    );
CREATE TABLE supplier_criteria (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  supplier_name TEXT NOT NULL UNIQUE,
  folder_name TEXT NOT NULL,
  total_score TEXT,
  criterion1_status TEXT,
  criterion1_detail TEXT,
  criterion2_status TEXT,
  criterion2_detail TEXT,
  criterion3_status TEXT,
  criterion3_detail TEXT,
  criterion4_status TEXT,
  criterion4_detail TEXT,
  criterion5_status TEXT,
  criterion5_detail TEXT,
  criterion6_status TEXT,
  criterion6_detail TEXT,
  criterion7_status TEXT,
  criterion7_detail TEXT,
  criterion8_status TEXT,
  criterion8_detail TEXT,
  criterion9_status TEXT,
  criterion9_detail TEXT,
  criterion10_status TEXT,
  criterion10_detail TEXT,
  criterion11_status TEXT,
  criterion11_detail TEXT,
  criterion12_status TEXT,
  criterion12_detail TEXT,
  top_risks TEXT,
  analysis_date TEXT DEFAULT (datetime('now','localtime'))
, full_name TEXT, profile_name TEXT);
CREATE TABLE nomenclature_mapping (
    code_1c TEXT,
    article TEXT,
    name TEXT,
    category TEXT,
    supplier TEXT,
    supplier_article TEXT,
    supplier_name TEXT,
    price REAL,
    date_actual TEXT,
    confidence REAL,
    matched_by TEXT DEFAULT 'ai',
    is_active INTEGER DEFAULT 1,
    matched_at TEXT DEFAULT (datetime('now', 'localtime')),
    updated_at TEXT DEFAULT (datetime('now', 'localtime'))
);
CREATE TABLE employee_contacts (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    surname         TEXT,
    first_name      TEXT,
    patronymic      TEXT,
    position        TEXT,
    department      TEXT,
    department_group TEXT,
    phone           TEXT,
    email           TEXT,
    extension       TEXT,
    notes           TEXT,
    updated_at      TEXT DEFAULT (datetime('now'))
);
CREATE INDEX idx_employee_surname ON employee_contacts(surname);
CREATE INDEX idx_employee_dept ON employee_contacts(department);
CREATE TABLE pricelist_requests (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_name   TEXT UNIQUE,
    email           TEXT,
    email2          TEXT,
    email3          TEXT,
    last_requested  TEXT,
    status          TEXT DEFAULT 'new',
    next_reminder   TEXT,
    reminder_count  INTEGER DEFAULT 0,
    responded       TEXT DEFAULT '',
    created_at      TEXT DEFAULT (datetime('now')),
    updated_at      TEXT DEFAULT (datetime('now'))
, last_message_id TEXT);
CREATE TABLE cancellations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nomenclature TEXT, article TEXT, code_1c TEXT,
    cancel_reason TEXT, order_info TEXT, customer TEXT,
    qty INTEGER, cancel_date TEXT, weekday TEXT,
    category TEXT, buy_price REAL, sell_price REAL,
    supplier TEXT, lost_revenue REAL
);
CREATE INDEX idx_canc_article ON cancellations(article);
CREATE INDEX idx_pp_article ON purchase_prices(article);
CREATE INDEX idx_sales_article ON sales(article);
CREATE INDEX idx_nom_article ON nomenclature(article);
CREATE INDEX idx_canc_order ON cancellations(article, order_info, cancel_reason);
CREATE INDEX idx_canc_reason ON cancellations(article, order_info, cancel_reason);
CREATE TABLE temp_pp_dates(
  article TEXT,
  price_with_vat REAL,
  document TEXT
);
CREATE INDEX idx_pp_art ON temp_pp_dates(article);
CREATE TABLE supplier_warnings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    detected_at TEXT NOT NULL,           -- когда зафиксировано (ISO)
    email_uid TEXT,                       -- UID письма в IMAP
    email_from TEXT,                      -- отправитель
    email_date TEXT,                      -- дата письма
    email_subject TEXT,                   -- тема
    supplier TEXT,                        -- поставщик (извлечённый)
    type TEXT NOT NULL,                   -- warning | claim | disruption
    subtype TEXT,                         -- недопоставка | перенос | брак | рекламация | ...
    items TEXT,                           -- затронутые позиции (артикулы/наименования)
    description TEXT,                     -- краткое описание
    deadline TEXT,                        -- срок исправления, если указан
    status TEXT DEFAULT 'new',            -- new | acknowledged | resolved | rejected
    source TEXT DEFAULT 'email'           -- email | manual | chat
);
CREATE INDEX idx_sw_supplier ON supplier_warnings(supplier);
CREATE INDEX idx_sw_type ON supplier_warnings(type);
CREATE INDEX idx_sw_date ON supplier_warnings(email_date);
CREATE TABLE supplier_settlements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier TEXT,
    doc_type TEXT,
    doc_number TEXT,
    linked_doc TEXT,
    operation_date TEXT,
    amount REAL,
    our_debt_overdue REAL DEFAULT 0,
    our_debt_total REAL DEFAULT 0,
    supplier_debt_overdue REAL DEFAULT 0,
    supplier_debt_total REAL DEFAULT 0,
    source_file TEXT,
    loaded_at TEXT DEFAULT (datetime('now', 'localtime'))
);
CREATE INDEX idx_settle_supplier ON supplier_settlements(supplier);
CREATE INDEX idx_settle_date ON supplier_settlements(operation_date);
CREATE INDEX idx_settle_doc ON supplier_settlements(doc_number);
