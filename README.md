# Educoding

Educoding is an open source coding platform designed to support students learning Java. The student can solve coding challenges within the browser. An online editor provides server-sided compilation and execution. The result of the execution shall be returned to the student. He does not have to configure anything and can focus on the coding challenge. Automatically applied jUnit tests give the student feedback and reduce the effort to correct the submissions.

All tasks can be managed by privileged persons. The access level depend on the user's role (admin, lecturer, tutor or student).

*Note: Educoding is work in progress. Not all features are implemented yet. It should not be used in productive enviroments.*

## Requirements
- An UNIX operating system (Windows is currently not supported).
- Ruby, preferably in the latest version 2.3.1. To update Ruby, I recommend [rbenv](https://github.com/rbenv/rbenv).
- [Bundler](https://github.com/bundler/bundler) to manage the dependencies.
- Sqlite3 as the DBMS. Later, educoding will use PostgeSQL.
- An installed [JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html). Make sure that `java`and `javac` are in your path variable.

## Installation
Clone this repository with `git clone https://github.com/weberandreaseu/educoding.git` or download the .zip.

Go to the `educoding` directory and run `bundle` to install all dependencies.

Type `rake db:setup` to setup the database.

Start the server with `rails server`.

Educoding should run at [http://localhost:3000](http://localhost:3000)
