Received: from eggs.gnu.org ([2001:4830:134:3::10]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7cR2-0007WC-9y
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7cQz-00018K-4l
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:18:36 -0400
Received: from smtp.h3c.com ([60.191.123.56]:55713 helo=h3cmg01-ex.h3c.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7cQy-000151-ED
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:18:33 -0400
From: Changlimin <changlimin@h3c.com>
Date: Thu, 26 Oct 2017 07:18:01 +0000
Message-ID: <BC29A004BA570342A4CC0044A3845572CFCE5D44@H3CMLB12-EX.srv.huawei-3com.com>
References: <BC29A004BA570342A4CC0044A3845572CFCE5592@H3CMLB12-EX.srv.huawei-3com.com>
	<20171025133115.GA23458@lemon>
	<BC29A004BA570342A4CC0044A3845572CFCE5962@H3CMLB12-EX.srv.huawei-3com.com>
	<f10f73b8-6b6b-a30e-a147-b7fcaa28b182@redhat.com>
In-Reply-To: <f10f73b8-6b6b-a30e-a147-b7fcaa28b182@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'locking' when disable image locking with option locking=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

SWYgdGhlIHFjb3cyIGZpbGUgaXMgY3JlYXRlZCB3aXRoIHByZWFsbG9jYXRpb249ZnVsbCwgSSB0
aGluayBtZXRhZGF0YSB3aWxsIG5vdCBjb3JydXB0IHdoZW4gaXQgaXMgc2hhcmVkIGJldHdlZW4g
dHdvIHZtcz8gU25hcHNob3QgaXMgbm90IHJlcXVpcmVkLiANCg0KSXMgdGhpcyByaWdodD8NCg0K
QlINCkNoYW5nIGxpbWluDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXgg
UmVpdHogW21haWx0bzptcmVpdHpAcmVkaGF0LmNvbV0gDQpTZW50OiBUaHVyc2RheSwgT2N0b2Jl
ciAyNiwgMjAxNyAzOjEyIFBNDQpUbzogY2hhbmdsaW1pbiAwMDE0OCAoQ2xvdWQpOyBGYW0gWmhl
bmcNCkNjOiBxZW11LWRldmVsQG5vbmdudS5vcmcNClN1YmplY3Q6IFJlOiBbUWVtdS1kZXZlbF0g
QmxvY2sgZm9ybWF0ICdyYXcnIGRvZXMgbm90IHN1cHBvcnQgdGhlIG9wdGlvbiAnbG9ja2luZycg
d2hlbiBkaXNhYmxlIGltYWdlIGxvY2tpbmcgd2l0aCBvcHRpb24gbG9ja2luZz1vZmYNCg0KT24g
MjAxNy0xMC0yNiAwMzowNiwgQ2hhbmdsaW1pbiB3cm90ZToNCj4gc2hhcmUtcnc9b24gaXMgZ29v
ZCBmb3IgcmF3IGZvcm1hdCBmaWxlLCBidXQgYmFkIGZvciBxY293MiBmb3JtYXQgZmlsZToNCj4g
DQo+IEZhaWxlZCB0byBnZXQgIndyaXRlIiBsb2NrDQo+IElzIGFub3RoZXIgcHJvY2VzcyB1c2lu
ZyB0aGUgaW1hZ2U/DQo+IA0KPiBJcyB0aGlzIGludGVudGVkPw0KDQpZZXMsIGJlY2F1c2UgeW91
IGNhbiBuZXZlciBzaGFyZSBxY293MiBpbWFnZSBmaWxlcyBiZXR3ZWVuIFZNcy4gIFRoZQ0KcWNv
dzIgZm9ybWF0IGl0c2VsZiBkb2VzIG5vdCBzdXBwb3J0IHRoaXMsIGFzIGl0IG1heSBsZWFkIHRv
IG1ldGFkYXRhIGNvcnJ1cHRpb24uDQoNCk1heA0KDQo=
