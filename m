Received: from eggs.gnu.org ([2001:4830:134:3::10]:60218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Ashish.Kalra@cavium.com>) id 1dTbTK-00067N-RL
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Ashish.Kalra@cavium.com>) id 1dTbTJ-00033R-MW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:11:34 -0400
From: "Kalra, Ashish" <Ashish.Kalra@cavium.com>
Date: Fri, 7 Jul 2017 22:11:25 +0000
Message-ID: <BN4PR07MB21615F830FCA5445EF4B7974E3AA0@BN4PR07MB2161.namprd07.prod.outlook.com>
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
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>, Auger Eric <eric.auger@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

SGVsbG8gSmVhbiwNCg0KVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24uDQoNCklzIHNvbWVvbmUg
YWxyZWFkeSB3b3JraW5nIG9uIGltcGxlbWVudGluZyB0aGlzLCBvciBpcyB0aGlzIHNvbWV0aGlu
ZyBJIGNhbiBsb29rIGludG8gYW5kIGltcGxlbWVudGluZyA/DQoNCkFsc28sIGFzIE1pY2hhZWwg
bWVudGlvbmVkIGFuZCBJIGxvb2tlZCBpbiB0aGUgdmZpbyBpb21tdSAodHlwZTEpIGRyaXZlciBp
bXBsZW1lbnRhdGlvbiB0aGF0IGl0IHN1cHBvcnRzIG1haW5seQ0Kc3RhdGljIG1hcHBpbmdzIG9m
IHVzZXItc3BhY2UgcHJvY2Vzc2VzIHdpdGggIHVzZXItc3BhY2UgcGFnZXMgcGlubmVkL2xvY2tl
ZCBpbiBtZW1vcnksIHNvIGEgZ2VuZXJpYyBzdXBwb3J0DQpmb3IgQVRTL1BSSSBleHRlbnNpb25z
IG5lZWRzIHRvIGJlIGFkZGVkIGluIFZGSU8gdG9vLg0KDQpUaGFua3MsDQpBc2hpc2gNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciBbbWFp
bHRvOmplYW4tcGhpbGlwcGUuYnJ1Y2tlckBhcm0uY29tXSANClNlbnQ6IEZyaWRheSwgSnVseSAw
NywgMjAxNyA4OjQ1IFBNDQpUbzogVGlhbiwgS2V2aW47IEthbHJhLCBBc2hpc2g7IEF1Z2VyIEVy
aWM7IEJoYXJhdCBCaHVzaGFuOyBlcmljLmF1Z2VyLnByb0BnbWFpbC5jb207IHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZzsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29t
OyBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCkNjOiBtYXJjLnp5
bmdpZXJAYXJtLmNvbTsgdG5Ac2VtaWhhbGYuY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyBkcmpv
bmVzQHJlZGhhdC5jb207IHJvYmluLm11cnBoeUBhcm0uY29tOyBjaHJpc3RvZmZlci5kYWxsQGxp
bmFyby5vcmcNClN1YmplY3Q6IFJlOiBbUWVtdS1hcm1dIFtRZW11LWRldmVsXSBbUkZDIHYyIDAv
OF0gVklSVElPLUlPTU1VIGRldmljZQ0KDQpIaSBBc2hpc2gsDQoNCk9uIDA3LzA3LzE3IDAwOjMz
LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4+IEZyb206IEthbHJhLCBBc2hpc2ggW21haWx0bzpBc2hp
c2guS2FscmFAY2F2aXVtLmNvbV0NCj4+IFNlbnQ6IEZyaWRheSwgSnVseSA3LCAyMDE3IDc6MjQg
QU0NCj4+DQo+PiBJIGhhdmUgYSBnZW5lcmljIHF1ZXN0aW9uIG9uIHZJT01NVSBzdXBwb3J0LCBp
cyB0aGVyZSBhbnkgDQo+PiBwcm9wb3NhbC9wbGFuIHRvIGFkZCBBVFMvUFJJIGV4dGVuc2lvbiBz
dXBwb3J0IHRvIHZJT01NVXMgYW5kIGFsbG93IA0KPj4gaGFuZGxpbmcgZm9yIGVuZCB0byBlbmQg
KHYpSU9NTVUgUGFnZSBmYXVsdHMgKHcvdCB0aGUgZGV2aWNlIHNpZGUgDQo+PiBpbXBsZW1lbnRh
dGlvbiBvbiBWaG9zdCkgPw0KPj4NCj4+IEFnYWluLCB0aGUgbW90aXZhdGlvbiB3aWxsIGJlIHRv
IGRvIERNQSBvbiBwYWdlZCBndWVzdCBtZW1vcnkgYW5kIA0KPj4gcG90ZW50aWFsbHkgYXZvaWRp
bmcgdGhlIHJlcXVpcmVtZW50IG9mIHBpbm5lZC9sb2NrZWQgZ3Vlc3QgcGh5c2ljYWwgDQo+PiBt
ZW1vcnkgZm9yIERNQS4NCj4gDQo+IHllcywgdGhhdCdzIGEgbmVjZXNzYXJ5IHBhcnQgdG8gc3Vw
cG9ydCBTVk0gaW4gYm90aCB2aXJ0aW8taW9tbXUgDQo+IGFwcHJvYWNoIGFuZCBmdWxseSBlbXVs
YXRlZCBhcHByb2FjaCAoZS5nLiBmb3IgSW50ZWwgVlRkKS4gVGhlcmUgYXJlIA0KPiBhbHJlYWR5
IHBhdGNoZXMgYW5kIGRpc2N1c3Npb25zIGluIG90aGVyIHRocmVhZCBhYm91dCBob3cgdG8gcHJv
cGFnYXRlIA0KPiBJT01NVSBwYWdlIGZhdWx0IHRvIHZJT01NVS4gVGhlbiBhZnRlciBpdCBpcyBk
b25lIHZJT01NVSBwYWdlIGZhdWx0IA0KPiBlbXVsYXRpb24gd2lsbCBiZSBmdXJ0aGVyIGFkZGVk
Lg0KPiANCj4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTcvNi8yNy85NjQNCg0KRm9yIHZpcnRp
by1pb21tdSwgSSdkIGxpa2UgdG8gYWRkIGFuIGV2ZW50IHZpcnRxdWV1ZSBmb3IgdGhlIGRldmlj
ZSB0byBzZW5kIHBhZ2UgZmF1bHRzIHRvIHRoZSBkcml2ZXIsIGluIGEgZm9ybWF0IHNpbWlsYXIg
dG8gYSBQUkkgUGFnZSBSZXF1ZXN0Lg0KVGhlIGRyaXZlciB3b3VsZCB0aGVuIHNlbmQgYSByZXBs
eSB2aWEgdGhlIHJlcXVlc3QgdmlydHF1ZXVlIGluIGEgZm9ybWF0IHNpbWlsYXIgdG8gYSBQUkcg
UmVzcG9uc2UuDQoNCkluIFFlbXUgdGhlIGRldmljZSBpbXBsZW1lbnRhdGlvbiB3b3VsZCBob3Bl
ZnVsbHkgYmUgYmFzZWQgb24gdGhlIHNhbWUgbWVjaGFuaXNtIGFzIFZUZC4gVGhlIHZob3N0IGlt
cGxlbWVudGF0aW9uIHdvdWxkIHJlY2VpdmUgSU8gUGFnZSBGYXVsdHMgZnJvbSBWRklPIGFuZCBm
b3J3YXJkIHRoZW0gb24gdGhlIGV2ZW50IHZpcnRxdWV1ZSBzaW1pbGFybHkgdG8gdGhlIHVzZXJz
cGFjZSBpbXBsZW1lbnRhdGlvbi4NCg0KVGhhbmtzLA0KSmVhbg0K
