-- Set the user_version pragma initially to version 1
-- The app can then query this value to determine the
-- state of the schema, and apply changes if needed
-- to bring the schema up to the version required for
-- the code to execute correctly
-- https://www.sqlite.org/pragma.html#pragma_user_version

PRAGMA user_version = 1;

DROP TABLE IF EXISTS monitor;
DROP TABLE IF EXISTS check_ins;

CREATE TABLE monitor (
    ID      INTEGER PRIMARY KEY,
    Slug    TEXT,
    Name    TEXT NOT NULL DEFAULT 'NOT SET',
    Cron    TEXT NOT NULL DEFAULT '*/15 * * * *',
    Status  TEXT NOT NULL DEFAULT 'RED',
    UNIQUE(Slug))
;

INSERT INTO monitor (Name, Cron) VALUES ("Appointment Letters Batch Print", "*/15 * * * *");
INSERT INTO monitor (Name, Cron) VALUES ("Daily Backup Snapshot", "0 17 * * *");
UPDATE monitor SET Slug = substr(hex(Name), 0, 12);
SELECT * FROM monitor;
-- SELECT * FROM monitor WHERE Cron = '0 17 * * *';


CREATE TABLE check_ins (
    ID              INTEGER PRIMARY KEY,
    MonitorID       INTEGER NOT NULL,
    CheckIn         DATETIME NOT NULL,

    FOREIGN KEY (MonitorID) REFERENCES monitor (ID)
);
CREATE INDEX idx_monitorid_checkin ON check_ins (MonitorID, CheckIn);

INSERT INTO check_ins (MonitorID, CheckIn) VALUES (1, datetime('now', '-2 minutes', 'localtime'));
SELECT * FROM check_ins;
