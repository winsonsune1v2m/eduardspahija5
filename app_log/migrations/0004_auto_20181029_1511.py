# Generated by Django 2.1.1 on 2018-10-29 07:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app_log', '0003_taskrecord'),
    ]

    operations = [
        migrations.AlterField(
            model_name='taskrecord',
            name='task_id',
            field=models.CharField(max_length=64),
        ),
    ]
