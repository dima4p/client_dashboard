# Project Title

This is part of a code challenge. It's a basic rails application with the following Models: Company, Employee,
PartnerCompany, Contractor and Client

- Authentication;
- Simple UI with bootstrap
- CRUD for all models

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.


### Installing

Clone git repository and run bundle install:

    $ git clone git@github.com:nicosticht/client_dashboard.git
    $ bundle install

Set up the database:

    $ rails db:setup


Run the rails server:

    $ rails s

## Running the tests

To run the tests execute following statement:

    $ bundle exec rake

Or you can use [guard](https://github.com/guard/guard)

    $ bundle exec guard

By default guard does not run all test at start. To trigger it just press <Enter>

## TODO

* Add validation that Consultant **must have** either `contractor` or `employee`
and not both.
* Revise specs for html and json views to extend them to be more percise
* Move API to separate controller, though I am not sure it is required

### Notes

I have included to API all the features that are present in the original views.

## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details
