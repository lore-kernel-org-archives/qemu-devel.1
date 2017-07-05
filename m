Received: from eggs.gnu.org ([2001:4830:134:3::10]:46004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dSeW8-00048J-BB
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dSeW3-0007DW-B9
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:32 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 5 Jul 2017 07:14:20 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D25AEB@SHSMSX101.ccr.corp.intel.com>
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<AM5PR0401MB2545AFD256A96420ACC44CD89ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<14c83c14-1e7e-f142-77b0-fa8c873e2d41@redhat.com>
	<AM5PR0401MB2545C0E76C4BE6F82FE376D09ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<6f22079e-4b4b-6476-77be-51ec83104c0d@redhat.com>
	<AM5PR0401MB25459FDAA8C9AFA52503AAE99AC40@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<589f1642-775c-4805-74ac-bf67eb504733@arm.com>
In-Reply-To: <589f1642-775c-4805-74ac-bf67eb504733@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Auger Eric <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "wei@redhat.com" <wei@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgW21haWx0bzpqZWFuLXBoaWxpcHBlLmJydWNr
ZXJAYXJtLmNvbV0NCj4gU2VudDogTW9uZGF5LCBKdW5lIDE5LCAyMDE3IDY6MTUgUE0NCj4gDQo+
IE9uIDE5LzA2LzE3IDA4OjU0LCBCaGFyYXQgQmh1c2hhbiB3cm90ZToNCj4gPiBIaSBFcmljLA0K
PiA+DQo+ID4gSSBzdGFydGVkIGFkZGVkIHJlcGxheSBpbiB2aXJ0aW8taW9tbXUgYW5kIGNhbWUg
YWNyb3NzIGhvdyBNU0kgaW50ZXJydXB0cw0KPiB3aXRoIHdvcmsgd2l0aCBWRklPLg0KPiA+IEkg
dW5kZXJzdGFuZCB0aGF0IG9uIGludGVsIHRoaXMgd29ya3MgZGlmZmVyZW50bHkgYnV0IHZzbW11
IHdpbGwgaGF2ZSBzYW1lDQo+IHJlcXVpcmVtZW50Lg0KPiA+IGt2bS1tc2ktaXJxLXJvdXRlIGFy
ZSBhZGRlZCB1c2luZyB0aGUgbXNpLWFkZHJlc3MgdG8gYmUgdHJhbnNsYXRlZCBieQ0KPiB2aW9t
bXUgYW5kIG5vdCB0aGUgZmluYWwgdHJhbnNsYXRlZCBhZGRyZXNzLg0KPiA+IFdoaWxlIGN1cnJl
bnRseSB0aGUgaXJxZmQgZnJhbWV3b3JrIGRvZXMgbm90IGtub3cgYWJvdXQgZW11bGF0ZWQNCj4g
aW9tbXVzICh2aXJ0aW8taW9tbXUsIHZzbW11djMvdmludGVsLWlvbW11KS4NCj4gPiBTbyBpbiBt
eSB2aWV3IHdlIGhhdmUgZm9sbG93aW5nIG9wdGlvbnM6DQo+ID4gLSBQcm9ncmFtbWluZyB3aXRo
IHRyYW5zbGF0ZWQgYWRkcmVzcyB3aGVuIHNldHRpbmcgdXAga3ZtLW1zaS1pcnEtcm91dGUNCj4g
PiAtIFJvdXRlIHRoZSBpbnRlcnJ1cHRzIHZpYSBRRU1VLCB3aGljaCBpcyBiYWQgZnJvbSBwZXJm
b3JtYW5jZQ0KPiA+IC0gdmhvc3QtdmlydGlvLWlvbW11IG1heSBzb2x2ZSB0aGUgcHJvYmxlbSBp
biBsb25nIHRlcm0NCj4gPg0KPiA+IElzIHRoZXJlIGFueSBvdGhlciBiZXR0ZXIgb3B0aW9uIEkg
YW0gbWlzc2luZz8NCj4gDQo+IFNpbmNlIHdlJ3JlIG9uIHRoZSB0b3BpYyBvZiBNU0lzLi4uIEkn
bSBjdXJyZW50bHkgdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgaG93DQo+IHdlJ2xsIGhhbmRsZSBNU0lz
IGluIHRoZSBuZXN0ZWQgdHJhbnNsYXRpb24gbW9kZSwgd2hlcmUgdGhlIGd1ZXN0IG1hbmFnZXMN
Cj4gUzEgcGFnZSB0YWJsZXMgYW5kIHRoZSBob3N0IGRvZXNuJ3Qga25vdyBhYm91dCBHVkEtPkdQ
QSB0cmFuc2xhdGlvbi4NCj4gDQo+IEknbSBhbHNvIHdvbmRlcmluZyBhYm91dCB0aGUgYmVuZWZp
dHMgb2YgaGF2aW5nIFNXLW1hcHBlZCBNU0lzIGluIHRoZQ0KPiBndWVzdC4gSXQgc2VlbXMgdW5h
dm9pZGFibGUgZm9yIHZTTU1VIHNpbmNlIHRoYXQncyB3aGF0IGEgcGh5c2ljYWwgc3lzdGVtDQo+
IHdvdWxkIGRvLiBCdXQgaW4gYSBwYXJhdmlydHVhbGl6ZWQgc29sdXRpb24gdGhlcmUgZG9lc24n
dCBzZWVtIHRvIGJlIGFueQ0KPiBjb21wZWxsaW5nIHJlYXNvbiBmb3IgaGF2aW5nIHRoZSBndWVz
dCBtYXAgTVNJIGRvb3JiZWxscy4gVGhlc2UgYWRkcmVzc2VzDQo+IGFyZSBuZXZlciBhY2Nlc3Nl
ZCBkaXJlY3RseSwgdGhleSBhcmUgb25seSB1c2VkIGZvciBzZXR0aW5nIHVwIElSUSByb3V0aW5n
DQo+IChhdCBsZWFzdCBvbiBrdm10b29sKS4gU28gaGVyZSdzIHdoYXQgSSdkIGxpa2UgdG8gaGF2
ZS4gTm90ZSB0aGF0IEkNCj4gaGF2ZW4ndCBpbnZlc3RpZ2F0ZWQgdGhlIGZlYXNpYmlsaXR5IGlu
IFFlbXUgeWV0LCBJIGRvbid0IGtub3cgaG93IGl0DQo+IGRlYWxzIHdpdGggTVNJcy4NCj4gDQo+
ICgxKSBHdWVzdCB1c2VzIHRoZSBndWVzdC1waHlzaWNhbCBNU0kgZG9vcmJlbGwgd2hlbiBzZXR0
aW5nIHVwIE1TSXMuIEZvcg0KPiBBUk0gd2l0aCBHSUN2MyB0aGlzIHdvdWxkIGJlIEdJVFNfVFJB
TlNMQVRFUiwgZm9yIHg4NiBpdCB3b3VsZCBiZSB0aGUNCj4gZml4ZWQgTVNJIGRvb3JiZWxsLiBU
aGlzIHdheSB0aGUgaG9zdCB3b3VsZG4ndCBuZWVkIHRvIGluc3BlY3QgSU9NTVUNCj4gbWFwcGlu
Z3Mgd2hlbiBoYW5kbGluZyB3cml0ZXMgdG8gUENJIE1TSS1YIHRhYmxlcy4NCj4gDQoNCldoYXQg
ZG8geW91IG1lYW4gYnkgImZpeGVkIE1TSSBkb29yYmVsbCI/IFBDSSBNU0ktWCB0YWJsZSBpcyBw
YXJ0IG9mDQpQQ0kgTU1JTyBiYXIuIEFjY2Vzc2luZyB0byBpdCBpcyBqdXN0IGEgbWVtb3J5IHZp
cnR1YWxpemF0aW9uIGlzc3VlIChlLmcuDQp0cmFwIGJ5IEtWTSBhbmQgdGhlbiBlbXVsYXRlZCBp
biBRZW11KSBvbiB4ODYuIEl0J3Mgbm90IGEgSU9NTVUNCnByb2JsZW0uIEkgZ3Vlc3MgeW91IG1h
eSBtZWFuIHNhbWUgdGhpbmcgYnV0IHdhbnQgdG8gZG91YmxlIGNvbmZpcm0NCmhlcmUgZ2l2ZW4g
dGhlIHRlcm1pbm9sb2d5IGNvbmZ1c2lvbi4gT3IgZG8geW91IG1lYW4gdGhlIGludGVycnVwdA0K
dHJpZ2dlcmVkIGJ5IElPTU1VIGl0c2VsZj8NCg0KVGhhbmtzDQpLZXZpbg0K
