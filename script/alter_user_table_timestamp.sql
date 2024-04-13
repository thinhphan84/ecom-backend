-- Step 1: Backup your database or ensure you have a way to restore the data if needed.

-- Step 2: Update existing non-NULL values to NULL.
UPDATE users SET updated_at = NULL WHERE updated_at IS NOT NULL;
UPDATE users SET created_at = NULL WHERE created_at IS NOT NULL;
UPDATE users SET buy_package_at = NULL WHERE buy_package_at IS NOT NULL;
UPDATE users SET expired_premium_at = NULL WHERE expired_premium_at IS NOT NULL;

-- Step 3: Alter the columns.
ALTER TABLE users MODIFY COLUMN updated_at TIMESTAMP NULL DEFAULT NULL;
ALTER TABLE users MODIFY COLUMN created_at TIMESTAMP NULL DEFAULT NULL;
ALTER TABLE users MODIFY COLUMN buy_package_at TIMESTAMP NULL DEFAULT NULL;
ALTER TABLE users MODIFY COLUMN expired_premium_at TIMESTAMP NULL DEFAULT NULL;

-- Step 4: Set default values and update behavior.
ALTER TABLE users MODIFY COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE users MODIFY COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE users MODIFY COLUMN buy_package_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE users MODIFY COLUMN expired_premium_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
