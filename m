Received: from eggs.gnu.org ([208.118.235.92]:48188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gfACT-00031x-Bq
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gfACS-000891-G2
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:06:45 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Thu, 3 Jan 2019 21:06:24 +0000
Message-ID: <147a6548-59f4-fadc-479e-91d16cba218f@janustech.com>
References: <20190102110804.18155-1-lbloch@janustech.com>
	<20190102110804.18155-2-lbloch@janustech.com>
	<2e8c1c1c-6456-dcbe-8aa6-1fa09d153330@redhat.com>
In-Reply-To: <2e8c1c1c-6456-dcbe-8aa6-1fa09d153330@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBBEE1724C98234DB831BE68327C9D5D@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>

SGkgUGhpbCwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyEgVmVyeSB2YWxpZCBwb2ludHMuIEFs
bCB0YWtlbiwgZXhjZXB0IHRoZSBuYW1pbmcgDQooSSB0aGluayAicG93Ml9zaXplcy5oIiB3b3Vs
ZCBiZSBiZXR0ZXIgdGhhbiAibG9va3VwX3RhYmxlX3NpemVzLmgiLCANCm5vPykgYW5kIHRoZSAi
Z2VuZXJhdGVkIiBkaXJlY3RvcnkgLSBJIGFncmVlIHRoYXQgaXQncyBhIGdvb2QgaWRlYSwgYnV0
IA0KSSB0aGluayBpdCByZXF1aXJlcyBhIHNlcGFyYXRlIHBhdGNoIHdoaWNoIG1vdmVzIHRoZSBn
ZW5lcmF0ZWQgZmlsZXMgdGhlcmUuDQoNClJlZ2FyZHMsDQpMZW9uaWQuDQoNCk9uIDEvMy8xOSAx
MjozMyBQTSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IA0KPiBTbyBhcyAnbW9k
dWxlX2Jsb2NrLmgnLCB3aHkgbm90IHNpbXBseSBuYW1lIGl0ICdsb29rdXBfdGFibGVfc2l6ZXMu
aCc/DQo+IA0KPiBBY3R1YWxseSwgd2UgY291bGQgbW92ZSB0aG9zZSBpbiBhIGdlbmVyYXRlZC8g
c3ViZGlyZWN0b3J5LCB0aGlzDQo+IHdvdWxkIG1ha2UgdGhlIHNvdXJjZSBmaWxlIG1vcmUgZXhw
bGljaXQ6DQo+IA0KPiAjaW5jbHVkZSAiZ2VuZXJhdGVkL21vZHVsZV9ibG9jay5oIg0KPiANCj4g
S2V2aW4sIHdoYXQgZG8geW91IHRoaW5rPw0KPiANCg==
