Received: from eggs.gnu.org ([2001:4830:134:3::10]:40136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1fIxGh-0007WL-Gz
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1fIxGd-0006PD-HU
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:19:03 -0400
Received: from mail-bn3nam01on0127.outbound.protection.outlook.com
	([104.47.33.127]:17472
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1fIxGc-0006Oo-VP
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:18:59 -0400
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Wed, 16 May 2018 14:18:55 +0000
Message-ID: <DM5PR21MB01706DBB47ABA7A6EEB6AE9FB6920@DM5PR21MB0170.namprd21.prod.outlook.com>
References: <1526384258-3581-1-git-send-email-lpetrut@cloudbasesolutions.com>
	<b1f9836f-96ee-d782-1882-51c97e21d252@redhat.com>
	<9ED401B4-3DF6-4BC8-9D38-14C78C9D1A66@cloudbasesolutions.com>
	<a7f0b9ab-3c8b-87d1-9f63-e82b13f66029@redhat.com>
In-Reply-To: <a7f0b9ab-3c8b-87d1-9f63-e82b13f66029@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] WHPX Add signature CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, apilotti <apilotti@cloudbasesolutions.com>
Cc: "petrutlucian94@gmail.com" <petrutlucian94@gmail.com>, Lucian Petrut <lpetrut@cloudbasesolutions.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

SGV5IFBhb2xvLA0KDQpJIGFncmVlIHRoYXQgaW4gdGhlIGZ1dHVyZSBpdCB3b3VsZCBiZSBncmVh
dCBpZiB0aGUgV2luZG93cyBIeXBlcnZpc29yIFBsYXRmb3JtIHN1cHBvcnRlZCB0aGF0IGFuZCBp
ZiB0aGF0IGhhcHBlbnMgdGhlcmUgaXMgbm8gcmVhc29uIHRvIGRpZmZlcmVudGlhdGUgdGhlIHR3
by4NCg0KSG93ZXZlciwgdG9kYXkgV0hQWCBhY3R1YWxseSBkb2VzbuKAmXQgc3VwcG9ydCBhbnkg
b2YgdGhlIHN5bnRoZXRpYyBlbmxpZ2h0ZW5tZW50cyB0aGF0IEh5cGVyLVYgZG9lcy4gV2UgYXJl
IHJlYWxseSB0cnlpbmcgdG8gbWFrZSB0aGUgV2luZG93cyBIeXBlcnZpc29yIFBsYXRmb3JtIGEg
Z2VuZXJpYyBoeXBlcnZpc29yIHdoZXJlIGFzIEh5cGVyLVYgaXMgYSBzcGVjaWZpYyBpbXBsZW1l
bnRhdGlvbiBvbiB0b3Agb2YgdGhhdCBoeXBlcnZpc29yIChhbmQgUUVNVSBpcyBhbm90aGVyIHN1
Y2ggaW1wbGVtZW50YXRpb24pLiBGb3IgZXhhbXBsZSwgVk1CdXMgd2FzIG1lbnRpb25lZCBidXQg
YXMgaXQgc3RhbmRzIHRvZGF5LCBWTUJ1cyBpcyBub3Qgc3VwcG9ydGVkIGluIFdIUFggZHVlIHRv
IGxhY2sgb2Ygc3VwcG9ydCBmb3IgaHlwZXJjYWxscy4gQWRkaXRpb25hbGx5LCB0aW1lciBlbmxp
Z2h0ZW5tZW50cyB0aGF0IHlvdSBtZW50aW9uZWQgd291bGQgbm90IGJlIHN1cHBvcnRlZCB0aHJv
dWdoIHN5bnRoZXRpYyBwYXRocyBhbmQgaW5zdGVhZCBydW4gZW11bGF0ZWQgYXMgZGV2aWNlcyAo
aHBldCBldGMuKS4NCg0KSSBob3BlIHRoaXMgYWRkcyBzb21lIGNsYXJpdHkgaGVyZSBmb3Igd2h5
IFdIUFggZG9lc27igJl0IGltcGxlbWVudCBoeXBlcnYtcHJvdG8uaCBhcyBIeXBlci1WICE9IFdp
bmRvd3MgSHlwZXJ2aXNvciBQbGF0Zm9ybSBpbiBtYW55IGFzcGVjdHMuIFBsZWFzZSBsZXQgbWUg
a25vdyBpZiB0aGVyZSBpcyBhbnl0aGluZyBlbHNlIEkgY2FuIGV4cGxhaW4gdG8gaGVscCBjbGFy
aWZ5IHRoZSB0d28uDQoNClRoYW5rcywNCkp1c3Rpbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgTWF5IDE2LCAyMDE4IDEyOjM1IEFNDQo+IFRvOiBhcGlsb3R0aSA8YXBp
bG90dGlAY2xvdWRiYXNlc29sdXRpb25zLmNvbT4NCj4gQ2M6IHBldHJ1dGx1Y2lhbjk0QGdtYWls
LmNvbTsgTHVjaWFuIFBldHJ1dA0KPiA8bHBldHJ1dEBjbG91ZGJhc2Vzb2x1dGlvbnMuY29tPjsg
RWR1YXJkbyBIYWJrb3N0DQo+IDxlaGFia29zdEByZWRoYXQuY29tPjsgb3BlbiBsaXN0OkFsbCBw
YXRjaGVzIENDIGhlcmUgPHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc+OyBKdXN0aW4gVGVycnkg
KFZNKSA8anV0ZXJyeUBtaWNyb3NvZnQuY29tPjsgUmljaGFyZA0KPiBIZW5kZXJzb24gPHJ0aEB0
d2lkZGxlLm5ldD4NCj4gU3ViamVjdDogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0hdIFdIUFggQWRk
IHNpZ25hdHVyZSBDUFVJRA0KPiANCj4gT24gMTYvMDUvMjAxOCAwMTo1NSwgQWxlc3NhbmRybyBQ
aWxvdHRpIHdyb3RlOg0KPiA+IEhpIFBhb2xvLA0KPiA+DQo+ID4gVGhlIG1haW4gcmVhc29uIGZv
ciBkaWZmZXJlbnQgc2lnbmF0dXJlcyBpcyB0byBhbGxvdyBndWVzdCB3b3JrbG9hZHMNCj4gPiB0
byBiZSBhd2FyZSBvZiB0aGUgZGlmZmVyZW5jZXMgYmV0d2VlbiB0aGUgdHdvIHBsYXRmb3JtcyAo
ZWcgVmlydElPIHZzDQo+ID4gVk1CdXMpLg0KPiANCj4gV2h5IGRvZXMgaXQgbWF0dGVyPyAgQ1BV
SUQgdGVsbHMgeW91IGFib3V0IHRoZSBlbmxpZ2h0ZW5tZW50cyB0aGF0IHRoZQ0KPiBoeXBlcnZp
c29yIHByb3ZpZGVzLCBub3QgdGhlIGF2YWlsYWJpbGl0eSBvZiB0aGUgVk1CdXMuDQo+IA0KPiBW
TUJ1cyByZXF1aXJlcyBzb21lIG9mIHRoZSBlbmxpZ2h0ZW5tZW50cywgbW9zdGx5IHJlbGF0ZWQg
dG8gdGhlIHN5bnRoZXRpYw0KPiBpbnRlcnJ1cHQgY29udHJvbGxlcnMsIGJ1dCB0aGUgb3Bwb3Np
dGUgaXMgbm90IHRydWUtLS15b3UgY2FuIGhhdmUNCj4gZW5saWdodGVubWVudHMgd2l0aG91dCBW
TUJ1cywgYW5kIGluIGZhY3QgeW91IHByb2JhYmx5IHdhbnQgV0hQWCB0bw0KPiBlbmFibGUgdGhl
IHJlbGF4ZWQgdGltaW5nIGVubGlnaHRlbm1lbnQuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBQYW9s
bw0K
