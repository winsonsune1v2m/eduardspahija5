from django.db import models

# Create your models here.

class EnvSofeware(models.Model):
    sofeware_name = models.CharField(max_length=128)
    sofeware_version = models.CharField(max_length=128,null=True)
    install_script = models.TextField(null=True)
    def __unicode__(self):
        return self.sofeware_name
