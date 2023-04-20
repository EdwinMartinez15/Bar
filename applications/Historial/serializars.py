from rest_framework import serializers
from .models import Precio, Empleado, Producto, ProdutoSede

class PrecioSerializar(serializers.ModelSerializer):
    class Meta:
        model = Precio
        fields = (
            'id',
            'producto',
            'proveedor_id',
            'precio_compra',
            'fecha_inicio'
        )

class UsuarioSerializar(serializers.ModelSerializer):
    class Meta:
        model = Empleado
        fields = (
            'id',
            'nombres',
            'apellidos',
            'correo',
            'direccion'
        )

class ProductoSerializar(serializers.ModelSerializer):
    class Meta:
        model = Producto
        fields = (
            'id',
            'nombre',
            'valor',
        )

class ProductoSedeSerializar(serializers.ModelSerializer):
    class Meta:
        model = ProdutoSede
        fields = (
            'producto',
            'sede',
            'cantidad',
        )


