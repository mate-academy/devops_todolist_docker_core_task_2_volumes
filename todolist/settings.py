"""
Django settings for todolist project.
"""

import os

BASE_DIR = os.path.dirname(os.path.dirname(__file__))

# Security settings
SECRET_KEY = os.environ.get(
    "DJANGO_SECRET_KEY",
    "@e2(yx)v&tgh3_s=0yja-i!dpebxsz^dg47x)-k&kq_3zf*9e*",
)

DEBUG = True

ALLOWED_HOSTS = ["localhost", "127.0.0.1"]

DEFAULT_AUTO_FIELD = "django.db.models.AutoField"

# Application definition

INSTALLED_APPS = (
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "todolist",
    "lists",
    "accounts",
    "rest_framework",
    "api",
)

MIDDLEWARE = (
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
)

ROOT_URLCONF = "todolist.urls"

WSGI_APPLICATION = "todolist.wsgi.application"

# MySQL Database configuration

DATABASES = {
    "default": {
        "ENGINE": "mysql.connector.django",
        "NAME": "app_db",
        "USER": "app_user",
        "PASSWORD": os.environ.get("MYSQL_PASSWORD", "1234"),
        "HOST": os.environ.get("MYSQL_HOST", "mysql-container"),
        "PORT": "3306",
    }
}

# Internationalization

LANGUAGE_CODE = "en-us"

TIME_ZONE = "UTC"

USE_I18N = True

USE_L10N = True

USE_TZ = True

# Static files

STATIC_URL = "/static/"

# Login settings

LOGIN_URL = "/auth/login/"

LOGOUT_URL = "/auth/logout/"

# REST API framework

REST_FRAMEWORK = {
    "DEFAULT_PERMISSION_CLASSES": [
        "rest_framework.permissions.DjangoModelPermissionsOrAnonReadOnly"
    ]
}

# Templates

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
                "django.template.context_processors.request",
            ],
            "debug": True,
        },
    },
]
