from mtrops_v2 import celery_app as app
from celery.result import AsyncResult

async = AsyncResult(id="af6f4e8e-bff0-4ce2-a1db-0911d83d35f3",app=app)
resutl = async.result
print(resutl)