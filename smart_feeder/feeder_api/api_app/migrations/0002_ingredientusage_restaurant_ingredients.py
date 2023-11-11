# Generated by Django 4.2.7 on 2023-11-11 15:45

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api_app', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='IngredientUsage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('rate', models.FloatField()),
                ('usage_date', models.DateField()),
                ('ingredient', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api_app.ingredient')),
                ('restaurant', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api_app.restaurant')),
            ],
        ),
        migrations.AddField(
            model_name='restaurant',
            name='ingredients',
            field=models.ManyToManyField(through='api_app.IngredientUsage', to='api_app.ingredient'),
        ),
    ]
