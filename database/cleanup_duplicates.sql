-- Delete duplicate entries for event_id 36, keeping only IDs 13-16
DELETE FROM event_days WHERE id >= 17 AND id <= 25 AND event_id = 36;
