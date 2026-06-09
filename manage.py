#!/usr/bin/env python
import os
import sys
from flask_sqlalchemy import SQLAlchemy

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://app_user:1234@0.0.0.0/app_db'
db = SQLAlchemy(app)

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "todolist.settings")

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)
