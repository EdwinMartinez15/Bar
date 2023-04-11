from rest_framework import serializers
from .models import Precio

class PrecioSerializar(serializers.ModelSerializer):
    class Meta:
        model = Precio
        fields = (
            'id',
            'producto',
            'proveedor_id'
        )
