# Generated by Django 2.1.1 on 2018-10-10 06:33

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('app_code', '0002_auto_20181010_1036'),
    ]

    operations = [
        migrations.RenameField(
            model_name='publist',
            old_name='Publist_site',
            new_name='gitcode',
        ),
    ]