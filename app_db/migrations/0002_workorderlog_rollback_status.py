# Generated by Django 2.1.1 on 2018-12-28 01:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app_db', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='workorderlog',
            name='rollback_status',
            field=models.TextField(null=True),
        ),
    ]