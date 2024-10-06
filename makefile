db:
	cat ./database-schema/schema.sql | sqlite3 cron-monitor.db
