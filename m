Received: from eggs.gnu.org ([209.51.188.92]:57289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gk975-0005xo-Ju
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gk974-0006Wq-Ry
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:57:47 -0500
Received: from mail-eopbgr780139.outbound.protection.outlook.com
	([40.107.78.139]:34070
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gk974-0006Vu-L3
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:57:46 -0500
From: Stefan Markovic <smarkovic@wavecomp.com>
Date: Thu, 17 Jan 2019 14:57:42 +0000
Message-ID: <7fe1e745-fc02-65ef-4b4d-241707e0abba@wavecomp.com>
References: <1546533252-26601-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1546533252-26601-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546533252-26601-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <60F005B637E263489BC16B30F5A74A01@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/8] target/mips: Add preprocessor
 constants for 32 major CP0 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

DQpPbiAzLjEuMTkuIDE3OjM0LCBBbGVrc2FuZGFyIE1hcmtvdmljIHdyb3RlOg0KPiBGcm9tOiBB
bGVrc2FuZGFyIE1hcmtvdmljIDxhbWFya292aWNAd2F2ZWNvbXAuY29tPg0KPg0KPiBBZGQgcHJl
cHJvY2Vzc29yIGNvbnN0YW50cyBmb3IgMzIgbWFqb3IgQ1AwIHJlZ2lzdGVycy4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogQWxla3NhbmRhciBNYXJrb3ZpYyA8YW1hcmtvdmljQHdhdmVjb21wLmNvbT4N
Cj4gLS0tDQo+ICAgdGFyZ2V0L21pcHMvY3B1LmggfCAzMiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspDQoNCg0KUmV2
aWV3ZWQtYnk6IFN0ZWZhbiBNYXJrb3ZpYyA8c21hcm9rdmljQHdhdmVjb21wLmNvbT4NCg0KDQo+
IGRpZmYgLS1naXQgYS90YXJnZXQvbWlwcy9jcHUuaCBiL3RhcmdldC9taXBzL2NwdS5oDQo+IGlu
ZGV4IDZjMmE3ZTQuLmIwOTU0MjIgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9taXBzL2NwdS5oDQo+
ICsrKyBiL3RhcmdldC9taXBzL2NwdS5oDQo+IEBAIC0yMzMsNiArMjMzLDM4IEBAIHR5cGVkZWYg
c3RydWN0IG1pcHNfZGVmX3QgbWlwc19kZWZfdDsNCj4gICAgKiA3ICAgVGFnTG8gICAgICAgICAg
ICAgVGFnSGkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgS1NjcmF0Y2g8bj4NCj4gICAg
Kg0KPiAgICAqLw0KPiArI2RlZmluZSBDUE9fUkVHSVNURVJfMDAgICAgIDANCj4gKyNkZWZpbmUg
Q1BPX1JFR0lTVEVSXzAxICAgICAxDQo+ICsjZGVmaW5lIENQT19SRUdJU1RFUl8wMiAgICAgMg0K
PiArI2RlZmluZSBDUE9fUkVHSVNURVJfMDMgICAgIDMNCj4gKyNkZWZpbmUgQ1BPX1JFR0lTVEVS
XzA0ICAgICA0DQo+ICsjZGVmaW5lIENQT19SRUdJU1RFUl8wNSAgICAgNQ0KPiArI2RlZmluZSBD
UE9fUkVHSVNURVJfMDYgICAgIDYNCj4gKyNkZWZpbmUgQ1BPX1JFR0lTVEVSXzA3ICAgICA3DQo+
ICsjZGVmaW5lIENQT19SRUdJU1RFUl8wOCAgICAgOA0KPiArI2RlZmluZSBDUE9fUkVHSVNURVJf
MDkgICAgIDkNCj4gKyNkZWZpbmUgQ1BPX1JFR0lTVEVSXzEwICAgIDEwDQo+ICsjZGVmaW5lIENQ
T19SRUdJU1RFUl8xMSAgICAxMQ0KPiArI2RlZmluZSBDUE9fUkVHSVNURVJfMTIgICAgMTINCj4g
KyNkZWZpbmUgQ1BPX1JFR0lTVEVSXzEzICAgIDEzDQo+ICsjZGVmaW5lIENQT19SRUdJU1RFUl8x
NCAgICAxNA0KPiArI2RlZmluZSBDUE9fUkVHSVNURVJfMTUgICAgMTUNCj4gKyNkZWZpbmUgQ1BP
X1JFR0lTVEVSXzE2ICAgIDE2DQo+ICsjZGVmaW5lIENQT19SRUdJU1RFUl8xNyAgICAxNw0KPiAr
I2RlZmluZSBDUE9fUkVHSVNURVJfMTggICAgMTgNCj4gKyNkZWZpbmUgQ1BPX1JFR0lTVEVSXzE5
ICAgIDE5DQo+ICsjZGVmaW5lIENQT19SRUdJU1RFUl8yMCAgICAyMA0KPiArI2RlZmluZSBDUE9f
UkVHSVNURVJfMjEgICAgMjENCj4gKyNkZWZpbmUgQ1BPX1JFR0lTVEVSXzIyICAgIDIyDQo+ICsj
ZGVmaW5lIENQT19SRUdJU1RFUl8yMyAgICAyMw0KPiArI2RlZmluZSBDUE9fUkVHSVNURVJfMjQg
ICAgMjQNCj4gKyNkZWZpbmUgQ1BPX1JFR0lTVEVSXzI1ICAgIDI1DQo+ICsjZGVmaW5lIENQT19S
RUdJU1RFUl8yNiAgICAyNg0KPiArI2RlZmluZSBDUE9fUkVHSVNURVJfMjcgICAgMjcNCj4gKyNk
ZWZpbmUgQ1BPX1JFR0lTVEVSXzI4ICAgIDI4DQo+ICsjZGVmaW5lIENQT19SRUdJU1RFUl8yOSAg
ICAyOQ0KPiArI2RlZmluZSBDUE9fUkVHSVNURVJfMzAgICAgMzANCj4gKyNkZWZpbmUgQ1BPX1JF
R0lTVEVSXzMxICAgIDMxDQo+ICAgDQo+ICAgDQo+ICAgdHlwZWRlZiBzdHJ1Y3QgVENTdGF0ZSBU
Q1N0YXRlOw0K
