# bookmark_manager

Introduction
-------

User Stories
----------

```
As a user,
So that I can revisit a web page,
I'd like to save a list of web page's addresses.

As a user,
So that I can look at my favourite page again,
I'd like to add a bookmark to my bookmark manager.

As a user
So I can remove my bookmark from Bookmark Manager
I want to delete a bookmark.

As a user
So that I can edit a bookmark within Bookmark manager
I want to update a bookmarks
```

![User Story 1](public/User story 1.png)


Instruction
-----
To set up the project, clone this repository and then run: bundle

To set up the database from scratch:
1. Connect to psql
2. Create the database using the psql command CREATE DATABASE bookmark_manager;
3. Connect to the database using the pqsl command \c bookmark_manager;
4. Run the query we have saved in the file 01_create_bookmarks_table.sql
