# Payslip Management System Backend
----
**Authors :** 
  - Maryam Saeedmer
  - Sajede Nicknadaf

**Language :**
  - Python , Django
  
**OS :**
  - Ubuntu 20.04 LTS


## Zero Step
- **1.** Installing PostgreSQL on Ubuntu
  ```
  # Create the file repository configuration:
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

  # Import the repository signing key:
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

  # Update the package lists:
  sudo apt-get update

  # Install the latest version of PostgreSQL.
  # If you want a specific version, use 'postgresql-12' or similar instead of 'postgresql':
  sudo apt-get -y install postgresql
  ```
- **2.** 
  ```
   psql -U postgres  
  ```
- **3.**
  ```sql
  ALTER USER postgres PASSWORD '1234';
  ```
- **4.** 
  ```sql
  CREATE DATABASE payslip;
  ```
- **5.** finally press 'Ctrl+D' 
  OR ...
  ```
  postgres=# \q
  ```
  to exit form psql.

## First Step
- **1.** create a folder named 'Payslip'.
- **2.** open the terminal there and :
  ```
   virtualenv .
  ```
  OR ...
  ```
   virtualenv -p python3 .
  ```
- **3.**
  ```
   source bin/activate
  ```
- **4.** 
  ```
   pip install django==2.0.7
  ```
  OR ...
  ```
   pip3 install django==2.0.7
  ```
- **5.**
  ```
   django-admin startproject Payslip .
  ```
- **6.**
  ```
   python manage.py startapp CompanyManagement
   python manage.py startapp EmployeeManagement
   python manage.py startapp FormManagement
   python manage.py startapp ManagerManagement
   python manage.py startapp PayslipManagement
  ```
  OR ...
  ```
   python3 manage.py startapp CompanyManagement
   python3 manage.py startapp EmployeeManagement
   python3 manage.py startapp FormManagement
   python3 manage.py startapp ManagerManagement
   python3 manage.py startapp PayslipManagement
  ```
- **7.** Copy and replace all files from here to your own folders
- **8.**
  ```
  # used for django to connect postgresql 
  pip install psycopg2==2.7.5
  ```
  OR ...
  ```
  pip3 install psycopg2==2.7.5
  ```  
- **9.** 
  ```
  python manage.py createsuperuser
  ```
  OR ...
  ```
  python3 manage.py createsuperuser
  ```
  
## Second Step
  ```
  python manage.py makemigrations
  python manage.py migrate
  ```
  OR ...
  ```
  python3 manage.py makemigrations
  python3 manage.py migrate
  ```

## Finally Run the SERVER
  ```
  python manage.py runserver
  ```
  and it will start to work on localhost and port 8000. (mean that: <a href="http://127.0.0.1:8000">127.0.0.1:8000/</a>)

## How to see our tables from django ?
  just take a look at <a href="http://127.0.0.1:8000/admin/">127.0.0.1:8000/admin/</a>
  you have to enter your username and password that you have created in [First Step](#First-Step) part 9.
