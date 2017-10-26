Received: from eggs.gnu.org ([2001:4830:134:3::10]:37209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1e7cD3-0000Y5-9W
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1e7cD0-0001WK-0c
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:04:09 -0400
From: "Valluri, Amarnath" <amarnath.valluri@intel.com>
Date: Thu, 26 Oct 2017 07:03:58 +0000
Message-ID: <1509001479.3135.19.camel@intel.com>
References: <20171024122045.30072-1-f4bug@amsat.org>
	<20171024122045.30072-5-f4bug@amsat.org>
In-Reply-To: <20171024122045.30072-5-f4bug@amsat.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6817469F645DD24685CB257BEB260746@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/4] vl: remove unnecessary #ifdef
 CONFIG_TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "f4bug@amsat.org" <f4bug@amsat.org>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>

T24gVHVlLCAyMDE3LTEwLTI0IGF0IDA5OjIwIC0wMzAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gYSBzdHViIGlzIG5vdyBwcm92aWRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxmNGJ1Z0BhbXNhdC5vcmc+DQo+IFRlc3RlZC1ieTog
UmljaGFyZCBXLk0uIEpvbmVzIDxyam9uZXNAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFt
YXJuYXRoIFZhbGx1cmkgPGFtYXJuYXRoLnZhbGx1cmlAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiDC
oHZsLmMgfCAyIC0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+IFJldmll
d2VkLWJ5Og0KPiBkaWZmIC0tZ2l0IGEvdmwuYyBiL3ZsLmMNCj4gaW5kZXggMDcyMzgzNWJiZi4u
ZWMyOTkwOTlmZiAxMDA2NDQNCj4gLS0tIGEvdmwuYw0KPiArKysgYi92bC5jDQo+IEBAIC00NjI0
LDExICs0NjI0LDkgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjaGFyICoqZW52
cCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgxKTsNCj4gwqDCoMKgwqDCoH0NCj4gwqANCj4g
LSNpZmRlZiBDT05GSUdfVFBNDQo+IMKgwqDCoMKgwqBpZiAodHBtX2luaXQoKSA8IDApIHsNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgxKTsNCj4gwqDCoMKgwqDCoH0NCj4gLSNlbmRpZg0KPiDC
oA0KPiDCoMKgwqDCoMKgLyogaW5pdCB0aGUgYmx1ZXRvb3RoIHdvcmxkICovDQo+IMKgwqDCoMKg
wqBpZiAoZm9yZWFjaF9kZXZpY2VfY29uZmlnKERFVl9CVCwgYnRfcGFyc2UpKQ==
