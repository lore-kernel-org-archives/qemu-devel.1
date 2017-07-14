Received: from eggs.gnu.org ([2001:4830:134:3::10]:53268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dVuYJ-0001H8-AY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dVuYI-0005P5-HW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:58:15 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 14 Jul 2017 06:58:03 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D38304@SHSMSX101.ccr.corp.intel.com>
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<14c83c14-1e7e-f142-77b0-fa8c873e2d41@redhat.com>
	<AM5PR0401MB2545C0E76C4BE6F82FE376D09ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<6f22079e-4b4b-6476-77be-51ec83104c0d@redhat.com>
	<AM5PR0401MB25459FDAA8C9AFA52503AAE99AC40@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<c80977c4-1955-4e9d-3fc8-4d884562fd28@redhat.com>
	<HE1PR0401MB2556D19D91F25DCE96FE7B199AD40@HE1PR0401MB2556.eurprd04.prod.outlook.com>
	<8a7fb667-e6c0-2412-6dca-a8233dd27836@redhat.com>
	<HE1PR0401MB255696A487DFEB2B8972980F9AD40@HE1PR0401MB2556.eurprd04.prod.outlook.com>
	<e9ea564a-f02b-0ed5-e700-b7b1dfd89722@arm.com>
	<AM5PR0401MB25459345E9533FFC3BBE00289AD50@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<15b631c8-5708-1426-90a2-9be51a796614@redhat.com>
	<BN4PR07MB2161B5CCE84496804B848326E3D50@BN4PR07MB2161.namprd07.prod.outlook.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D28807@SHSMSX101.ccr.corp.intel.com>
	<67cb3a84-9aa7-2b4f-43b6-be6dea15b66f@arm.com>
In-Reply-To: <67cb3a84-9aa7-2b4f-43b6-be6dea15b66f@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-arm]  [RFC v2 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Kalra, Ashish" <Ashish.Kalra@cavium.com>, Auger Eric <eric.auger@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgW21haWx0bzpqZWFuLXBoaWxpcHBlLmJydWNr
ZXJAYXJtLmNvbV0NCj4gU2VudDogRnJpZGF5LCBKdWx5IDcsIDIwMTcgMTE6MTUgUE0NCj4gDQo+
IEhpIEFzaGlzaCwNCj4gDQo+IE9uIDA3LzA3LzE3IDAwOjMzLCBUaWFuLCBLZXZpbiB3cm90ZToN
Cj4gPj4gRnJvbTogS2FscmEsIEFzaGlzaCBbbWFpbHRvOkFzaGlzaC5LYWxyYUBjYXZpdW0uY29t
XQ0KPiA+PiBTZW50OiBGcmlkYXksIEp1bHkgNywgMjAxNyA3OjI0IEFNDQo+ID4+DQo+ID4+IEkg
aGF2ZSBhIGdlbmVyaWMgcXVlc3Rpb24gb24gdklPTU1VIHN1cHBvcnQsIGlzIHRoZXJlIGFueSBw
cm9wb3NhbC9wbGFuDQo+IHRvDQo+ID4+IGFkZCBBVFMvUFJJIGV4dGVuc2lvbiBzdXBwb3J0IHRv
IHZJT01NVXMgYW5kIGFsbG93DQo+ID4+IGhhbmRsaW5nIGZvciBlbmQgdG8gZW5kICh2KUlPTU1V
IFBhZ2UgZmF1bHRzICh3L3QgdGhlIGRldmljZSBzaWRlDQo+ID4+IGltcGxlbWVudGF0aW9uIG9u
IFZob3N0KSA/DQo+ID4+DQo+ID4+IEFnYWluLCB0aGUgbW90aXZhdGlvbiB3aWxsIGJlIHRvIGRv
IERNQSBvbiBwYWdlZCBndWVzdCBtZW1vcnkgYW5kDQo+ID4+IHBvdGVudGlhbGx5IGF2b2lkaW5n
IHRoZSByZXF1aXJlbWVudCBvZiBwaW5uZWQvbG9ja2VkDQo+ID4+IGd1ZXN0IHBoeXNpY2FsIG1l
bW9yeSBmb3IgRE1BLg0KPiA+DQo+ID4geWVzLCB0aGF0J3MgYSBuZWNlc3NhcnkgcGFydCB0byBz
dXBwb3J0IFNWTSBpbiBib3RoIHZpcnRpby1pb21tdQ0KPiA+IGFwcHJvYWNoIGFuZCBmdWxseSBl
bXVsYXRlZCBhcHByb2FjaCAoZS5nLiBmb3IgSW50ZWwgVlRkKS4gVGhlcmUNCj4gPiBhcmUgYWxy
ZWFkeSBwYXRjaGVzIGFuZCBkaXNjdXNzaW9ucyBpbiBvdGhlciB0aHJlYWQgYWJvdXQgaG93IHRv
DQo+ID4gcHJvcGFnYXRlIElPTU1VIHBhZ2UgZmF1bHQgdG8gdklPTU1VLiBUaGVuIGFmdGVyIGl0
IGlzIGRvbmUNCj4gPiB2SU9NTVUgcGFnZSBmYXVsdCBlbXVsYXRpb24gd2lsbCBiZSBmdXJ0aGVy
IGFkZGVkLg0KPiA+DQo+ID4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTcvNi8yNy85NjQNCj4g
DQo+IEZvciB2aXJ0aW8taW9tbXUsIEknZCBsaWtlIHRvIGFkZCBhbiBldmVudCB2aXJ0cXVldWUg
Zm9yIHRoZSBkZXZpY2UgdG8NCj4gc2VuZCBwYWdlIGZhdWx0cyB0byB0aGUgZHJpdmVyLCBpbiBh
IGZvcm1hdCBzaW1pbGFyIHRvIGEgUFJJIFBhZ2UgUmVxdWVzdC4NCj4gVGhlIGRyaXZlciB3b3Vs
ZCB0aGVuIHNlbmQgYSByZXBseSB2aWEgdGhlIHJlcXVlc3QgdmlydHF1ZXVlIGluIGEgZm9ybWF0
DQo+IHNpbWlsYXIgdG8gYSBQUkcgUmVzcG9uc2UuDQo+IA0KPiBJbiBRZW11IHRoZSBkZXZpY2Ug
aW1wbGVtZW50YXRpb24gd291bGQgaG9wZWZ1bGx5IGJlIGJhc2VkIG9uIHRoZSBzYW1lDQo+IG1l
Y2hhbmlzbSBhcyBWVGQuIFRoZSB2aG9zdCBpbXBsZW1lbnRhdGlvbiB3b3VsZCByZWNlaXZlIElP
IFBhZ2UgRmF1bHRzDQo+IGZyb20gVkZJTyBhbmQgZm9yd2FyZCB0aGVtIG9uIHRoZSBldmVudCB2
aXJ0cXVldWUgc2ltaWxhcmx5IHRvIHRoZQ0KPiB1c2Vyc3BhY2UgaW1wbGVtZW50YXRpb24uDQo+
IA0KDQpBZ3JlZS4gSSBleHBlY3QgdGhlIHBhdGggYmV0d2VlbiBRZW11IGFuZCBWRklPIGFyZSBn
ZW5lcmFsIGVub3VnaA0KZm9yIGJvdGggZW11bGF0ZWQgSU9NTVUgYW5kIHZpcnRpby1JT01NVS4g
RGlmZmVyZW5jZSBpcyBvbiB0aGUgDQpwcm9wYWdhdGlvbiBwYXRoIHRvIGd1ZXN0IGJhc2VkIG9u
IHRoZSBkZWZpbml0aW9uIG9mIGRpZmZlcmVudCB2aXJ0dWFsIA0KaW50ZXJmYWNlcy4NCg0KVGhh
bmtzDQpLZXZpbg0K
