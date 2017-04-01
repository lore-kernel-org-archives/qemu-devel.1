Received: from eggs.gnu.org ([2001:4830:134:3::10]:57257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liqiang6-s@360.cn>) id 1cu7uO-0004OW-Gw
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 21:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liqiang6-s@360.cn>) id 1cu7uJ-0001Dl-N3
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 21:32:52 -0400
Received: from mtabjsc2.360.cn ([123.125.82.7]:51583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liqiang6-s@360.cn>) id 1cu7uJ-0001AX-1t
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 21:32:47 -0400
From: =?utf-8?B?5p2O5by6?= <liqiang6-s@360.cn>
Date: Sat, 1 Apr 2017 01:32:38 +0000
Message-ID: <143C0AFC63FC204CB0C55BB88F3A8ABB3339E708@EX02.corp.qihoo.net>
References: <149095959109.26233.3201018420228514740.stgit@bahia>
	<149095962044.26233.2156597686399438923.stgit@bahia.lan>
In-Reply-To: <149095962044.26233.2156597686399438923.stgit@bahia.lan>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [for-2.9 PATCH 1/3] 9pfs: clear migration blocker
 at session reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLdXJ6IFttYWls
dG86Z3JvdWdAa2FvZC5vcmddDQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMzEsIDIwMTcgNzoyNyBQ
TQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBFcmljIEJsYWtlOyDmnY7lvLo7
IEdyZWcgS3Vyeg0KPiBTdWJqZWN0OiBbZm9yLTIuOSBQQVRDSCAxLzNdIDlwZnM6IGNsZWFyIG1p
Z3JhdGlvbiBibG9ja2VyIGF0IHNlc3Npb24gcmVzZXQNCj4gDQo+IFRoZSBtaWdyYXRpb24gYmxv
Y2tlciBzdXJ2aXZlcyBhIGRldmljZSByZXNldDogaWYgdGhlIGd1ZXN0IG1vdW50cyBhIDlwIHNo
YXJlDQo+IGFuZCB0aGVuIGdldHMgcmVib290ZWQgd2l0aCBzeXN0ZW1fcmVzZXQsIGl0IHdpbGwg
YmUgdW5taWdyYXRhYmxlIHVudGlsIGl0DQo+IHJlbW91bnRzIGFuZCB1bW91bnRzIHRoZSA5cCBz
aGFyZSBhZ2Fpbi4NCj4gDQo+IFRoaXMgaGFwcGVucyBiZWNhdXNlIHRoZSBtaWdyYXRpb24gYmxv
Y2tlciBpcyBzdXBwb3NlZCB0byBiZSBjbGVhcmVkIHdoZW4gd2UNCj4gcHV0IHRoZSBsYXN0IHJl
ZmVyZW5jZSBvbiB0aGUgcm9vdCBmaWQsIGJ1dCB2aXJ0ZnNfcmVzZXQoKSB3cm9uZ2x5IGNhbGxz
DQo+IGZyZWVfZmlkKCkgaW5zdGVhZCBvZiBwdXRfZmlkKCkuDQo+IA0KPiBUaGlzIHBhdGNoIGZp
eGVzIHZpcnRmc19yZXNldCgpIHNvIHRoYXQgaXQgaG9ub3IgdGhlIHdheSBmaWRzIGFyZSBzdXBw
b3NlZCB0byBiZQ0KPiBtYW5pcHVsYXRlZDogZmlyc3QgZ2V0IGEgcmVmZXJlbmNlIGFuZCBsYXRl
ciBwdXQgaXQgYmFjayB3aGVuIHlvdSdyZSBkb25lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3Jl
ZyBLdXJ6IDxncm91Z0BrYW9kLm9yZz4NCj4gLS0tDQoNClJldmlld2VkLWJ5OiBMaSBRaWFuZyA8
bGlxaWFuZzYtc0AzNjAuY24+DQoNCj4gIGh3LzlwZnMvOXAuYyB8ICAgMTEgKysrKysrLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaHcvOXBmcy85cC5jIGIvaHcvOXBmcy85cC5jIGluZGV4IDQ4YmFiY2U4
MzZiNi4uY2MxMDkzNjdiMDMwDQo+IDEwMDY0NA0KPiAtLS0gYS9ody85cGZzLzlwLmMNCj4gKysr
IGIvaHcvOXBmcy85cC5jDQo+IEBAIC01MzksMTQgKzUzOSwxNSBAQCBzdGF0aWMgdm9pZCBjb3Jv
dXRpbmVfZm4gdmlydGZzX3Jlc2V0KFY5ZnNQRFUgKnBkdSkNCj4gDQo+ICAgICAgLyogRnJlZSBh
bGwgZmlkcyAqLw0KPiAgICAgIHdoaWxlIChzLT5maWRfbGlzdCkgew0KPiArICAgICAgICAvKiBH
ZXQgZmlkICovDQo+ICAgICAgICAgIGZpZHAgPSBzLT5maWRfbGlzdDsNCj4gKyAgICAgICAgZmlk
cC0+cmVmKys7DQo+ICsNCj4gKyAgICAgICAgLyogQ2x1bmsgZmlkICovDQo+ICAgICAgICAgIHMt
PmZpZF9saXN0ID0gZmlkcC0+bmV4dDsNCj4gKyAgICAgICAgZmlkcC0+Y2x1bmtlZCA9IDE7DQo+
IA0KPiAtICAgICAgICBpZiAoZmlkcC0+cmVmKSB7DQo+IC0gICAgICAgICAgICBmaWRwLT5jbHVu
a2VkID0gMTsNCj4gLSAgICAgICAgfSBlbHNlIHsNCj4gLSAgICAgICAgICAgIGZyZWVfZmlkKHBk
dSwgZmlkcCk7DQo+IC0gICAgICAgIH0NCj4gKyAgICAgICAgcHV0X2ZpZChwZHUsIGZpZHApOw0K
PiAgICAgIH0NCj4gIH0NCj4gDQoNCg==
