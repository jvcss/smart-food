from django.shortcuts import render
from decouple import config

from rest_framework.response import Response
from rest_framework import status, viewsets

from .models import Restaurant, Ingredient, UsageRate
from .serializers import RestaurantSerializer, IngredientSerializer, UsageRateSerializer
from .gpt_api import GPTApi

class RestaurantViewSet(viewsets.ModelViewSet):
    queryset = Restaurant.objects.all()
    serializer_class = RestaurantSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        # Your custom logic here, to save properly the names, remove special chars
        restaurant = serializer.save()

        #api = GPTApi(api_key=config('OPENAI_API_KEY'))
        api = GPTApi(api_key='not needed for a local LLM')

        prompt = api.generate_prompt(restaurant_type=restaurant.restaurant_type)

        #gpt_response = api.call_gpt_api(prompt)
        gpt_response = api.offline_call_gpt_028_api(prompt)

        req = api.reqest_offline_gpt_028_api(prompt)

        clean_response = api.process_gpt_response(gpt_response, as_type=list)

        # Add ingredients to the restaurant
        restaurant.ingredients.add(*clean_response)

        headers = self.get_success_headers(serializer.data)

        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

class IngredientViewSet(viewsets.ModelViewSet):
    queryset = Ingredient.objects.all()
    serializer_class = IngredientSerializer

class UsageRateViewSet(viewsets.ModelViewSet):
    queryset = UsageRate.objects.all()
    serializer_class = UsageRateSerializer