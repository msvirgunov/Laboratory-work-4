-- Таблиця для зберігання даних користувачів
CREATE TABLE "users" (
    user_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,

    -- Обмеження CHECK з регулярним виразом для валідації формату email
    CONSTRAINT email_format CHECK (
        email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    )
);

-- Таблиця для літературних проєктів
CREATE TABLE literary_projects (
    project_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    creation_date DATE NOT NULL DEFAULT CURRENT_DATE,

    -- Обмеження CHECK з регулярним виразом, 
    -- щоб назва не складалася лише з пробілів
    CONSTRAINT title_not_empty
        CHECK (title ~* '\S'),

    -- Зовнішній ключ, що посилається на таблицю користувачів
    FOREIGN KEY (user_id) REFERENCES "users" (user_id)
);

-- Таблиця для глав, що належать до проєктів
CREATE TABLE chapters (
    chapter_id INTEGER PRIMARY KEY,
    project_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT,

    FOREIGN KEY (project_id) REFERENCES literary_projects (project_id)
);

-- Таблиця для моніторингу сну
CREATE TABLE sleep_modes (
    sleep_mode_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    sleep_time TIME,
    wakeup_time TIME,
    duration_minutes INTEGER,

    CONSTRAINT duration_positive CHECK (duration_minutes > 0),
    FOREIGN KEY (user_id) REFERENCES "users" (user_id)
);

-- Таблиця для рекомендацій
CREATE TABLE recommendations (
    recommendation_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    recommendation_text TEXT NOT NULL,
    creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES "users" (user_id)
);

-- Таблиця для звітів
CREATE TABLE reports (
    report_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    report_content TEXT NOT NULL,
    creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES "users" (user_id)
);

-- Таблиця для нагадувань
CREATE TABLE reminders (
    reminder_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    message VARCHAR(255) NOT NULL,
    reminder_time TIMESTAMP NOT NULL,

    FOREIGN KEY (user_id) REFERENCES "users" (user_id)
);
