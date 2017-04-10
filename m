Received: from eggs.gnu.org ([2001:4830:134:3::10]:54301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herbie.robinson@stratus.com>) id 1cxbmU-0007c8-QP
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herbie.robinson@stratus.com>) id 1cxbmR-0005ZD-OJ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:03:06 -0400
Received: from us-smtp-delivery-131.mimecast.com ([216.205.24.131]:21305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <herbie.robinson@stratus.com>)
	id 1cxbmR-0005Yu-HI
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:03:03 -0400
From: "Robinson, Herbie" <Herbie.Robinson@stratus.com>
Date: Mon, 10 Apr 2017 16:02:54 +0000
Message-ID: <BN3PR0801MB0898A85B6C3C2E2AF9984C1BE6010@BN3PR0801MB0898.namprd08.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] ping RE: [PATCH v3] SGABIOS: fix wrong video attrs for
 int 10h, ah==13h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Laurent Vivier <lvivier@redhat.com>

aHR0cDovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzczNzQ0Ni8NCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF1cmVudCBWaXZpZXIgW21haWx0bzpsdml2aWVyQHJl
ZGhhdC5jb21dIA0KU2VudDogRnJpZGF5LCBNYXJjaCAxMCwgMjAxNyAyOjEwIFBNDQpUbzogUm9i
aW5zb24sIEhlcmJpZSA8SGVyYmllLlJvYmluc29uQHN0cmF0dXMuY29tPjsgcWVtdS1kZXZlbEBu
b25nbnUub3JnDQpDYzogcWVtdS10cml2aWFsQG5vbmdudS5vcmcNClN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjNdIFNHQUJJT1M6IGZpeCB3cm9uZyB2aWRlbyBhdHRycyBmb3IgaW50IDEwaCwgYWg9PTEz
aA0KDQpPbiAxMC8wMy8yMDE3IDE2OjU0LCBIZXJiaWUgUm9iaW5zb24gd3JvdGU6DQo+IEZpeCBC
dWcgIzE2NzA1MDk6IHdyb25nIHZpZGVvIGF0dHJzIGZvciBpbnQgMTBoLCBhaD09MTNoIFRoZSAN
Cj4gc3Vicm91dGluZSBzZXRfY3Vyc29yX3Bvc2l0aW9uIGlzIHRyYXNoaW5nICVieC4NCj4gVW5m
b3J0dW5hdGVseSwgJWJsIGNvbnRhaW5zIHRoZSB2aWRlbyBhdHRyaWJ1dGUgZm9yIHdyaXRlX3N0
cmluZy4NCj4gDQo+IFRoZSBmaXggc2F2ZXMgJWJ4IGluIHRoZSBmdW5jdGlvbiBwcm9sb2cgYW5k
IHJlc3RvcmVzIGl0IGluIHRoZSANCj4gZXBpbG9nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGVy
YmllIFJvYmluc29uIDxIZXJiaWUuUm9iaW5zb25Ac3RyYXR1cy5jb20+DQoNClJldmlld2VkLWJ5
OiBMYXVyZW50IFZpdmllciA8bHZpdmllckByZWRoYXQuY29tPg0KDQoNCj4gLS0tDQo+IFJlbW92
ZWQgaW5jb3JyZWN0IGNvZGUgZGVsZXRpb25zIGZyb20gc2V0X2N1cnJlbnRfY3Vyc29yLg0KPiBS
ZW1vdmVkIGV4cGxhbmF0aW9uIG9mIHNhbWUgZnJvbSB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+IA0K
PiBCVFcsIEkgZGlkbid0IHNlZSBhbnkgdGVzdCBjYXNlcyBmb3IgdGhpcyBjb2RlLCBidXQgaWYg
dGhleSBleGlzdCBhbmQgDQo+IHNvbWVib2R5IHBvaW50cyBtZSBhdCB0aGVtLCBJIHNob3VsZCBi
ZSBhYmxlIHRvIGdlbmVyYXRlIGEgdmVyeSBzbWFsbCANCj4gcWNvdzIgZmlsZSB0aGF0IGRlbW9u
c3RyYXRlcyB0aGUgcHJvYmxlbS4NCj4gDQo+ICBzZ2FiaW9zLlMgfCAyICsrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc2dhYmlvcy5TIGIv
c2dhYmlvcy5TDQo+IGluZGV4IDI3NWQwNjMuLjk2YzRlMjMgMTAwNjQ0DQo+IC0tLSBhL3NnYWJp
b3MuUw0KPiArKysgYi9zZ2FiaW9zLlMNCj4gQEAgLTE3MjgsNiArMTcyOCw3IEBAIHdyaXRlX3N0
cmluZ190YWlsOg0KPiAgDQo+ICBzZXRfY3Vyc29yX3Bvc2l0aW9uOg0KPiAgICBwdXNodyAlYXgN
Cj4gKyAgcHVzaHcgJWJ4DQo+ICAgIHB1c2h3ICVkcw0KPiAgICBwdXNodyAkQkRBX1NFRw0KPiAg
ICBwb3B3ICVkcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogZHMgPSAweDQwICovDQo+
IEBAIC0xNzM4LDYgKzE3MzksNyBAQCBzZXRfY3Vyc29yX3Bvc2l0aW9uOg0KPiAgICBtb3Z3ICVh
eCwgJWJ4ICAgICAgICAgICAgICAgICAgICAgICAgLyogYnggPSBjdXJzb3Igc2F2ZSBvZmZzZXQg
Ki8NCj4gICAgbW92dyAlZHgsICglYngpICAgICAgICAgICAgICAgICAgICAgIC8qIHNhdmUgbmV3
IGN1cnNvciB2YWx1ZSAqLw0KPiAgICBwb3B3ICVkcw0KPiArICBwb3B3ICVieA0KPiAgICBwb3B3
ICVheA0KPiAgICByZXQNCj4gIA0KPiANCg0K
