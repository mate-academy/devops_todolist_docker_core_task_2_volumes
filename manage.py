#!/usr/bin/env python
import os
import sys
# from flask import Flask
# from flask_sqlalchemy import SQLAlchemy

# app = Flask(__name__)

# # Configure the MySQL database connection
# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://app_user:1234@172.17.0.2/app_db'
# db = SQLAlchemy(app)


if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "todolist.settings")

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)
