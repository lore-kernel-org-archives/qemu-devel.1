Received: from eggs.gnu.org ([2001:4830:134:3::10]:41844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cTcFM-0006u7-E3
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cTcFJ-0005XM-8i
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:28:56 -0500
Received: from mta02.ornl.gov ([128.219.177.136]:35407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nutarojj@ornl.gov>) id 1cTcFJ-0005WB-2N
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:28:53 -0500
From: "Nutaro, James J." <nutarojj@ornl.gov>
Date: Tue, 17 Jan 2017 22:28:51 +0000
Message-ID: <6cc6c5187f3d453887c0f8f3ca8da616@EXCHCS32.ornl.gov>
References: <1483628868-10496-1-git-send-email-nutarojj@ornl.gov>
	<0f3d6652-e633-c02e-7234-0d5b885d31ea@redhat.com>
	<283fd6b709734ccdbeb6d217f8b32043@EXCHCS32.ornl.gov>
	<33a6f57d-4563-ec4a-f77f-1a15ca57c19d@redhat.com>
In-Reply-To: <33a6f57d-4563-ec4a-f77f-1a15ca57c19d@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6] qqq: module for synchronizing with a
 simulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

UGFvbG8sDQoNClRoZXJlIGFyZSBzZXZlcmFsIHN3aXRjaGVzIHRoYXQgbmVlZCB0byBiZSBzZXQg
Zm9yIHRoaXMgbW9kdWxlIHRvIHdvcmssIGFuZCBzbyAtIGluc3BpcmVkIGJ5IHlvdXIgY29tbWVu
dCAtIEkgZGVjaWRlZCB0byBhZGQgYSBjaGVjayBmb3IgdGhlIG5lY2Vzc2FyeSBzdXBwb3J0aW5n
IHN3aXRjaGVzIGJlZm9yZSBlbmFibGluZyB0aGUgbW9kdWxlLiBBbiBlcnJvciBtZXNzYWdlIGlz
IHByaW50ZWQgaWYgZXZlcnl0aGluZyBpcyBub3QgYXMgaXQgc2hvdWxkLiBJIHN1Ym1pdHRlZCB0
aGUgcGF0Y2ggYXMgdjcuDQoNClRoYW5rcyBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIHJldmlldyB0
aGlzLg0KDQpKaW0NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBhb2xvIEJv
bnppbmkgW21haWx0bzpwYm9uemluaUByZWRoYXQuY29tXSANClNlbnQ6IE1vbmRheSwgSmFudWFy
eSAwOSwgMjAxNyAxMjoxMCBQTQ0KVG86IE51dGFybywgSmFtZXMgSi47IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2Nl0gcXFxOiBtb2R1bGUgZm9yIHN5bmNocm9u
aXppbmcgd2l0aCBhIHNpbXVsYXRpb24NCg0KDQoNCk9uIDA5LzAxLzIwMTcgMTg6MDQsIE51dGFy
bywgSmFtZXMgSi4gd3JvdGU6DQo+IFRoYW5rcyBhZ2FpbiBQYW9sby4gV2hlbiBJIGNoYW5nZSB0
aGUgY29tbWFuZCBsaW5lIHN3aXRjaGVzLCBpcyBpdCBiZXN0IHRvIHN1Ym1pdCBhIHdob2xlIG5l
dyB2ZXJzaW9uIG9mIHRoZSBwYXRjaD8gT3IgaXMgdGhlcmUgYW5vdGhlciBtZXRob2QgZm9yIG1h
bmFnaW5nIHBhdGNoIHJldmlzaW9ucz8NCg0KWWVzLCBzdWJtaXQgYSBuZXcgdmVyc2lvbiwgdGhl
biBwdXQNCg0KdjYtPnY3OiBkaWQgdGhpcyBhbmQgdGhhdCBbUGFvbG9dDQoNCmF0IHRoZSBlbmQg
b2YgdGhlIGNvbW1pdCBtZXNzYWdlLCB3aGVyZSB0aGUgc3F1YXJlIGJyYWNrZXRzIG1lYW4NCiJz
dWdnZXN0ZWQgYnkuLi4iLg0KDQpUaGFua3MsDQoNClBhb2xvDQoNCj4gDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEJvbnppbmkgW21haWx0bzpwYm9uemluaUBy
ZWRoYXQuY29tXSANCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMDUsIDIwMTcgMTA6MjcgQU0N
Cj4gVG86IE51dGFybywgSmFtZXMgSi47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY2XSBxcXE6IG1vZHVsZSBmb3Igc3luY2hyb25pemluZyB3aXRoIGEgc2lt
dWxhdGlvbg0KPiANCj4gDQo+IA0KPiBPbiAwNS8wMS8yMDE3IDE2OjA3LCBKYW1lcyBKLiBOdXRh
cm8gd3JvdGU6DQo+PiBUaGlzIHBhdGNoIGFkZHMgYW4gaW50ZXJmYWNlIGZvciBwYWNpbmcgdGhl
IGV4ZWN1dGlvbiBvZiBRRU1VIHRvIG1hdGNoIGFuIGV4dGVybmFsDQo+PiBzaW11bGF0aW9uIGNs
b2NrLiBJdHMgYWltIGlzIHRvIHBlcm1pdCBRRU1VIHRvIGJlIHVzZWQgYXMgYSBtb2R1bGUgd2l0
aGluIGENCj4+IGxhcmdlciBzaW11bGF0aW9uIHN5c3RlbS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBKYW1lcyBKLiBOdXRhcm8gPG51dGFyb2pqQG9ybmwuZ292Pg0KPiANCj4gV2hhdCdzIHRoZSBk
aWZmZXJlbmNlIGJldHdlZW4gdjUgYW5kIHY2Pw0KPiANCj4+ICsoMikgRm9yayBRRU1VIHdpdGgg
dGhlIGFwcHJvcHJpYXRlIGNvbW1hbmQgbGluZSBhcmd1bWVudHMuDQo+PiArICAgIFRoZSAtcXFx
IHBhcnQgb2YgdGhlIGFyZ3VtZW50IHdpbGwgbG9vayBzb21ldGhpbmcgbGlrZQ0KPj4gKw0KPj4g
KyAgICAgICAtcXFxIHNvY2s9c29ja3NbMV0NCj4gDQo+IE5vIG5lZWQgZm9yIC1xcXEsIGp1c3Qg
bWFrZSBpdCAiLWljb3VudCBleHRjbG9jaz1GRCIuDQo+IA0KPiBQYW9sbw0KPiANCg0K
