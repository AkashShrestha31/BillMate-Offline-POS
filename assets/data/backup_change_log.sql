-- Tracks row-level mutations for incremental (delta) backup.
CREATE TABLE BackupChangeLog (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  table_name TEXT NOT NULL,
  row_key TEXT NOT NULL,
  operation TEXT NOT NULL,
  changed_at TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_backup_changelog_id ON BackupChangeLog(id);
CREATE INDEX IF NOT EXISTS idx_backup_changelog_table_row ON BackupChangeLog(table_name, row_key);
