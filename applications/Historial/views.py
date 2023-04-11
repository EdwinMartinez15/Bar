from django.shortcuts import render
from django.views.generic import  ListView
from .models import Producto
from .models import Precio
# Create your views here.

from rest_framework.generics import ListAPIView
from .serializars import PrecioSerializar

class ProductoListView(ListView):
    model = Producto
    template_name = "Historial/Historial.html"
    context_object_name='historial'


class PrecioListView(ListView):
    model = Precio
    template_name = "Historial/Precio.html"
    context_object_name='precio'

class PrecioListAPIView(ListAPIView):

    serializer_class= PrecioSerializar

    def get_queryset(self):
        return Precio.objects.all()