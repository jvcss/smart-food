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
        serializer.save()
        headers = self.get_success_headers(serializer.data)

        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        rest_type = serializer.data["restaurant_type"]

        api = GPTApi(api_key='not needed for a local LLM')
        prompt = api.generate_prompt(restaurant_type=rest_type)

        gpt_response = api.gpt4all(prompt)
        return Response(gpt_response)
    
        #return Response(serializer.data)

    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(
            instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)

    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        return Response(status=status.HTTP_204_NO_CONTENT)

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)


class IngredientViewSet(viewsets.ModelViewSet):
    queryset = Ingredient.objects.all()
    serializer_class = IngredientSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)

        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return Response(serializer.data)

    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(
            instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)

    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        return Response(status=status.HTTP_204_NO_CONTENT)

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)


class UsageRateViewSet(viewsets.ModelViewSet):
    queryset = UsageRate.objects.all()
    serializer_class = UsageRateSerializer


# api = GPTApi(api_key=config('OPENAI_API_KEY'))
# api = GPTApi(api_key='not needed for a local LLM')
# prompt = api.generate_prompt(restaurant_type=restaurant.restaurant_type)
# gpt_response = api.call_gpt_api(prompt)
# gpt_response = api.offline_call_gpt_028_api(prompt)
# req = api.reqest_offline_gpt_028_api(prompt)
# clean_response = api.process_gpt_response(gpt_response, as_type=list)
# Add ingredients to the restaurant
# restaurant.ingredients.add(*clean_response)
