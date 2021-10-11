# Generated by Django 2.1.1 on 2018-10-15 07:24

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('app_asset', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='HostDetail',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('host_name', models.CharField(max_length=128, null=True)),
                ('mem_total', models.CharField(max_length=128, null=True)),
                ('swap_size', models.CharField(max_length=64, null=True)),
                ('cpu_model', models.CharField(max_length=128, null=True)),
                ('cpu_nums', models.CharField(max_length=128, null=True)),
                ('disk_info', models.CharField(max_length=256, null=True)),
                ('interface', models.CharField(max_length=256, null=True)),
                ('os_type', models.CharField(max_length=128, null=True)),
                ('kernel_version', models.CharField(max_length=128, null=True)),
                ('os_version', models.CharField(max_length=128, null=True)),
                ('product_name', models.CharField(max_length=128, null=True)),
                ('host', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app_asset.Host')),
            ],
        ),
    ]