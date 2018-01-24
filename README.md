# README

* Ruby version 2.4.1

* Some assumptions I've made from the instructions
 - turning 90 degrees to the right or left is NOT meant to be done
   in a clockwise or counter-clockwise fashion.

 - the class can receive coordinates which are outside of the table,
   but I don't count that as it falling off the table, simply that it is put
   off the table and can then ignore commands.

* To run all test
´bundle exec rspec´

* Run application with `ruby main.rb`

* Refactoring notes
- CommandRunner should have single resposibility. It should only run commands, therefore move CommandValidator to main.rb
- CommandRunner know the Commands classes. Does it know to much?
