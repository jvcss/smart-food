from django.shortcuts import render
from rest_framework import viewsets
from .models import Restaurant, Ingredient, UsageRate
from .serializers import RestaurantSerializer, IngredientSerializer, UsageRateSerializer

class RestaurantViewSet(viewsets.ModelViewSet):
    queryset = Restaurant.objects.all()
    serializer_class = RestaurantSerializer

class IngredientViewSet(viewsets.ModelViewSet):
    queryset = Ingredient.objects.all()
    serializer_class = IngredientSerializer

class UsageRateViewSet(viewsets.ModelViewSet):
    queryset = UsageRate.objects.all()
    serializer_class = UsageRateSerializer