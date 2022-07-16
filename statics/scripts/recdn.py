import re
from aliyunsdkcore.client import AcsClient
from aliyunsdkcdn.request.v20141111 import RefreshObjectCachesRequest


def ReCDN(region_id,access_key_id,access_key_secret,site_name, file_path):
    """
    阿里云 CDN 刷新
    """
    client = AcsClient(access_key_id,access_key_secret, region_id)
    request = RefreshObjectCachesRequest.RefreshObjectCachesRequest()
    re_url = 'https://%s/%s' % (site_name, file_path)
    url = re.sub("public/", "", re_url)
    request.set_action_name('RefreshObjectCaches')
    request.set_accept_format('json')
    request.set_ObjectPath(url)
    request.set_ObjectType('File')
    response = client.get_response(request)
    return response