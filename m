Received: from eggs.gnu.org ([2001:4830:134:3::10]:52852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQvSY-0007zL-5w
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQvSV-0001Dr-0T
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:23:26 -0500
Received: from [45.249.212.188] (port=2443 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQvSI-00014z-M7
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:23:22 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 10 Jan 2017 12:17:48 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA182B4A@DGGEMA505-MBX.china.huawei.com>
References: <58733617.3050503@huawei.com>
	<20170109134310.GE30228@stefanha-x1.localdomain>
	<20170109162504.GH29989@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182982@DGGEMA505-MBX.china.huawei.com>
	<20170110100355.GD27720@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182ADA@DGGEMA505-MBX.china.huawei.com>
	<20170110120354.GH27720@redhat.com>
In-Reply-To: <20170110120354.GH27720@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Question about add AF_ALG backend for virtio-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, longpeng <longpeng2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU-DEV <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>

Pg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIE1vbiwgSmFuIDA5LCAy
MDE3IGF0IDAxOjQzOjEwUE0gKzAwMDAsIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4gPiA+ID4g
PiA+IE9uIE1vbiwgSmFuIDA5LCAyMDE3IGF0IDAzOjA0OjU1UE0gKzA4MDAsIExvbmdwZW5nIChN
aWtlKSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gSSdtIG9uZSBvZiBHb25nbGVpJ3MgdmlydGlvLWNy
eXB0byBwcm9qZWN0IG1lbWJlcnMsIGFuZCB3ZSBwbGFuIHRvDQo+IGFkZCBhDQo+ID4gPiA+ID4g
QUZfQUxHDQo+ID4gPiA+ID4gPiA+IGJhY2tlbmQgZm9yIHZpcnRpby1jcnlwdG8odGhlcmUncyBv
bmx5IGJ1aWx0aW4tYmFja2VuZCBjdXJyZW50bHkpLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiBJIGZvdW5kIHRoYXQgQ2F0YWxpbiwgUGFvbG8gYW5kIFN0ZWZhbiBoYWQgZGlzY3Vzc2Vk
IGFib3V0IHRoaXMgaW4NCj4gMjAxNQ0KPiA+ID4gPiA+ID4gPiAoaHR0cDovL3d3dy5zcGluaWNz
Lm5ldC9saXN0cy9rdm0vbXNnMTE1NDU3Lmh0bWwpLCBidXQgaXQgc2VlbXMNCj4gdGhhdA0KPiA+
ID4gPiA+IENhdGFsaW4NCj4gPiA+ID4gPiA+ID4gZGlkbid0IGRvIGl0LCBzbyBJJ20gY29uZnVz
ZSBhYm91dCB3ZXRoZXIgaXQgaXMgbmVlZCB0byBhZGQgYSBBRl9BTEcNCj4gPiA+ID4gPiBiYWNr
ZW5kLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBEbyB5b3UgaGF2ZSBhbnkgc3VnZ2Vz
dGlvbj8gVGhhbmtzIDopDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSSBoYXZlIG5vIG9iamVj
dGlvbnMgdG8gYW4gQUZfQUxHIGJhY2tlbmQgaW4gUUVNVS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IFJhdGhlciB0aGFuIGRvIGFub3RoZXIgYmFja2VuZCBmb3IgdmlydGlvLWNyeXB0bywgSU1ITywg
d2Ugc2hvdWxkIGhhdmUNCj4gPiA+ID4gPiBhbiBBRl9BTEcgaW1wbCBvZiB0aGUgY3J5cHRvLyBB
UElzLiBUaGF0IHdheSBhbnkgcG90ZW50aWFsIHBlcmZvcm1hbmNlDQo+ID4gPiA+ID4gYmVuZWZp
dHMgd2lsbCBlbmhhbmNlIG91ciBMVUtTIGVuY3J5cHRpb24gY29kZSB0b28uDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gQWNjb3JkaW5nIHRvIHRoZSBjdXJyZW50bHkgc2NoZW1hcyBvZiBjcnlwdG8vIEFQ
SXMsIHdlIGNhbid0IGNob29zZSB0aGUNCj4gPiA+ID4gc3BlY2lmaWMgYmFja2VuZCBkeW5hbWlj
YWxseS4gVGhpcyBpcyBhIGxpbWl0YXRpb24gZm9yIHZpcnRpby1jcnlwdG8NCj4gPiA+ID4gZGV2
aWNlIEkgdGhpbmsuDQo+ID4gPg0KPiA+ID4gRG8gd2UgcmVhbGx5IG5lZWQgdG8gYmUgYWJsZSB0
byBjaG9vc2UgdGhlIGJhY2tlbmQgZXhwbGljaXRseS4gSWYgdGhlIEFGX0FMRw0KPiA+ID4gYmFj
a2VuZCBpcyBmYXN0ZXIsIHdoeSB3b3VsZCB5b3Ugc2ltcGx5IG5vdCB1c2UgdGhhdCBhdXRvbWF0
aWNhbGx5IGlmIGl0IGlzDQo+ID4gPiBhdmFpbGFibGUuDQo+ID4NCj4gPiBDYW4gd2UgcmVhbGl6
ZSB0aGUgcHVycG9zZSBiYXNlZCBvbiB0aGUgY3J5cHRvLyBBUElzPyBJSVVDIHRoZSBjcnlwdG8N
Cj4gPiBzdWJzeXN0ZW0gY2hvb3NlcyBhIGJhY2tlbmQgZHVyaW5nIHRoZSBidWlsZGluZyBhY2Nv
cmRpbmcgdG8gdGhlIHNwZWNpZmljDQo+IHByaW9yaXR5LA0KPiA+IG5ldHRsZSA+IGdjcnlwdCA+
IGNpcGhlci1idWlsdGluLg0KPiA+DQo+ID4gSWYgd2UgYWRkIGFuIEFGX0FMRyBpbXBsZW1lbnRh
dGlvbiBmb3IgY3J5cHRvIHN1YnN5c3RlbSwgc2hhbGwgd2Ugc2V0IGl0DQo+ID4gYXMgdGhlIGhp
Z2hlc3QgcHJpb3JpdHk/IElmIHNvLCBvdGhlciBiYWNrZW5kcyB3b24ndCBiZSB1c2VkIHNpbmNl
IEFGX0FMRw0KPiA+IGlzIGFsd2F5cyBhdmFpbGFibGUuIElmIG5vdCwgaG93IGNhbiB3ZSB1c2Ug
QUZfQUxHIGJhY2tlbmQgZm9yIGNyeXB0by8gQVBJPw0KPiA+DQo+ID4gUGxlYXNlIGNvcnJlY3Qg
bWUgaWYgSSdtIG1pc3Npbmcgc29tZXRoaW5nLg0KPiANCj4gV2hpbGUgQUZfQUxHIGhhcyBiZWVu
IGF2YWlsYWJsZSBmb3IgYSB3aGlsZSwgbm90IGFsbCBmZWF0dXJlcyBoYXZlLiBGb3INCj4gZXhh
bXBsZSBBRUFEIHN1cHBvcnQgd2FzIG9ubHkgYWRkZWQgaW4ga2VybmVsIDQuMQ0KPiANCk9LLg0K
DQo+IFNvIGlmIHdlIGhhZCBBRl9BTEcgaW4gUUVNVSwgd2Ugd291bGQgaGF2ZSB0byBoYXZlIGEg
c3RhY2tlZCBpbXBsLCB3aGVyZQ0KPiB3ZSB0cnkgQUZfQUxHIGFuZCB0aGVuIGZhbGxiYWNrIHRv
IHRoZSBjdXJyZW50IGNvZGUgd2hlbiBRRU1VIHJ1bnMgb24gYQ0KPiBrZXJuZWwgbGFja2luZyB0
aGUgZmVhdHVyZSBuZWVkZWQuDQo+IA0KSXQgbWFrZXMgc2Vuc2UgdGhvdWdoIHRoZSBpbXBsZW1l
bnRhdGlvbiB3aWxsIGJlIG1vcmUgY29tcGxpY2F0ZQ0Kc2luY2UgdGhlIGNvZGUgc2hvdWxkIGlk
ZW50aWZ5IHRoZSBkaWZmZXJlbnQgZXJyb3IgY29kZXMgYXJlIHJldHVybmVkDQpieSBBRl9BTEcg
QVBJcy4NCg0KPiBXZSBjb3VsZCBwb3RlbnRpYWxseSBhbHNvIGhhdmUgYSBnbG9iYWwgYXJnIHRv
IHN3aXRjaCBiYWNrZW5kcyBlLmcuDQo+IA0KPiAgLWNyeXB0by1iYWNrZW5kIFthZmFsZ3xidWls
dGluXQ0KPiANClNvIHRoZSBiYWNrZW5kIGhlcmUgaXMgbm90IHRoZSBjcnlwdG9kZXYgYmFja2Vu
ZD8NCg0KVGhhbmtzLA0KLUdvbmdsZWkNCg==
