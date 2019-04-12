Received: from eggs.gnu.org ([209.51.188.92]:50877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9983bf0bb=Paul.Durrant@citrix.com>)
	id 1hEzD0-0001OL-2H
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9983bf0bb=Paul.Durrant@citrix.com>)
	id 1hEzCz-0002f3-1i
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:39:22 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:30460
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=9983bf0bb=Paul.Durrant@citrix.com>)
	id 1hEzCy-0002dy-Mb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:39:20 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 12 Apr 2019 16:39:16 +0000
Message-ID: <a7934a1de45f4c67bc0d3b500cbe8341@AMSPEX02CL01.citrite.net>
References: <20190412163706.3878-1-philmd@redhat.com>
In-Reply-To: <20190412163706.3878-1-philmd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vl: Add missing descriptions to the VGA
 adapters list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?J1BoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpJw==?= <philmd@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSBbbWFpbHRvOnBoaWxtZEByZWRoYXQuY29tXQ0KPiBTZW50OiAxMiBBcHJpbCAyMDE5IDE3
OjM3DQo+IFRvOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogTWFya3VzIEFybWJydXN0ZXIgPGFybWJy
dUByZWRoYXQuY29tPjsgQW50aG9ueSBQZXJhcmQgPGFudGhvbnkucGVyYXJkQGNpdHJpeC5jb20+
OyBQYXVsIER1cnJhbnQNCj4gPFBhdWwuRHVycmFudEBjaXRyaXguY29tPjsgU3RlZmFubyBTdGFi
ZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPjsgR2VyZCBIb2ZmbWFubg0KPiA8a3JheGVs
QHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hd
IHZsOiBBZGQgbWlzc2luZyBkZXNjcmlwdGlvbnMgdG8gdGhlIFZHQSBhZGFwdGVycyBsaXN0DQo+
IA0KPiBTb21lIFZHQSBhZGFwdGVycyBkbyBub3QgY29udGFpbiBhbiBoZWxwZnVsIGRlc2NyaXB0
aW9uLA0KPiB0aGlzIGNhbiBiZSBjb25mdXNpbmc6DQo+IA0KPiAgICQgcWVtdS1zeXN0ZW0tYXJt
IC1NIHZpcnQgLXZnYSBoZWxwDQo+ICAgbm9uZQ0KPiAgIHN0ZCAgICAgICAgICAgICAgICAgIHN0
YW5kYXJkIFZHQQ0KPiAgIGNpcnJ1cyAgICAgICAgICAgICAgIENpcnJ1cyBWR0EgKGRlZmF1bHQp
DQo+ICAgdm13YXJlICAgICAgICAgICAgICAgVk1XYXJlIFNWR0ENCj4gICB4ZW5mYg0KPiANCj4g
QWRkIGEgZGVzY3JpcHRpb24gdG8gdGhlIG1pc3NpbmcgYWRhcHRlcnM6DQo+IA0KPiAgICQgcWVt
dS1zeXN0ZW0tYXJtIC1NIHZpcnQgLXZnYSBoZWxwDQo+ICAgbm9uZSAgICAgICAgICAgICAgICAg
bm8gZ3JhcGhpYyBjYXJkDQo+ICAgc3RkICAgICAgICAgICAgICAgICAgc3RhbmRhcmQgVkdBDQo+
ICAgY2lycnVzICAgICAgICAgICAgICAgQ2lycnVzIFZHQSAoZGVmYXVsdCkNCj4gICB2bXdhcmUg
ICAgICAgICAgICAgICBWTVdhcmUgU1ZHQQ0KPiAgIHhlbmZiICAgICAgICAgICAgICAgIFhlbiBw
YXJhdmlydHVhbGl6ZWQgZnJhbWVidWZmZXINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IEJhc2VkLW9uOiA8
MjAxOTA0MTIxNTI3MTMuMTYwMTgtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQoNClJl
dmlld2VkLWJ5OiBQYXVsIER1cnJhbnQgPHBhdWwuZHVycmFudEBjaXRyaXguY29tPg0KDQo+IC0t
LQ0KPiAgdmwuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS92bC5jIGIvdmwuYw0KPiBpbmRleCA4NDBjNDVjMDBmYS4uZGZlZGE4
YmQ3ZmMgMTAwNjQ0DQo+IC0tLSBhL3ZsLmMNCj4gKysrIGIvdmwuYw0KPiBAQCAtMjAyOSw2ICsy
MDI5LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVkdBSW50ZXJmYWNlSW5mbyB7DQo+ICBzdGF0aWMgY29u
c3QgVkdBSW50ZXJmYWNlSW5mbyB2Z2FfaW50ZXJmYWNlc1tWR0FfVFlQRV9NQVhdID0gew0KPiAg
ICAgIFtWR0FfTk9ORV0gPSB7DQo+ICAgICAgICAgIC5vcHRfbmFtZSA9ICJub25lIiwNCj4gKyAg
ICAgICAgLm5hbWUgPSAibm8gZ3JhcGhpYyBjYXJkIiwNCj4gICAgICB9LA0KPiAgICAgIFtWR0Ff
U1REXSA9IHsNCj4gICAgICAgICAgLm9wdF9uYW1lID0gInN0ZCIsDQo+IEBAIC0yMDY3LDYgKzIw
NjgsNyBAQCBzdGF0aWMgY29uc3QgVkdBSW50ZXJmYWNlSW5mbyB2Z2FfaW50ZXJmYWNlc1tWR0Ff
VFlQRV9NQVhdID0gew0KPiAgICAgIH0sDQo+ICAgICAgW1ZHQV9YRU5GQl0gPSB7DQo+ICAgICAg
ICAgIC5vcHRfbmFtZSA9ICJ4ZW5mYiIsDQo+ICsgICAgICAgIC5uYW1lID0gIlhlbiBwYXJhdmly
dHVhbGl6ZWQgZnJhbWVidWZmZXIiLA0KPiAgICAgIH0sDQo+ICB9Ow0KPiANCj4gLS0NCj4gMi4y
MC4xDQoNCg==
