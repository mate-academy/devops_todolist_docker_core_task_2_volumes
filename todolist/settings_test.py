from .settings import *

# Використовуємо SQLite у пам’яті замість MySQL
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': ':memory:',
    }
}