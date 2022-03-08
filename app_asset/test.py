from app_asset.tasks import sync_host_info,sync_host_software
from mtrops_v2.settings import SALT_API,SERVER_TAG


#c = add.delay(2,5)
#print(c.get())



c1 = sync_host_info.delay(['192.168.1.1'],SALT_API,SERVER_TAG)
print(c1.id)
