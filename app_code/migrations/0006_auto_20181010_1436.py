# Generated by Django 2.1.1 on 2018-10-10 06:36

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('app_code', '0005_auto_20181010_1435'),
    ]

    operations = [
        migrations.RenameField(
            model_name='publistrecord',
            old_name='Publist',
            new_name='publist',
        ),
        migrations.RenameField(
            model_name='publistrecord',
            old_name='Publist_date',
            new_name='publist_date',
        ),
        migrations.RenameField(
            model_name='wchartreq',
            old_name='Site_name',
            new_name='site_name',
        ),
    ]
