# Student Management System

A simple admin-only student management web application built with Java Servlets, JSP, JDBC, MySQL, and Apache Tomcat. It is designed as a small academic project that is easy to run and explain.

## Features

- Admin login and logout with session protection
- Dashboard summary
- Student add, view, search, update, and delete
- Marks, attendance, and fee tracking
- MySQL schema and sample data in `database.sql`

## Technology

- Java 17
- Maven 3.9+
- Apache Tomcat 9
- MySQL 8+

## Requirements

Install Java 17, Maven, MySQL, and Tomcat 9. The app uses the `javax.servlet` API and is intended for Tomcat 9.

## Database setup

1. Start MySQL.
2. Run `database.sql` using MySQL Workbench or the MySQL command line. **This script drops and recreates the project tables**, so do not run it against a database with data you need to keep.
3. Configure the database environment variables before starting Tomcat:

| Variable | Default | Description |
| --- | --- | --- |
| `DB_HOST` | `localhost` | MySQL server host |
| `DB_PORT` | `3306` | MySQL server port |
| `DB_NAME` | `student_management` | Database name |
| `DB_USER` | `root` | MySQL username |
| `DB_PASSWORD` | Required | MySQL password; never commit this value |

The project fails with a clear database configuration error if `DB_PASSWORD` is missing. Do not put real credentials in Java files, `db.properties.example`, or GitHub.

PowerShell example for a local session (replace the placeholder privately):

```powershell
$env:DB_HOST = "localhost"
$env:DB_PORT = "3306"
$env:DB_NAME = "student_management"
$env:DB_USER = "root"
$env:DB_PASSWORD = "your_local_password"
```

Start Tomcat from that same PowerShell session so it inherits the variables. For a persistent local setup, configure them in your Windows user environment settings and restart Tomcat.

The sample database inserts an admin account with username `admin` and password `admin123`. Change this sample password before exposing the application to the internet. It is a demonstration login, not a production credential.

## Build and run

Build the WAR:

```powershell
mvn clean package
```

Copy `target/StudentManagementSystem.war` into Tomcat 9's `webapps` folder and start Tomcat. Open:

`http://localhost:8080/StudentManagementSystem/login`

## Project structure

```text
src/main/java/com/sms/  Servlets, DAO classes, models, and database helper
src/main/webapp/        JSP pages, CSS, and WEB-INF configuration
database.sql            MySQL schema and sample rows
pom.xml                 Maven WAR build configuration
```

## GitHub

The repository should contain source, `database.sql`, `pom.xml`, and documentation. Generated `target/` files, WARs, and local credentials are excluded by `.gitignore`. Review `git status` before publishing and never commit real `.env` or database credential files.
