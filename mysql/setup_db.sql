SET @sql = CONCAT("CREATE USER ", @db_user, "@'%' IDENTIFIED BY '", @db_password, "'");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = CONCAT("CREATE DATABASE ", @db_name);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = CONCAT("GRANT ALL ON ", @db_name, ".*  TO ", @db_user);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
