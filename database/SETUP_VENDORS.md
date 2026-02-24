# Setup Event Vendors Table

## Steps to add event_vendors table:

1. Open phpMyAdmin: http://localhost/phpmyadmin
2. Select the 'event' database from the left sidebar
3. Click on the 'SQL' tab at the top
4. Copy and paste the contents of `database/event_vendors.sql` file
5. Click 'Go' button to execute

OR

Run this command in MySQL:
```
mysql -u root -p event < database/event_vendors.sql
```

After running the SQL, refresh your Flutter app to see the vendor data.
