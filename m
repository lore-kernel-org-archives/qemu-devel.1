Received: from eggs.gnu.org ([2001:4830:134:3::10]:42298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1e5MHr-0003zu-4m
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1e5MHn-0001J7-7t
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:39:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:26089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1e5MHm-0001H4-VU
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:39:43 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Fri, 20 Oct 2017 01:39:38 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5D8665@SHSMSX103.ccr.corp.intel.com>
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-5-git-send-email-changpeng.liu@intel.com>
	<46402c4f-d702-5119-7b99-fa8abb778f66@redhat.com>
In-Reply-To: <46402c4f-d702-5119-7b99-fa8abb778f66@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 4/4] contrib/vhost-user-blk: introduce a
 vhost-user-blk sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@gmail.com" <stefanha@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE5
LCAyMDE3IDc6NDQgUE0NCj4gVG86IExpdSwgQ2hhbmdwZW5nIDxjaGFuZ3BlbmcubGl1QGludGVs
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogc3RlZmFuaGFAZ21haWwuY29tOyBt
c3RAcmVkaGF0LmNvbTsgbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tOw0KPiBmZWxpcGVAbnV0
YW5peC5jb207IEhhcnJpcywgSmFtZXMgUiA8amFtZXMuci5oYXJyaXNAaW50ZWwuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY0IDQvNF0gY29udHJpYi92aG9zdC11c2VyLWJsazogaW50cm9k
dWNlIGEgdmhvc3QtdXNlci1ibGsNCj4gc2FtcGxlIGFwcGxpY2F0aW9uDQo+IA0KPiBPbiAxOS8x
MC8yMDE3IDA3OjI0LCBDaGFuZ3BlbmcgTGl1IHdyb3RlOg0KPiA+DQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyB2b2lkDQo+ID4gK3Z1Yl9mbHVzaChWdWJSZXEgKnJlcSkNCj4gPiArew0KPiA+
ICsgICAgVnViRGV2ICp2ZGV2X2JsayA9IHJlcS0+dmRldl9ibGs7DQo+ID4gKw0KPiA+ICsgICAg
aWYgKHZkZXZfYmxrLT5ibGtfZmQpIHsNCj4gPiArICAgICAgICBmc3luYyh2ZGV2X2Jsay0+Ymxr
X2ZkKTsNCj4gPiArICAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gDQo+IE5vIG5lZWQgdG8gY2hlY2sg
dGhlIGZpbGUgZGVzY3JpcHRvci0tLXZ1Yl9yZWFkdiBhbmQgdnViX3dyaXRldiBhcmVuJ3QNCj4g
Y2hlY2tpbmcgaXQgZWl0aGVyLiAgQWxzbyBwbGVhc2UgdXNlIGZkYXRhc3luYyBpbnN0ZWFkIG9m
IGZzeW5jLg0KT2suDQo+IA0KPiA+ICtzdGF0aWMgdWludDY0X3QNCj4gPiArdnViX2dldF9mZWF0
dXJlcyhWdURldiAqZGV2KQ0KPiA+ICt7DQo+ID4gKyAgICByZXR1cm4gMXVsbCA8PCBWSVJUSU9f
QkxLX0ZfU0laRV9NQVggfA0KPiA+ICsgICAgICAgICAgIDF1bGwgPDwgVklSVElPX0JMS19GX1NF
R19NQVggfA0KPiA+ICsgICAgICAgICAgIDF1bGwgPDwgVklSVElPX0JMS19GX1RPUE9MT0dZIHwN
Cj4gPiArICAgICAgICAgICAxdWxsIDw8IFZJUlRJT19CTEtfRl9CTEtfU0laRSB8DQo+ID4gKyAg
ICAgICAgICAgMXVsbCA8PCBWSVJUSU9fRl9WRVJTSU9OXzEgfA0KPiA+ICsgICAgICAgICAgIDF1
bGwgPDwgVkhPU1RfVVNFUl9GX1BST1RPQ09MX0ZFQVRVUkVTOw0KPiA+ICt9DQo+IA0KPiBWSVJU
SU9fQkxLX0ZfRkxVU0ggaXMgbWlzc2luZy4NClllcywgd2lsbCBhZGQuDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiBQYW9sbw0K
