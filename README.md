# Homework #2

5 points.  Due before the next class.


### Requirements

As a site visitor, I want to:

1. (1 pt ) See a list of Divvy stations
2. (2 pts) Click on a station to see station details
3. (2 pts) Enter an address to see the nearest station

You must support the following URLs:

* `/stations`: Show the list of stations
* `/stations/{station-id}`: Show the details for a given station
* Home page: same as `/stations`

If you need more URLs, you can invent them as you see fit.

Go to https://mpcs52553-hw2.herokuapp.com to see a live example. Your app does not need to visually look the same, but the user should be able to navigate their way around in a similar fashion.  


### Hints

* Bootstrap is already included for you.  Examine the application-wide
layout `app/views/layouts/application.html.erb`.
* I've provided a model named `DivvyStation` which can retrieve station data (`DivvyStation.all`) and can find the station nearest for you, given an address (`DivvyStation.find_nearest_station()`).  Find it in `app/models/divvy_station.rb`.
* Don't forget: the `params[]` hash always contains `String` values.  You can convert a string to an integer with `.to_i`, and you can convert an integer to a string with `.to_s`.
* You can modify the `DivvyStation` class as you see fit.
* I've also provided a view helper, `<%= show_map(lat, lng) %>` that will
show a Google Map centered on the given latitude and longitude.
* Ruby arrays have lots of useful methods for searching and sorting.  Part of this homework is intended to inspire you to learn how to search for what you need in the Ruby online documentation and use it.
