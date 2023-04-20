from django.urls import path
from . import views

urlpatterns = [
    path('vista/',views.ProductoListView.as_view()),
    path('precio/', views.PrecioListView.as_view()),
    path(
        'api/precio/list/', 
        views.PrecioListAPIView.as_view()
    ),
    path(
        'api/precio/listaUsuarios/', 
        views.UsuarioListAPIView.as_view()
    ),
    path(
        'api/precio/listaProductos/', 
        views.ProductoListAPIView.as_view()
    ),
    path(
        'api/precio/listaProductosSede/', 
        views.ProductoSedeListAPIView.as_view()
    ),

]