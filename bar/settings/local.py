from .base import *

DEBUG = True

ALLOWED_HOSTS = []

DATABASES = {
    'default': {
        'ENGINE': 'mssql',
        'NAME': 'Bar',
        'USER': 'sa',
        'PASSWORD': 'Docker@123',
        'HOST': 'localhost',
        'PORT':'',
        'OPTIONS': {
            'driver': 'ODBC Driver 17 for SQL Server',},
    },
}

STATIC_URL = 'static/'
