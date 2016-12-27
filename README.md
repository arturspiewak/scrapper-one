# README

Project name: **scraper**

It's my app to scrape data from https://www.saxoprint.co.uk/

* Ruby version: 2.3.0
* Rails version: 4.2.2
* Database: PostgreSQL

Set up PostgreSQL DB:

* Create a user in postgresql
```
$ createuser scraper
```

* Create development and test databases
```
$ createdb -Oscraper -Eunicode scraper_development
$ createdb -Oscraper -Eunicode scraper_test
```

* Seed DB
```
$ rake db:seed
```

To run the application, write in your terminal:
```
rails s
```
Your version of the app will appear on address: http://localhost:3000/
