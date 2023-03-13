from django.urls import path
from . import views

urlpatterns = [
    path('vista/',views.ProductoListView.as_view())
]