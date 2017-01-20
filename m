Received: from eggs.gnu.org ([2001:4830:134:3::10]:34512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUVMh-0007nr-LT
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUVMc-0005in-Nn
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:20:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:32016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cUVMc-0005hs-EZ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:20:06 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 20 Jan 2017 09:20:01 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C15137@SHSMSX101.ccr.corp.intel.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-2-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14FD2@SHSMSX101.ccr.corp.intel.com>
	<20170120085457.GI4914@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C150AD@SHSMSX101.ccr.corp.intel.com>
	<20170120091143.GK4914@pxdev.xzpeter.org>
In-Reply-To: <20170120091143.GK4914@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RFC v3 01/14] IOMMU: add option to enable
 VTD_CAP_CM to vIOMMU capility exposoed to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBGcmlk
YXksIEphbnVhcnkgMjAsIDIwMTcgNToxMiBQTQ0KPiANCj4gT24gRnJpLCBKYW4gMjAsIDIwMTcg
YXQgMDg6NTk6MDFBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiAN
Cj4gPiA+ID4gQWxzbyBmb3IgaG90LWFkZA0KPiA+ID4gPiBkZXZpY2UgcGF0aCwgc29tZSBjaGVj
ayBvZiBjYWNoaW5nIG1vZGUgaXMgcmVxdWlyZWQuIElmIG5vdCBzZXQsDQo+ID4gPiA+IHNob3Vs
ZCB3ZSBmYWlsIGhvdC1hZGQgb3BlcmF0aW9uPyBJIGRvbid0IHRoaW5rIHdlIGhhdmUgc3VjaCBw
aHlzaWNhbA0KPiA+ID4gPiBwbGF0Zm9ybSB3aXRoIHNvbWUgZGV2aWNlcyBiZWhpbmQgSU9NTVUg
d2hpbGUgb3RoZXJzIG5vdC4NCj4gPiA+DQo+ID4gPiBDb3VsZCB5b3UgZXhwbGFpbiBpbiB3aGF0
IGNhc2Ugd2lsbCB3ZSBmYWlsIGEgaG90IHBsdWc/DQo+ID4gPg0KPiA+DQo+ID4gdXNlciBlbmFi
bGVzIGludGVsLWlvbW11LCBidXQgZG9uJ3Qgc2V0IGNhY2hpbmcgbW9kZS4NCj4gPg0KPiA+IFRo
ZW4gbGF0ZXIgdXNlciBob3QtYWRkIGEgUENJIGRldmljZSB0byB0aGUgVk0uIEd1ZXN0IHdpbGwg
YXNzdW1lDQo+ID4gbmV3bHkgYXNzaWduZWQgZGV2aWNlIGFsc28gYmVoaW5kIHRoZSBkZWZhdWx0
IHZJT01NVSwgYW5kIHRodXMNCj4gPiBuZWVkcyB0byBzZXR1cCBJT1ZBIG1hcHBpbmdzLCB3aGlj
aCBpcyB0aGVuIGJyb2tlbi4uLg0KPiANCj4gSXMgdGhlIG5ld2x5IGFkZGVkIGRldmljZSBhIHZm
aW8tcGNpIGRldmljZT8gSWYgc28sIHdlIHNob3VsZCBoaXQNCj4gdGhpcyBhbmQgVk0gd2lsbCBz
dG9wcyB0byB3b3JrOg0KPiANCj4gICAgIGlmICghcy0+Y2FjaGVfbW9kZV9lbmFibGVkICYmIG5l
dyAmIElPTU1VX05PVElGSUVSX01BUCkgew0KPiAgICAgICAgIGVycm9yX3JlcG9ydCgiV2UgbmVl
ZCB0byBzZXQgY2FjaGVfbW9kZT0xIGZvciBpbnRlbC1pb21tdSB0byBlbmFibGUgIg0KPiAgICAg
ICAgICAgICAgICAgICAgICAiZGV2aWNlIGFzc2lnbm1lbnQgd2l0aCBJT01NVSBwcm90ZWN0aW9u
LiIpOw0KPiAgICAgICAgIGV4aXQoMSk7DQo+ICAgICB9DQoNCnNvcnJ5IEkgZGlkbid0IGZvdW5k
IHRoaXMgY29kZS4gSW4gd2hpY2ggY29kZSBwYXRoIGlzIGl0IGhpdD8NCg0KPiANCj4gSSBhZG1p
dCB0aGlzIGlzIG5vdCB1c2VyLWZyaWVuZGx5LCBhbmQgYSBiZXR0ZXIgd2F5IG1heSBiZSB0aGF0
IHdlDQo+IGRpc2FsbG93IHRoZSBob3QtcGx1ZyBpbiB0aGF0IGNhc2UsIHRlbGxpbmcgdGhlIHVz
ZXIgYWJvdXQgdGhlIGVycm9yLA0KPiByYXRoZXIgdGhhbiBjcmFzaGluZyB0aGUgVk0uIEJ1dCwg
SSB0aGluayB0aGF0IGNhbiBiZSBhIHBhdGNoIG91dHNpZGUNCj4gdGhpcyBzZXJpZXMsIGNvbnNp
ZGVyaW5nIChhZ2FpbikgdGhhdCB0aGlzIG9ubHkgYWZmZWN0cyBhZHZhbmNlZA0KPiB1c2Vycy4N
Cj4gDQoNCkNyYXNoaW5nIFZNIGlzIGJhZC4uLi4gYnV0IGFueXdheSwgSSdsbCBsZWF2ZSBtYWlu
dGFpbmVyIHRvIGRlY2lkZQ0Kd2hldGhlciB0aGV5J2QgbGlrZSBpdCBmaXhlZCBub3cgb3IgbGF0
ZXIuIDotKQ0KDQpUaGFua3MNCktldmluDQo=
