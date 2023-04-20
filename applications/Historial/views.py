from django.shortcuts import render
from django.views.generic import  ListView
from .models import Producto, Precio, Empleado, ProdutoSede
# Create your views here.

from rest_framework.generics import ListAPIView
from .serializars import PrecioSerializar, UsuarioSerializar, ProductoSerializar, ProductoSedeSerializar

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
    
class UsuarioListAPIView(ListAPIView):

    serializer_class= UsuarioSerializar

    def get_queryset(self):
        return Empleado.objects.all()
    
class ProductoListAPIView(ListAPIView):

    serializer_class= ProductoSerializar

    def get_queryset(self):
        return Producto.objects.all()
    
class ProductoSedeListAPIView(ListAPIView):

    serializer_class= ProductoSedeSerializar

    def get_queryset(self):
        return ProdutoSede.objects.all()