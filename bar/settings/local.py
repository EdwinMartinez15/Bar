from .base import *

DEBUG = True

ALLOWED_HOSTS = []

DATABASES = {
    'default': {
        'ENGINE': 'mssql',
        'NAME': 'Bar2',
        'USER': 'sa',
        'PASSWORD': 'Edwin1',
        'HOST': 'localhost',
        'PORT':'1433',
        'OPTIONS': {
            'driver': 'ODBC Driver 17 for SQL Server',},
    },
}

STATIC_URL = 'static/'
