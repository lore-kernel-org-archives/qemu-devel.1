Received: from eggs.gnu.org ([2001:4830:134:3::10]:57923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dTGHj-0006U7-6r
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dTGHi-00066X-8H
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:34:11 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Thu, 6 Jul 2017 23:33:07 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D28807@SHSMSX101.ccr.corp.intel.com>
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<AM5PR0401MB2545AFD256A96420ACC44CD89ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
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
In-Reply-To: <BN4PR07MB2161B5CCE84496804B848326E3D50@BN4PR07MB2161.namprd07.prod.outlook.com>
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
To: "Kalra, Ashish" <Ashish.Kalra@cavium.com>, Auger Eric <eric.auger@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

PiBGcm9tOiBLYWxyYSwgQXNoaXNoIFttYWlsdG86QXNoaXNoLkthbHJhQGNhdml1bS5jb21dDQo+
IFNlbnQ6IEZyaWRheSwgSnVseSA3LCAyMDE3IDc6MjQgQU0NCj4gDQo+IEkgaGF2ZSBhIGdlbmVy
aWMgcXVlc3Rpb24gb24gdklPTU1VIHN1cHBvcnQsIGlzIHRoZXJlIGFueSBwcm9wb3NhbC9wbGFu
IHRvDQo+IGFkZCBBVFMvUFJJIGV4dGVuc2lvbiBzdXBwb3J0IHRvIHZJT01NVXMgYW5kIGFsbG93
DQo+IGhhbmRsaW5nIGZvciBlbmQgdG8gZW5kICh2KUlPTU1VIFBhZ2UgZmF1bHRzICh3L3QgdGhl
IGRldmljZSBzaWRlDQo+IGltcGxlbWVudGF0aW9uIG9uIFZob3N0KSA/DQo+IA0KPiBBZ2Fpbiwg
dGhlIG1vdGl2YXRpb24gd2lsbCBiZSB0byBkbyBETUEgb24gcGFnZWQgZ3Vlc3QgbWVtb3J5IGFu
ZA0KPiBwb3RlbnRpYWxseSBhdm9pZGluZyB0aGUgcmVxdWlyZW1lbnQgb2YgcGlubmVkL2xvY2tl
ZA0KPiBndWVzdCBwaHlzaWNhbCBtZW1vcnkgZm9yIERNQS4NCg0KeWVzLCB0aGF0J3MgYSBuZWNl
c3NhcnkgcGFydCB0byBzdXBwb3J0IFNWTSBpbiBib3RoIHZpcnRpby1pb21tdSANCmFwcHJvYWNo
IGFuZCBmdWxseSBlbXVsYXRlZCBhcHByb2FjaCAoZS5nLiBmb3IgSW50ZWwgVlRkKS4gVGhlcmUN
CmFyZSBhbHJlYWR5IHBhdGNoZXMgYW5kIGRpc2N1c3Npb25zIGluIG90aGVyIHRocmVhZCBhYm91
dCBob3cgdG8NCnByb3BhZ2F0ZSBJT01NVSBwYWdlIGZhdWx0IHRvIHZJT01NVS4gVGhlbiBhZnRl
ciBpdCBpcyBkb25lDQp2SU9NTVUgcGFnZSBmYXVsdCBlbXVsYXRpb24gd2lsbCBiZSBmdXJ0aGVy
IGFkZGVkLg0KDQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNy82LzI3Lzk2NA0KDQpUaGFua3MN
CktldmluDQo=
