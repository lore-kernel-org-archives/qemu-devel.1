Received: from eggs.gnu.org ([209.51.188.92]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h0S2V-0005xC-LS
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h0S2U-0004rA-Tc
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:24:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:15338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1h0S2T-0004pX-3f
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:24:26 -0500
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Sun, 3 Mar 2019 14:24:20 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D7806067D90@shsmsx102.ccr.corp.intel.com>
References: <20190228165508.21594-1-chen.zhang@intel.com>
	<20190228165508.21594-6-chen.zhang@intel.com>
	<bd6dbeb3-d22b-e432-8fd4-155141c64ef2@redhat.com>
In-Reply-To: <bd6dbeb3-d22b-e432-8fd4-155141c64ef2@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V2 5/7] qapi/migration.json: Remove a
 variable that doesn't exist in example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86
ZWJsYWtlQHJlZGhhdC5jb21dIA0KU2VudDogRnJpZGF5LCBNYXJjaCAxLCAyMDE5IDE6MDcgQU0N
ClRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBMaSBaaGlqaWFuIDxsaXpo
aWppYW5AY24uZnVqaXRzdS5jb20+OyBaaGFuZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPjsg
RHIuIERhdmlkIEFsYW4gR2lsYmVydCA8ZGdpbGJlcnRAcmVkaGF0LmNvbT47IEp1YW4gUXVpbnRl
bGEgPHF1aW50ZWxhQHJlZGhhdC5jb20+OyB6aGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxp
YW5nQGh1YXdlaS5jb20+OyBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+OyBx
ZW11LWRldiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSCBWMiA1
LzddIHFhcGkvbWlncmF0aW9uLmpzb246IFJlbW92ZSBhIHZhcmlhYmxlIHRoYXQgZG9lc24ndCBl
eGlzdCBpbiBleGFtcGxlDQoNCk9uIDIvMjgvMTkgMTA6NTUgQU0sIFpoYW5nIENoZW4gd3JvdGU6
DQo+IEZyb206IFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0KPiANCj4gUmVtb3Zl
IHRoZSAiYWN0aXZlIiB2YXJpYWJsZSBpbiBleGFtcGxlIGZvciBxdWVyeS1jb2xvLXN0YXR1cy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0K
PiAtLS0NCj4gIHFhcGkvbWlncmF0aW9uLmpzb24gfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2Ug
PGVibGFrZUByZWRoYXQuY29tPg0KDQpNaWdodCBiZSBuaWNlIHRvIG1lbnRpb24gdGhhdCB0aGUg
ZG9jIGJ1ZyBoYXMgYmVlbiBwcmVzZW50IHNpbmNlIHRoZSBjb21tYW5kJ3MgaW50cm9kdWN0aW9u
IGluIGNvbW1pdCBmNTZjMDA2NS4NCg0KU3VyZSwgd2lsbCB3cml0ZSBpbiBuZXh0IHZlcnNpb24u
DQoNClRoYW5rcw0KWmhhbmcgQ2hlbg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvcWFwaS9taWdyYXRp
b24uanNvbiBiL3FhcGkvbWlncmF0aW9uLmpzb24gaW5kZXggDQo+IDQ4ZTIxODgwYTMuLmY0YzE3
NjJkZmMgMTAwNjQ0DQo+IC0tLSBhL3FhcGkvbWlncmF0aW9uLmpzb24NCj4gKysrIGIvcWFwaS9t
aWdyYXRpb24uanNvbg0KPiBAQCAtMTM0Miw3ICsxMzQyLDcgQEANCj4gICMgRXhhbXBsZToNCj4g
ICMNCj4gICMgLT4geyAiZXhlY3V0ZSI6ICJxdWVyeS1jb2xvLXN0YXR1cyIgfSAtIyA8LSB7ICJy
ZXR1cm4iOiB7ICJtb2RlIjogDQo+ICJwcmltYXJ5IiwgImFjdGl2ZSI6IHRydWUsICJyZWFzb24i
OiAicmVxdWVzdCIgfSB9DQo+ICsjIDwtIHsgInJldHVybiI6IHsgIm1vZGUiOiAicHJpbWFyeSIs
ICJyZWFzb24iOiAicmVxdWVzdCIgfSB9DQo+ICAjDQo+ICAjIFNpbmNlOiAzLjENCj4gICMjDQo+
IA0KDQotLQ0KRXJpYyBCbGFrZSwgUHJpbmNpcGFsIFNvZnR3YXJlIEVuZ2luZWVyDQpSZWQgSGF0
LCBJbmMuICAgICAgICAgICArMS05MTktMzAxLTMyMjYNClZpcnR1YWxpemF0aW9uOiAgcWVtdS5v
cmcgfCBsaWJ2aXJ0Lm9yZw0K
