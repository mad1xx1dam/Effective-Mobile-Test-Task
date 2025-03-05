CREATE TABLE IF NOT EXISTS users (
    id          BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    email       VARCHAR(256) NOT NULL,
    password    VARCHAR(128) NOT NULL
);
CREATE INDEX idx_users_email ON users(email);

CREATE TABLE IF NOT EXISTS user_roles (
    user_id     BIGINT NOT NULL,
    role        VARCHAR(32) NOT NULL,

    CONSTRAINT fk_user_roles_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role)
);

CREATE TABLE IF NOT EXISTS task (
    id              BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title           VARCHAR(64) NOT NULL,
    description     VARCHAR(512),
    status          VARCHAR(32) NOT NULL,
    priority        VARCHAR(16) NOT NULL,
    performer_id    BIGINT,
    author_id       BIGINT NOT NULL,

    CONSTRAINT fk_task_performer FOREIGN KEY (performer_id) REFERENCES users(id) ON DELETE SET NULL,
    CONSTRAINT fk_task_author FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS comment (
    id          BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    content     VARCHAR(256) NOT NULL,
    task_id     BIGINT NOT NULL,

    CONSTRAINT fk_comment_task FOREIGN KEY (task_id) REFERENCES task(id) ON DELETE CASCADE
);