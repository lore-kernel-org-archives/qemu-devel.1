Received: from eggs.gnu.org ([2001:4830:134:3::10]:57209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d9ifA-0006Em-61
	for qemu-devel@nongnu.org; Sat, 13 May 2017 21:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d9if5-00033n-Aj
	for qemu-devel@nongnu.org; Sat, 13 May 2017 21:49:36 -0400
Received: from mail-he1eur01on0118.outbound.protection.outlook.com
	([104.47.0.118]:40688
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1d9if4-00031A-K2
	for qemu-devel@nongnu.org; Sat, 13 May 2017 21:49:31 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Sun, 14 May 2017 01:49:27 +0000
Message-ID: <VI1PR0601MB247961D043BA32DCA5F045FF9CE00@VI1PR0601MB2479.eurprd06.prod.outlook.com>
References: <VI1PR0601MB2479748C35B3C9F914896AEA9CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479503D42E1CD00B929380B9CE30@VI1PR0601MB2479.eurprd06.prod.outlook.com>
In-Reply-To: <VI1PR0601MB2479503D42E1CD00B929380B9CE30@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] slirp: question about using SMB on windows host
 with linux guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

PkkgYW0gdHJ5aW5nIHRvIHNoYXJlcyBmaWxlcyBiZXR3ZWVuIFdpbmRvd3MgaG9zdCBhbmQgTGlu
dXggZ3Vlc3QgdXNpbmcgc2xpcnDigJlzIGJ1aWx0LWluIFNNQiBzZXJ2ZXIuDQo+SSBzdGFydCBR
RU1VIDIuOS4wIHVzaW5nIHRoZSBmb2xsb3dpbmc6DQo+DQo+QzpcUHJvZ3JhbSBGaWxlc1xxZW11
PnFlbXUtc3lzdGVtLWkzODYuZXhlIC1yZWFkY29uZmlnIFxVc2Vyc1xtZm9ubmVtYW5uXHFlbXUu
Y2ZnIC1uZXQgbmljIC1uZXQgdXNlcixzbWI9XFVzZXJzXG1mb25uZW1hbm5cc21iDQo+DQo+SSB0
aGVuIHRyeSB0byBtb3VudCB0aGUgU01CIHNoYXJlIGZpcnN0IHdpdGggMTAuMC4yLjQ6DQo+DQo+
cm9vdEBxZW11On4jIG1vdW50IC10IGNpZnMgLy8xMC4wLjIuNC9Vc2Vycy9tZm9ubmVtYW5uL3Nt
YiB0bXAgLW8gdXNlcj1tZm9ubmVtYW5uDQo+ICAgICAgICAgICAgICAgICAgICBQYXNzd29yZDoN
Cj4gICAgICAgICAgICAgICAgICAgICBDSUZTIFZGUzogRXJyb3IgY29ubmVjdGluZyB0byBJUHY0
IHNvY2tldC4gQWJvcnRpbmcgb3BlcmF0aW9uDQo+ICAgICAgICAgICAgICAgICAgICAgQ0lGUyBW
RlM6IGNpZnNfbW91bnQgZmFpbGVkIHcvcmV0dXJuIGNvZGUgPSAtMTEzDQo+ICAgICAgICAgICAg
ICAgICAgICBtb3VudCBlcnJvciAxMTMgPSBObyByb3V0ZSB0byBob3N0DQo+ICAgICAgICAgICAg
ICAgICAgICBtb3VudDogbW91bnQuY2lmcyBmYWlsZWQgd2l0aCBzdGF0dXMgLTENCj4NCj5BbmQg
dGhlbiB3aXRoIDEwLjAuMi4yOg0KPg0KPnJvb3RAcWVtdTp+IyBtb3VudCAtdCBjaWZzIC8vMTAu
MC4yLjIvVXNlcnMvbWZvbm5lbWFubi9zbWIgdG1wIC1vIHVzZXI9bWZvbm5lbWFubg0KPiAgICAg
ICAgICAgICAgICAgICAgUGFzc3dvcmQ6DQo+ICAgICAgICAgICAgICAgICAgICBDSUZTIFZGUzog
VW5rbm93biBSRkMgMTAwMiBmcmFtZQ0KPg0KPiAgICAgICAgICAgICAgICAgICAgIENJRlMgVkZT
OiBTZW5kIGVycm9yIGluIFNlc3NTZXR1cCA9IC0xMw0KPiAgICAgICAgICAgICAgICAgICAgIENJ
RlMgVkZTOiBjaWZzX21vdW50IGZhaWxlZCB3L3JldHVybiBjb2RlID0gLTEzDQo+ICAgICAgICAg
ICAgICAgICAgICBtb3VudCBlcnJvciAxMyA9IFBlcm1pc3Npb24gZGVuaWVkDQo+ICAgICAgICAg
ICAgICAgICAgICBtb3VudDogbW91bnQuY2lmcyBmYWlsZWQgd2l0aCBzdGF0dXMgLTENCj4NCj5S
ZWdhcmRpbmcgUkZDIDEwMDIgZnJhbWUsIEkgc2VlIHRoZSBmb2xsb3dpbmcgd2hlbiB1c2luZyDi
gJxkbWVzZ+KAnToNCj4NCj5DSUZTIFZGUzogVW5rbm93biBSRkMgMTAwMiBmcmFtZQ0KPiAgICAg
ICAgICAgICAgICAgICAgIFJlY2VpdmVkIERhdGE6IDogZHVtcCBvZiAzNiBieXRlcyBvZiBkYXRh
IGF0IDB4ZjcxNDAwYzANCj4NCj4gICAgICAgICAgICAgICAgICAgICAwMDAwMDA4ZCA1Nzc3MDA2
NCA2ZTAwNjkwMCA2ZjAwNjQwMCAuIC4gLiAuIGQgLiB3IFcgLiBpIC4gbiAuIGQgLiBvDQo+ICAg
ICAgICAgICAgICAgICAgICAgNzMwMDc3MDAgMzEwMDIwMDAgMjAwMDMwMDAgNzIwMDUwMDAgLiB3
IC4gcyAuICAgLiAxIC4gMCAuICAgLiBQIC4gcg0KPiAgICAgICAgICAgICAgICAgICAgIDIwMDA2
ZjAwIC4gbyAuDQoNCkkganVzdCByZXRyaWVkIHRyaWVkIGJvdGggYWdhaW4gdXNpbmcgV2luZG93
cyA3IFByb2Zlc3Npb25hbCBhbmQgV2luZG93cyAxMCBQcm9mZXNzaW9uYWwuDQpJIGFsc28gdHJp
ZWQgdXNpbmcgUUVNVSAyLjggYXMgd2VsbC4NCk5vdCBzdXJlIHdoYXQgZWxzZSB0byB0cnkuDQoN
Cg==
