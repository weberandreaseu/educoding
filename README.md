# Educoding

Educoding is an open source coding platform designed to support students learning Java. The student can solve coding challenges within the browser. An online editor provides server-sided compilation and execution. The result of the execution shall be returned to the student. He does not have to configure anything and can focus on the coding challenge. Automatically applied jUnit tests give the student feedback and reduce the effort to correct the submissions.

All tasks can be managed by privileged persons. The access level depend on the user's role (admin, lecturer, tutor or student).

*Note: Educoding is work in progress. Not all features are implemented yet. It should not be used in productive enviroments.*

## Requirements
- An UNIX operating system (Windows is currently not supported).
- Ruby, preferably in the latest version 2.3.1. To update Ruby, I recommend [rbenv](https://github.com/rbenv/rbenv).
- [Bundler](https://github.com/bundler/bundler) to manage the dependencies.
- PostgeSQL as the DBMS.
- An installed JDK.
- [Gradle](https://gradle.org/) (Make sure that `gradle` is in your $PATH variable).

## Installation
1. Clone this repository with `git clone https://github.com/weberandreaseu/educoding.git` or download the .zip.
1. Go to the `educoding` directory and run `bundle` to install all dependencies.
1. Set username and password for the postgres connection in `config/database.yml`
1. [Start](https://www.postgresql.org/docs/9.1/static/server-start.html) the postgres database server
1. Type `rake db:setup` to setup the database.
1. Start the rails application with `rails server`. Educoding should be available at [http://localhost:3000/](http://localhost:3000/).