# Generated by Django 4.2.7 on 2023-11-12 17:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api_app', '0002_ingredientusage_restaurant_ingredients'),
    ]

    operations = [
        migrations.RenameField(
            model_name='restaurant',
            old_name='ingredients',
            new_name='restaurant_ingredients',
        ),
        migrations.RenameField(
            model_name='restaurant',
            old_name='name',
            new_name='restaurant_location',
        ),
        migrations.AddField(
            model_name='restaurant',
            name='restaurant_name',
            field=models.CharField(default='', max_length=255),
            preserve_default=False,
        ),
    ]
