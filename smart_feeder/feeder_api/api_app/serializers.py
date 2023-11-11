from rest_framework import serializers
from .models import Restaurant, Ingredient, UsageRate


class RestaurantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurant
        fields = '__all__'


class IngredientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ingredient
        fields = '__all__'


class UsageRateSerializer(serializers.ModelSerializer):
    class Meta:
        model = UsageRate
        fields = '__all__'
