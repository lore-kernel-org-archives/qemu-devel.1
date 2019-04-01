Received: from eggs.gnu.org ([209.51.188.92]:41706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elijahsh@mellanox.com>) id 1hAszl-0000yG-Q3
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elijahsh@mellanox.com>) id 1hAszj-0006xa-Fo
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:12:45 -0400
Received: from mail-ve1eur02on060e.outbound.protection.outlook.com
	([2a01:111:f400:fe06::60e]:40526
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elijahsh@mellanox.com>)
	id 1hAszi-0006wX-W3
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:12:43 -0400
From: Elijah Shakkour <elijahsh@mellanox.com>
Date: Mon, 1 Apr 2019 09:12:38 +0000
Message-ID: <AM6PR05MB6616E9F5EE3B3B531266B73DBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
References: <AM6PR05MB6616EE3D161F72A121F5FFEDBD5D0@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190324221319-mutt-send-email-mst@kernel.org>
	<AM6PR05MB66166ED74E2718150F0CBF62BD5F0@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190326085309-mutt-send-email-mst@kernel.org>
	<AM6PR05MB661611FE4DD494AF9EFB6B8ABD5F0@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190327064143.GP9149@xz-x1>
	<060498b58287775ce6bd7dd704f13b6d6e185f91.camel@oracle.com>
	<20190327084255.GR9149@xz-x1>
	<AM6PR05MB6616E9FDE038EA2B0665DD9CBD540@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401024710.GB8853@xz-x1>
In-Reply-To: <20190401024710.GB8853@xz-x1>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] QEMU and vIOMMU support for emulated VF
 passthrough to nested (L2) VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Knut Omang <knut.omang@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgWHUgPHBldGVy
eEByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDEsIDIwMTkgNTo0NyBBTQ0KPiBU
bzogRWxpamFoIFNoYWtrb3VyIDxlbGlqYWhzaEBtZWxsYW5veC5jb20+DQo+IENjOiBLbnV0IE9t
YW5nIDxrbnV0Lm9tYW5nQG9yYWNsZS5jb20+OyBNaWNoYWVsIFMuIFRzaXJraW4NCj4gPG1zdEBy
ZWRoYXQuY29tPjsgQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT47
DQo+IE1hcmNlbCBBcGZlbGJhdW0gPG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPjsgU3RlZmFu
IEhham5vY3ppDQo+IDxzdGVmYW5oYUBnbWFpbC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcN
Cj4gU3ViamVjdDogUmU6IFFFTVUgYW5kIHZJT01NVSBzdXBwb3J0IGZvciBlbXVsYXRlZCBWRiBw
YXNzdGhyb3VnaCB0bw0KPiBuZXN0ZWQgKEwyKSBWTQ0KPiANCj4gT24gU3VuLCBNYXIgMzEsIDIw
MTkgYXQgMTE6MTU6MDBBTSArMDAwMCwgRWxpamFoIFNoYWtrb3VyIHdyb3RlOg0KPiANCj4gWy4u
Ll0NCj4gDQo+ID4gSSBkaWRuJ3QgaGF2ZSBETUEgbm9yIE1NSU8gcmVhZC93cml0ZSB3b3JraW5n
IHdpdGggbXkgb2xkIGNvbW1hbmQNCj4gbGluZS4NCj4gPiBCdXQsIHdoZW4gSSByZW1vdmVkIGFs
bCBDUFUgZmxhZ3MgYW5kIG9ubHkgcHJvdmlkZWQgIi1jcHUgaG9zdCIsIEkgc2VlIHRoYXQNCj4g
TU1JTyB3b3Jrcy4NCj4gPiBTdGlsbCwgRE1BIHJlYWQvd3JpdGUgZnJvbSBlbXVsYXRlZCBkZXZp
Y2UgZG9lc24ndCB3b3JrIGZvciBWRi4gRm9yDQo+IGV4YW1wbGU6DQo+ID4gRHJpdmVyIHByb3Zp
ZGVzIG1lIGEgYnVmZmVyIHBvaW50ZXIgdGhyb3VnaCBNTUlPIHdyaXRlLCB0aGlzIGFkZHJlc3MN
Cj4gKHBvaW50ZXIpIGlzIEdQQSBvZiBMMiwgYW5kIHdoZW4gSSB0cnkgdG8gY2FsbCBwY2lfZG1h
X3JlYWQoKSB3aXRoIHRoaXMgYWRkcmVzcw0KPiBJIGdldDoNCj4gPiAiDQo+ID4gVW5hc3NpZ25l
ZCBtZW0gcmVhZCAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gIg0KPiANCj4gSSBkb24ndCBrbm93IHdo
ZXJlIHRoaXMgZXJyb3IgbG9nIHdhcyBkdW1wZWQgYnV0IGlmIGl0J3MgZHVyaW5nIERNQSB0aGVu
IEkNCj4gYWdyZWUgaXQgY2FuIHByb2JhYmx5IGJlIHJlbGF0ZWQgdG8gdklPTU1VLg0KPiANCg0K
VGhpcyBsb2cgaXMgZHVtcGVkIGZyb206DQptZW1vcnkuYzogdW5hc3NpZ25lZF9tZW1fcmVhZCgp
DQoNCj4gPiBBcyBJIHNhaWQsIG15IHByb2JsZW0gbm93IGlzIGluIHRyYW5zbGF0aW9uIG9mIEwy
IEdQQSBwcm92aWRlZCBieSBkcml2ZXIsDQo+IHdoZW4gSSBjYWxsIERNQSByZWFkL3dyaXRlIGZv
ciB0aGlzIGFkZHJlc3MgZnJvbSBWRi4NCj4gPiBBbnkgaW5zaWdodHM/DQo+IA0KPiBJIGp1c3Qg
bm90aWNlZCB0aGF0IHlvdSB3ZXJlIHVzaW5nIFFFTVUgMi4xMiBbMV0uICBJZiB0aGF0J3MgdGhl
IGNhc2UsIHBsZWFzZQ0KPiByZWJhc2UgdG8gdGhlIGxhdGVzdCBRRU1VLCBhdCBsZWFzdCA+PTMu
MCBiZWNhdXNlIHRoZXJlJ3MgbWFqb3IgcmVmYWN0b3Igb2YNCj4gdGhlIHNoYWRvdyBsb2dpYyBk
dXJpbmcgMy4wIGRldmVsIGN5Y2xlIEFGQUlDVC4NCj4gDQoNClJlYmFzZWQgdG8gUUVNVSAzLjEN
Ck5vdyBJIHNlZSB0aGUgYWRkcmVzcyBJJ20gdHJ5aW5nIHRvIHJlYWQgZnJvbSBpbiBsb2cgYnV0
IHN0aWxsIHNhbWUgZXJyb3I6DQoiDQpVbmFzc2lnbmVkIG1lbSByZWFkIDAwMDAwMDAwZjA0ODEw
MDANCiINCldoYXQgZG8geW91IHN1Z2dlc3Q/DQoNCj4gPiA+ID4gPiA+ID4gPiBJJ20gdXNpbmcg
S251dCBPbWFuZyBTUklPViBwYXRjaGVzIHJlYmFzZWQgdG8gUUVNVSB2Mi4xMi4NCj4gDQo+IFsx
XQ0KPiANCj4gUmVnYXJkcywNCj4gDQo+IC0tDQo+IFBldGVyIFh1DQo=
