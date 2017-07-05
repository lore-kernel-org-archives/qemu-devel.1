Received: from eggs.gnu.org ([2001:4830:134:3::10]:49704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dSeh6-0006RC-M0
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dSeh1-0003lW-MX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:25:52 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 5 Jul 2017 07:25:43 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D25B77@SHSMSX101.ccr.corp.intel.com>
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<AM5PR0401MB2545AFD256A96420ACC44CD89ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<14c83c14-1e7e-f142-77b0-fa8c873e2d41@redhat.com>
	<AM5PR0401MB2545C0E76C4BE6F82FE376D09ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<6f22079e-4b4b-6476-77be-51ec83104c0d@redhat.com>
	<AM5PR0401MB25459FDAA8C9AFA52503AAE99AC40@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<589f1642-775c-4805-74ac-bf67eb504733@arm.com>
	<5f47e723-1d3e-433b-cdaf-a56d16ba377e@redhat.com>
	<d4277d93-d29d-7150-7962-bdfdd1c2a275@arm.com>
In-Reply-To: <d4277d93-d29d-7150-7962-bdfdd1c2a275@arm.com>
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
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Auger Eric <eric.auger@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "wei@redhat.com" <wei@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgW21haWx0bzpqZWFuLXBoaWxpcHBlLmJydWNr
ZXJAYXJtLmNvbV0NCj4gU2VudDogVHVlc2RheSwgSnVuZSAyNywgMjAxNyAxMjoxMyBBTQ0KPiAN
Cj4gT24gMjYvMDYvMTcgMDk6MjIsIEF1Z2VyIEVyaWMgd3JvdGU6DQo+ID4gSGkgSmVhbi1QaGls
aXBwZSwNCj4gPg0KPiA+IE9uIDE5LzA2LzIwMTcgMTI6MTUsIEplYW4tUGhpbGlwcGUgQnJ1Y2tl
ciB3cm90ZToNCj4gPj4gT24gMTkvMDYvMTcgMDg6NTQsIEJoYXJhdCBCaHVzaGFuIHdyb3RlOg0K
PiA+Pj4gSGkgRXJpYywNCj4gPj4+DQo+ID4+PiBJIHN0YXJ0ZWQgYWRkZWQgcmVwbGF5IGluIHZp
cnRpby1pb21tdSBhbmQgY2FtZSBhY3Jvc3MgaG93IE1TSQ0KPiBpbnRlcnJ1cHRzIHdpdGggd29y
ayB3aXRoIFZGSU8uDQo+ID4+PiBJIHVuZGVyc3RhbmQgdGhhdCBvbiBpbnRlbCB0aGlzIHdvcmtz
IGRpZmZlcmVudGx5IGJ1dCB2c21tdSB3aWxsIGhhdmUNCj4gc2FtZSByZXF1aXJlbWVudC4NCj4g
Pj4+IGt2bS1tc2ktaXJxLXJvdXRlIGFyZSBhZGRlZCB1c2luZyB0aGUgbXNpLWFkZHJlc3MgdG8g
YmUgdHJhbnNsYXRlZCBieQ0KPiB2aW9tbXUgYW5kIG5vdCB0aGUgZmluYWwgdHJhbnNsYXRlZCBh
ZGRyZXNzLg0KPiA+Pj4gV2hpbGUgY3VycmVudGx5IHRoZSBpcnFmZCBmcmFtZXdvcmsgZG9lcyBu
b3Qga25vdyBhYm91dCBlbXVsYXRlZA0KPiBpb21tdXMgKHZpcnRpby1pb21tdSwgdnNtbXV2My92
aW50ZWwtaW9tbXUpLg0KPiA+Pj4gU28gaW4gbXkgdmlldyB3ZSBoYXZlIGZvbGxvd2luZyBvcHRp
b25zOg0KPiA+Pj4gLSBQcm9ncmFtbWluZyB3aXRoIHRyYW5zbGF0ZWQgYWRkcmVzcyB3aGVuIHNl
dHRpbmcgdXAga3ZtLW1zaS1pcnEtDQo+IHJvdXRlDQo+ID4+PiAtIFJvdXRlIHRoZSBpbnRlcnJ1
cHRzIHZpYSBRRU1VLCB3aGljaCBpcyBiYWQgZnJvbSBwZXJmb3JtYW5jZQ0KPiA+Pj4gLSB2aG9z
dC12aXJ0aW8taW9tbXUgbWF5IHNvbHZlIHRoZSBwcm9ibGVtIGluIGxvbmcgdGVybQ0KPiA+Pj4N
Cj4gPj4+IElzIHRoZXJlIGFueSBvdGhlciBiZXR0ZXIgb3B0aW9uIEkgYW0gbWlzc2luZz8NCj4g
Pj4NCj4gPj4gU2luY2Ugd2UncmUgb24gdGhlIHRvcGljIG9mIE1TSXMuLi4gSSdtIGN1cnJlbnRs
eSB0cnlpbmcgdG8gZmlndXJlIG91dCBob3cNCj4gPj4gd2UnbGwgaGFuZGxlIE1TSXMgaW4gdGhl
IG5lc3RlZCB0cmFuc2xhdGlvbiBtb2RlLCB3aGVyZSB0aGUgZ3Vlc3QNCj4gbWFuYWdlcw0KPiA+
PiBTMSBwYWdlIHRhYmxlcyBhbmQgdGhlIGhvc3QgZG9lc24ndCBrbm93IGFib3V0IEdWQS0+R1BB
IHRyYW5zbGF0aW9uLg0KPiA+DQo+ID4gSSBoYXZlIGEgcXVlc3Rpb24gYWJvdXQgdGhlICJuZXN0
ZWQgdHJhbnNsYXRpb24gbW9kZSIgdGVybWlub2xvZ3kuIERvDQo+ID4geW91IG1lYW4gaW4gdGhh
dCBjYXNlIHlvdSB1c2Ugc3RhZ2UgMSArIHN0YWdlIDIgb2YgdGhlIHBoeXNpY2FsIElPTU1VDQo+
ID4gKHdoaWNoIHRoZSBBUk0gc3BlYyBub3JtYWxseSBhZHZpc2VzIG9yIHdhcyBtZWFudCBmb3Ip
IG9yIGRvIHlvdSBtZWFuDQo+ID4gc3RhZ2UgMSBpbXBsZW1lbnRlZCBpbiB2SU9NTVUgYW5kIHN0
YWdlIDIgaW1wbGVtZW50ZWQgaW4gcElPTU1VLiBBdA0KPiB0aGUNCj4gPiBtb21lbnQgbXkgdW5k
ZXJzdGFuZGluZyBpcyBmb3IgVkZJTyBpbnRlZ3JhdGlvbiB0aGUgcElPTU1VIHVzZXMgYQ0KPiBz
aW5nbGUNCj4gPiBzdGFnZSBjb21iaW5pbmcgYm90aCB0aGUgc3RhZ2UgMSBhbmQgc3RhZ2UyIG1h
cHBpbmdzIGJ1dCB0aGUgaG9zdCBpcyBub3QNCj4gPiBhd2FyZSBvZiB0aG9zZSAyIHN0YWdlcy4N
Cj4gDQo+IFllcyBhdCB0aGUgbW9tZW50IHRoZSBWTU0gbWVyZ2VzIHN0YWdlLTEgKEdWQS0+R1BB
KSBmcm9tIHRoZSBndWVzdCB3aXRoDQo+IGl0cyBzdGFnZS0yIG1hcHBpbmdzIChHUEEtPkhQQSkg
YW5kIGNyZWF0ZXMgYSBzdGFnZS0yIG1hcHBpbmcgKEdWQS0+SFBBKQ0KPiBpbiB0aGUgcElPTU1V
IHZpYSBWRklPX0lPTU1VX01BUF9ETUEuIHN0YWdlLTEgaXMgZGlzYWJsZWQgaW4gdGhlDQo+IHBJ
T01NVS4NCj4gDQoNCkN1cmlvdXMgd2hldGhlciB5b3UgYXJlIGRlc2NyaWJpbmcgY3VycmVudCBz
bW11IHN0YXR1cyBvciBnZW5lcmFsDQp2SU9NTVUgc3RhdHVzIGFsc28gYXBwbHlpbmcgdG8gb3Ro
ZXIgdmVuZG9ycy4uLg0KDQp0aGUgdXNhZ2Ugd2hhdCB5b3UgZGVzY3JpYmVkIGlzIGFib3V0IHN2
bSwgd2hpbGUgc3ZtIHJlcXVpcmVzIFBBU0lELg0KQXQgbGVhc3QgUEFTSUQgaXMgdGllZCB0byBz
dGFnZS0xIG9uIEludGVsIFZULWQuIE9ubHkgRE1BIHcvbyBQQVNJRA0Kb3IgbmVzdGVkIHRyYW5z
bGF0aW9uIGZyb20gc3RhZ2UtMSB3aWxsIGdvIHRocm91Z2ggc3RhZ2UtMi4gVW5sZXNzDQpBUk0g
c21tdSBoYXMgYSBjb21wbGV0ZWx5IGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbiwgSSdtIG5vdCBz
dXJlDQpob3cgc3ZtIGNhbiBiZSB2aXJ0dWFsaXplZCB3LyBzdGFnZS0xIHRyYW5zbGF0aW9uIGRp
c2FibGVkLiBUaGVyZQ0KYXJlIG11bHRpcGxlIHN0YWdlLTEgcGFnZSB0YWJsZXMgd2hpbGUgb25s
eSBvbmUgc3RhZ2UtMiBwYWdlIHRhYmxlIHBlcg0KZGV2aWNlLiBDb3VsZCBtZXJnaW5nIGFjdHVh
bGx5IHdvcmsgaGVyZT8NCg0KVGhlIG9ubHkgY2FzZSB3aXRoIG1lcmdpbmcgaGFwcGVuIHRvZGF5
IGlzIGZvciBndWVzdCBzdGFnZS0yIHVzYWdlDQpvciBzby1jYWxsZWQgR0lPVkEgdXNhZ2UuIEd1
ZXN0IHByb2dyYW1zIEdJT1ZBLT5HUEEgdG8gdklPTU1VIA0Kc3RhZ2UtMi4gVGhlbiB2SU9NTVUg
aW52b2tlcyB2ZmlvIG1hcC91bm1hcCBBUElzIHRvIHRyYW5zbGF0ZS8NCm1lcmdlIHRvIEdJT1ZB
LT5IUEEgdG8gcElPTU1VIHN0YWdlLTIuIE1heWJlIHdoYXQgeW91DQphY3R1YWxseSBtZWFudCBp
cyB0aGlzIG9uZT8NCg0KVGhhbmtzDQpLZXZpbg0K
