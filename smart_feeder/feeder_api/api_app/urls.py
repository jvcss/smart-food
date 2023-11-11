from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import RestaurantViewSet, IngredientViewSet, UsageRateViewSet

router = DefaultRouter()
router.register(r'restaurants', RestaurantViewSet)
router.register(r'ingredients', IngredientViewSet)
router.register(r'usage-rates', UsageRateViewSet)

urlpatterns = [
    path('', include(router.urls)),
]