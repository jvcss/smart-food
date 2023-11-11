from django.db import models

class Restaurant(models.Model):
    name = models.CharField(max_length=255)
    restaurant_type = models.CharField(max_length=255)
    ingredients = models.ManyToManyField('Ingredient', through='IngredientUsage')

    def __str__(self):
        return self.name

class Ingredient(models.Model):
    name = models.CharField(max_length=255)
    freshness_time = models.DateTimeField()

    def __str__(self):
        return self.name

class IngredientUsage(models.Model):
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    ingredient = models.ForeignKey(Ingredient, on_delete=models.CASCADE)
    rate = models.FloatField()
    usage_date = models.DateField()

    def __str__(self):
        return f"{self.restaurant} - {self.ingredient} - {self.usage_date}"

class UsageRate(models.Model):
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    ingredient = models.ForeignKey(Ingredient, on_delete=models.CASCADE)
    rate = models.FloatField()
    usage_date = models.DateField()

    def __str__(self):
        return f"{self.restaurant} - {self.ingredient} - {self.usage_date}"