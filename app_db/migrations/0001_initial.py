# Generated by Django 2.1.1 on 2018-12-27 07:43

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('app_auth', '0001_initial'),
        ('app_asset', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='BackDb',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('back_db_ip', models.CharField(max_length=128)),
                ('back_db_port', models.CharField(max_length=128)),
                ('back_db_user', models.CharField(max_length=128)),
                ('back_db_passwd', models.CharField(max_length=128)),
            ],
        ),
        migrations.CreateModel(
            name='DB',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('db_name', models.CharField(max_length=256)),
                ('db_port', models.CharField(default=3306, max_length=32)),
                ('db_user', models.CharField(max_length=32)),
                ('db_passwd', models.CharField(max_length=256, null=True)),
                ('db_env', models.CharField(default='测试', max_length=16)),
                ('db_status', models.CharField(max_length=16, null=True)),
                ('db_msg', models.CharField(max_length=512, null=True)),
                ('db_host', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app_asset.Host')),
                ('user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='app_auth.User')),
            ],
        ),
        migrations.CreateModel(
            name='IncDB',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('inc_ip', models.CharField(max_length=128, unique=True)),
                ('inc_port', models.CharField(max_length=32)),
            ],
        ),
        migrations.CreateModel(
            name='Inception',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('inc_title', models.CharField(max_length=128)),
                ('inc_option', models.CharField(default='ON/OFF', max_length=64)),
                ('inc_default', models.CharField(max_length=64)),
                ('inc_msg', models.TextField()),
                ('inc_value', models.CharField(max_length=64)),
            ],
        ),
        migrations.CreateModel(
            name='WorkOrderLog',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('sql', models.TextField()),
                ('msg', models.TextField(null=True)),
                ('from_user', models.CharField(max_length=128)),
                ('inc_status', models.TextField(null=True)),
                ('status', models.CharField(max_length=128)),
                ('exec_result', models.TextField(null=True)),
                ('create_time', models.DateTimeField(auto_now_add=True)),
                ('db', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='app_db.DB')),
                ('review_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='app_auth.User')),
            ],
        ),
    ]
