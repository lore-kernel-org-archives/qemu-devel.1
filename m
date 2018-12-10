Received: from eggs.gnu.org ([2001:4830:134:3::10]:40517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xuyandong2@huawei.com>) id 1gWArS-0001nL-9E
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 20:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xuyandong2@huawei.com>) id 1gWArL-0003II-AA
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 20:59:54 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2745 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
	id 1gWArK-0003FF-E9
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 20:59:47 -0500
From: xuyandong <xuyandong2@huawei.com>
Date: Mon, 10 Dec 2018 01:59:24 +0000
Message-ID: <7CECC2DFC21538489F72729DF5EFB4D908AC3803@DGGEMM501-MBX.china.huawei.com>
References: <7CECC2DFC21538489F72729DF5EFB4D908ABD3A4@dggemm521-mbs.china.huawei.com>
	<20181209092558-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181209092558-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [BUG]Unassigned mem write during pci device
 hot-plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "marcel@redhat.com" <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

biBTYXQsIERlYyAwOCwgMjAxOCBhdCAxMTo1ODo1OUFNICswMDAwLCB4dXlhbmRvbmcgd3JvdGU6
DQo+ID4gSGkgYWxsLA0KPiA+DQo+ID4NCj4gPg0KPiA+IEluIG91ciB0ZXN0LCB3ZSBjb25maWd1
cmVkIFZNIHdpdGggc2V2ZXJhbCBwY2ktYnJpZGdlcyBhbmQgYQ0KPiA+IHZpcnRpby1uZXQgbmlj
IGJlZW4gYXR0YWNoZWQgd2l0aCBidXMgNCwNCj4gPg0KPiA+IEFmdGVyIFZNIGlzIHN0YXJ0dXAs
IFdlIHBpbmcgdGhpcyBuaWMgZnJvbSBob3N0IHRvIGp1ZGdlIGlmIGl0IGlzDQo+ID4gd29ya2lu
ZyBub3JtYWxseS4gVGhlbiwgd2UgaG90IGFkZCBwY2kgZGV2aWNlcyB0byB0aGlzIFZNIHdpdGgg
YnVzIDAuDQo+ID4NCj4gPiBXZSAgZm91bmQgdGhlIHZpcnRpby1uZXQgTklDIGluIGJ1cyA0IGlz
IG5vdCB3b3JraW5nIChjYW4gbm90IGNvbm5lY3QpDQo+ID4gb2NjYXNpb25hbGx5LCBhcyBpdCBr
aWNrIHZpcnRpbyBiYWNrZW5kIGZhaWx1cmUgd2l0aCBlcnJvciBiZWxvdzoNCj4gPg0KPiA+ICAg
ICBVbmFzc2lnbmVkIG1lbSB3cml0ZSAwMDAwMDAwMGZjODAzMDA0ID0gMHgxDQo+IA0KPiBUaGFu
a3MgZm9yIHRoZSByZXBvcnQuIFdoaWNoIGd1ZXN0IHdhcyB1c2VkIHRvIHByb2R1Y2UgdGhpcyBw
cm9ibGVtPw0KPiANCj4gLS0NCj4gTVNUDQoNCkkgd2FzIHNlZWluZyB0aGlzIHByb2JsZW0gd2hl
biBJIGhvdHBsdWcgYSBWRklPIGRldmljZSB0byBndWVzdCBDZW50T1MgNy40LA0KYWZ0ZXIgdGhh
dCBJIGNvbXBpbGVkIHRoZSBsYXRlc3QgTGludXgga2VybmVsIGFuZCBpdCBhbHNvIGNvbnRhaW5z
IHRoaXMgcHJvYmxlbS4NCg0KVGhpbmtzLA0KWHUNCg0KDQo=
