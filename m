Received: from eggs.gnu.org ([2001:4830:134:3::10]:48562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJdjQ-0005DK-Ve
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJdjM-00069S-Gu
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:07:16 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:4371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJdjL-00068g-To
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:07:12 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 28 Nov 2017 11:06:45 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4A7E32@DGGEMA505-MBS.china.huawei.com>
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<1511859789-43680-4-git-send-email-arei.gonglei@huawei.com>
	<6635d6fc-b924-b558-0fff-120a55ef81e9@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7DC2@DGGEMA505-MBS.china.huawei.com>
	<b98e2b09-35e7-47c2-b49f-982a09804b4f@redhat.com>
In-Reply-To: <b98e2b09-35e7-47c2-b49f-982a09804b4f@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/4] cryptodev-vhost-user: add crypto
 session handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEJvbnppbmkgW21h
aWx0bzpwYm9uemluaUByZWRoYXQuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyOCwg
MjAxNyA2OjQ2IFBNDQo+IFRvOiBHb25nbGVpIChBcmVpKTsgcWVtdS1kZXZlbEBub25nbnUub3Jn
DQo+IENjOiBtc3RAcmVkaGF0LmNvbTsgSHVhbmd3ZWlkb25nIChDKTsgc3RlZmFuaGFAcmVkaGF0
LmNvbTsgWmhvdWppYW4NCj4gKGpheSk7IHBhc2ljQGxpbnV4LnZuZXQuaWJtLmNvbTsgbG9uZ3Bl
bmc7IHhpbi56ZW5nQGludGVsLmNvbTsNCj4gcm95LmZhbi56aGFuZ0BpbnRlbC5jb20NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAzLzRdIGNyeXB0b2Rldi12aG9zdC11c2VyOiBhZGQgY3J5cHRvIHNl
c3Npb24gaGFuZGxlcg0KPiANCj4gT24gMjgvMTEvMjAxNyAxMTo0MywgR29uZ2xlaSAoQXJlaSkg
d3JvdGU6DQo+ID4+IEFzIGZhciBhcyBJIHVuZGVyc3RhbmQsIFZJUlRJT19DUllQVE9fQ0lQSEVS
X0NSRUFURV9TRVNTSU9OIGlzIGNhbGxlZA0KPiBhcw0KPiA+PiBhIHJlc3VsdCBvZiBzZW5kaW5n
IGEgbWVzc2FnZSBvbiB0aGUgY29udHJvbCB2aXJ0cXVldWUuDQo+ID4NCj4gPiBWSVJUSU9fQ1JZ
UFRPX0NJUEhFUl9DUkVBVEVfU0VTU0lPTiBpcyBhIG1lc3NhZ2UgdHlwZSBvZiBjb250cm9sDQo+
IHF1ZXVlLA0KPiA+IE1lYW5zIGNyZWF0aW5nIGEgc2Vzc2lvbiBmb3IgbmV4dCBjcnlwdG8gcmVx
dWVzdHMuDQo+IA0KPiBPaywgc28gdGhlIG1lc3NhZ2UgZG9lcyBoYXZlIHRoZSBzYW1lIG1lYW5p
bmcgYXMgdGhlIGNvbnRyb2wgcXVldWUNCj4gbWVzc2FnZS4gIFRoYW5rcyBmb3IgY29uZmlybWlu
Zy4NCj4gDQo+ID4+IFdoeSBjYW4ndCB2aG9zdC11c2VyIGFsc28gcHJvY2VzcyBjcmVhdGUvZGVz
dHJveSBzZXNzaW9uIG1lc3NhZ2VzIG9uIHRoZQ0KPiA+PiBjb250cm9sIHZpcnRxdWV1ZSwgaW5z
dGVhZCBvZiBoYXZpbmcgZGV2aWNlLXNwZWNpZmljIG1lc3NhZ2VzIGluIHRoZQ0KPiA+PiBwcm90
b2NvbD8NCj4gPg0KPiA+IFlvdSBtZWFuIHdlIGNhbiBzaGFyZSBjb250cm9sIHZpcnRxdWV1ZSB0
byBEUERLIGFzIHdlbGw/IExpa2UgZGF0YSBxdWV1ZXM/DQo+IA0KPiBJIGRvbid0IGtub3cgOikg
YnV0IHdoeSBub3Q/DQo+IA0KQ3VycmVudCB0aGVyZSBhcmUgdHdvIG1haW4gcmVhc29ucyBmb3Ig
dGhpcyBkZXNpZ246DQoNCjEpIHdlIHNob3VsZCB1c2UgYW5vdGhlciBjcHUgdG8gcG9sbGluZyB0
aGUgY29udHJvbCB2aXJ0cXVldWUsIHdoaWNoIGlzIGV4cGVuc2l2ZS4NCjIpIHdlIHNob3VsZCBj
b3B5IHRoZSBsb2dpYyBvZiBwYXJzaW5nIGNvbnRyb2wgbWVzc2FnZSB0byBEUERLLCB3aGljaCBi
cmVhaw0KIGN1cnJlbnQgbGF5ZXJlZCBhcmNoaXRlY3R1cmUgLg0KDQpJJ20gbm90IHN1cmUgaWYg
dGhlcmUgYXJlIGFueSBvdGhlciBoaWRkZW4gaXNzdWVzIGZvciBmdXR1cmUgc2NhbGFiaWxpdHks
IHN1Y2ggYXMNCnVzaW5nIFFlbXUgdG8gbWFuYWdlIHNvbWUgY29udHJvbCBtZXNzYWdlcywgYXZv
aWRpbmcgRC1Eb3MgYXR0YWNrIGV0Yy4NCg0KVGhhbmtzLA0KLUdvbmdsZWkNCg==
