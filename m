Received: from eggs.gnu.org ([209.51.188.92]:53061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9420f6528=Paul.Durrant@citrix.com>)
	id 1gugE2-0005oS-BG
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9420f6528=Paul.Durrant@citrix.com>)
	id 1gugE1-0000tE-MQ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:20:30 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:52378
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=9420f6528=Paul.Durrant@citrix.com>)
	id 1gugE0-0000mx-Mt
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:20:29 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 15 Feb 2019 16:20:22 +0000
Message-ID: <61c2a38ace454e2d963dcdd89d53737d@AMSPEX02CL03.citrite.net>
References: <CAFEAcA-W7AAFsrEkmUSpwqoQic7TDHnPGwnpFB_FQ25ad32n0A@mail.gmail.com>
	<596fc361faea408cabae8a5f41df2e41@AMSPEX02CL03.citrite.net>
In-Reply-To: <596fc361faea408cabae8a5f41df2e41@AMSPEX02CL03.citrite.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] QEMU xen coverity issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, 'Peter Maydell' <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Anthony Perard <anthony.perard@citrix.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KW3NuaXBdDQo+ID4NCj4gPiAoNSkgQ0lEIDEz
OTg2NDk6IHJlc291cmNlIGxlYWsgaW4geGVuX2Jsb2NrX2RyaXZlX2NyZWF0ZSgpOg0KPiA+DQo+
ID4gSW4gaHcvYmxvY2sveGVuLWJsb2NrLmMgeGVuX2Jsb2NrX2RyaXZlX2NyZWF0ZSgpIENvdmVy
aXR5DQo+ID4gY29tcGxhaW5zIHRoYXQgdGhlIGNhbGwgImRyaXZlcl9sYXllciA9IHFkaWN0X25l
dygpIiBhbGxvY2F0ZXMNCj4gPiBtZW1vcnkgdGhhdCdzIGxlYWtlZCBiZWNhdXNlIHdlIGRvbid0
IHNhdmUgdGhlIHBvaW50ZXIgYW55d2hlcmUNCj4gPiBidXQgZG9uJ3QgZGVhbGxvY2F0ZSBpdCBi
ZWZvcmUgdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24gZWl0aGVyLg0KPiA+IENvdmVyaXR5IGlzIG5v
dCBncmVhdCBhdCB1bmRlcnN0YW5kaW5nIG91ciByZWZjb3VudGluZyBvYmplY3RzLA0KPiA+IGJ1
dCB0aGlzIGRvZXMgbG9vayBsaWtlIGVpdGhlciB3ZSdyZSBtaXNzaW5nIGEgcW9iamVjdF91bnJl
ZigpDQo+ID4gb3Igc29tZXRoaW5nIHNob3VsZCBiZSBrZWVwaW5nIGhvbGQgb2YgdGhlIGRpY3Rp
b25hcnkuIFByb2JhYmx5DQo+ID4gYmVzdCB0byBhc2sgYSBibG9jayBsYXllciBleHBlcnQuDQo+
IA0KPiBBRkFJQ1Qgbm90aGluZyB3aWxsIGNvbnN1bWUgdGhlIGRpY3Rpb25hcnkgc28gaXQgZG9l
cyBhcHBlYXIgdGhhdCB3ZSdyZQ0KPiBtaXNzaW5nIGFuIHVucmVmIGhlcmUuDQoNClRlc3Rpbmcg
cHJvdmVzIG1lIHdyb25nLi4uIFRoaXMgb25lIGlzIGEgZmFsc2UgcG9zaXRpdmUuDQoNCiAgUGF1
bA0K
