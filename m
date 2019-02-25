Received: from eggs.gnu.org ([209.51.188.92]:55268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyFFS-0001AU-J2
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyFFI-0004JH-3H
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:20:35 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Feb 2019 12:20:07 +0000
Message-ID: <de306b00-6c38-eb74-a970-19bb6d45f33f@virtuozzo.com>
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-10-jsnow@redhat.com>
In-Reply-To: <20190223000614.13894-10-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5252D0FCFC874545A9C6CA4A71F4C6D5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 09/10] blockdev: remove unused paio
 parameter documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

MjMuMDIuMjAxOSAzOjA2LCBKb2huIFNub3cgd3JvdGU6DQo+IFRoaXMgZmllbGQgaXNuJ3QgcHJl
c2VudCBhbnltb3JlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRo
YXQuY29tPg0KPiAtLS0NCj4gICBibG9ja2Rldi5jIHwgMSAtDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9ja2Rldi5jIGIvYmxvY2tkZXYu
Yw0KPiBpbmRleCAxYWFhZGI2MTI4Li5jYmNlNDQ4NzdkIDEwMDY0NA0KPiAtLS0gYS9ibG9ja2Rl
di5jDQo+ICsrKyBiL2Jsb2NrZGV2LmMNCj4gQEAgLTEyNTUsNyArMTI1NSw2IEBAIG91dF9haW9f
Y29udGV4dDoNCj4gICAgKiBAbm9kZTogVGhlIG5hbWUgb2YgdGhlIEJEUyBub2RlIHRvIHNlYXJj
aCBmb3IgYml0bWFwcw0KPiAgICAqIEBuYW1lOiBUaGUgbmFtZSBvZiB0aGUgYml0bWFwIHRvIHNl
YXJjaCBmb3INCj4gICAgKiBAcGJzOiBPdXRwdXQgcG9pbnRlciBmb3IgQkRTIGxvb2t1cCwgaWYg
ZGVzaXJlZC4gQ2FuIGJlIE5VTEwuDQo+IC0gKiBAcGFpbzogT3V0cHV0IHBvaW50ZXIgZm9yIGFp
b19jb250ZXh0IGFjcXVpc2l0aW9uLCBpZiBkZXNpcmVkLiBDYW4gYmUgTlVMTC4NCj4gICAgKiBA
ZXJycDogT3V0cHV0IHBvaW50ZXIgZm9yIGVycm9yIGluZm9ybWF0aW9uLiBDYW4gYmUgTlVMTC4N
Cj4gICAgKg0KPiAgICAqIEByZXR1cm46IEEgYml0bWFwIG9iamVjdCBvbiBzdWNjZXNzLCBvciBO
VUxMIG9uIGZhaWx1cmUuDQo+IA0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=
