Received: from eggs.gnu.org ([2001:4830:134:3::10]:35183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1ebbz8-0004jJ-Qk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 19:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1ebbz5-000305-KB
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 19:53:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:19436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1ebbz5-0002zF-BI
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 19:53:43 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Wed, 17 Jan 2018 00:53:37 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5EFE58@SHSMSX103.ccr.corp.intel.com>
References: <1516003315-17878-1-git-send-email-changpeng.liu@intel.com>
	<1516003315-17878-2-git-send-email-changpeng.liu@intel.com>
	<7711f157-5863-fc75-0730-a631362ffd06@redhat.com>
In-Reply-To: <7711f157-5863-fc75-0730-a631362ffd06@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1] block/NVMe: introduce a new vhost NVMe
 host device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Harris, James R" <james.r.harris@intel.com>, "Busch, Keith" <keith.busch@intel.com>, "famz@redhat.com" <famz@redhat.com>, "stefanha@gmail.com" <stefanha@gmail.com>, "mst@redhat.com" <mst@redhat.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAx
NywgMjAxOCAxOjA3IEFNDQo+IFRvOiBMaXUsIENoYW5ncGVuZyA8Y2hhbmdwZW5nLmxpdUBpbnRl
bC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEhhcnJpcywgSmFtZXMgUiA8amFt
ZXMuci5oYXJyaXNAaW50ZWwuY29tPjsgQnVzY2gsIEtlaXRoDQo+IDxrZWl0aC5idXNjaEBpbnRl
bC5jb20+OyBmYW16QHJlZGhhdC5jb207IHN0ZWZhbmhhQGdtYWlsLmNvbTsNCj4gbXN0QHJlZGhh
dC5jb20NCj4gU3ViamVjdDogUmU6IFtSRkMgdjFdIGJsb2NrL05WTWU6IGludHJvZHVjZSBhIG5l
dyB2aG9zdCBOVk1lIGhvc3QgZGV2aWNlIHRvDQo+IFFFTVUNCj4gDQo+IE9uIDE1LzAxLzIwMTgg
MDk6MDEsIENoYW5ncGVuZyBMaXUgd3JvdGU6DQo+ID4gTlZNZSAxLjMgc3BlY2lmaWNhdGlvbiBp
bnRyb2R1Y2VzIGEgbmV3IE5WTWUgQURNSU4gY29tbWFuZDoNCj4gPiBkb29yYmVsbCBidWZmZXIg
Y29uZmlnLCB3aGljaCBjYW4gd3JpdGUgc2hhZG93IGRvb3JiZWxsIGJ1ZmZlcg0KPiA+IGluc3Rl
YWQgb2YgTU1JTyByZWdpc3RlcnMsIHNvIGl0IGNhbiBpbXByb3ZlIHRoZSBHdWVzdCBwZXJmb3Jt
YW5jZQ0KPiA+IGEgbG90IGZvciBlbXVsYXRlZCBOVk1lIGRldmljZXMgaW5zaWRlIFZNLg0KPiA+
DQo+ID4gU2ltaWxhciB3aXRoIGV4aXN0aW5nIHZob3N0LXVzZXItc2NzaSBzb2x1dGlvbiwgdGhp
cyBjb21taXQgYnVpbGRzIGENCj4gPiBuZXcgdmhvc3RfdXNlcl9udm1lIGhvc3QgZGV2aWNlIHRv
IFZNIGFuZCB0aGUgSS9PIGlzIHByb2Nlc3NlZCBhdA0KPiA+IHRoZSBzbGF2ZSBJL08gdGFyZ2V0
LCBzbyB1c2VycyBjYW4gaW1wbGVtZW50IGEgdXNlciBzcGFjZSBOVk1lIGRyaXZlcg0KPiA+IGlu
IHRoZSBzbGF2ZSBJL08gdGFyZ2V0Lg0KPiA+DQo+ID4gVXNlcnMgY2FuIHN0YXJ0IFFFTVUgd2l0
aDogLWNoYXJkZXYgc29ja2V0LGlkPWNoYXIwLHBhdGg9L3BhdGgvdmhvc3QuMCBcDQo+ID4gLWRl
dmljZSB2aG9zdC11c2VyLW52bWUsY2hhcmRldj1jaGFyMCxudW1faW9fcXVldWVzPTIuDQo+IA0K
PiBIaSBDaGFuZ3BlbmcsDQo+IA0KPiBJIGhhdmUgdHdvIGNvbW1lbnRzIG9uIHRoaXMgc2VyaWVz
Lg0KPiANCj4gRmlyc3QsIHRoZSBuZXcgY29tbWFuZCBpbiBOVk1lIDEuMyBpcyBncmVhdC4gIEhv
d2V2ZXIsIHBsZWFzZSBmaXJzdCBhZGQNCj4gc3VwcG9ydCBmb3IgdGhlIGRvb3JiZWxsIGJ1ZmZl
ciBjb25maWcgaW4gaHcvYmxvY2svbnZtZS5jLiAgVGhlcmUgaXMgbm8NCj4gbmVlZCB0byB0aWUg
c3VwcG9ydCBmb3IgdGhlIG5ldyBjb21tYW5kIHRvIGEgY29tcGxldGVseSBuZXcgZXh0ZXJuYWwN
Cj4gc2VydmVyIGFyY2hpdGVjdHVyZS4gIEVtdWxhdGVkIE5WTWUgY2FuIGJlIGVuaGFuY2VkIHRv
IHVzZSBpb3RocmVhZHMgYW5kDQo+ICh3aGVuIHRoZSBkb29yYmVsbCBidWZmZXIgaXMgY29uZmln
dXJlZCkgaW9ldmVudGZkLCBhbmQgdGhhdCBzaG91bGQgY29tZQ0KPiBiZWZvcmUgZW5oYW5jZW1l
bnRzIGZvciBleHRlcm5hbCB2aG9zdC1saWtlIHNlcnZlcnMuDQpZZXMsIGFkZGluZyBkb29yYmVs
bCBidWZmZXIgY29uZmlnIHN1cHBvcnQgYXQgaHcvYmxvY2svbnZtZS5jIGlzIGdyZWF0IHRvIGlt
cHJvdmUNCnRoZSBlZmZpY2llbmN5LCB0aGlzIHZob3N0LWxpa2UgaWRlYSBpcyBhbm90aGVyIHNv
bHV0aW9uIHdoaWNoIGNhbiBwcm92aWRlIGVuZC10by1lbmQNCnVzZXJzcGFjZSBzb2Z0d2FyZSBz
dGFjay4NCj4gDQo+IFNlY29uZCwgdmlydGlvLWJhc2VkIHZob3N0LXVzZXIgcmVtYWlucyBRRU1V
J3MgcHJlZmVycmVkIG1ldGhvZCBmb3INCj4gaGlnaC1wZXJmb3JtYW5jZSBJL08gaW4gZ3Vlc3Rz
LiAgRGlzY2FyZCBzdXBwb3J0IGlzIG1pc3NpbmcgYW5kIHRoYXQgaXMNCj4gaW1wb3J0YW50IGZv
ciBTU0RzOyB0aGF0IHNob3VsZCBiZSBmaXhlZCBpbiB0aGUgdmlydGlvIHNwZWMuICBBcmUgdGhl
cmUNClByZXZpb3VzbHkgSSBoYXZlIGEgcGF0Y2ggYWRkaW5nIERJU0NBUkQgc3VwcG9ydCB0byB2
aXJ0aW8tYmxrLCBidXQgSSBkaWRuJ3QgZmluZA0KdGhlIHdheSB1c2luZyBzdm4gdG8gdXBkYXRl
IHRoZSBzcGVjIHBhdGNoLCBhbnkgZ2l0IHJlcG9zaXRvcnkgSSBjYW4gdXNlDQp0byB1cGRhdGUg
dGhlIHZpcnRpby1ibGsgc3BlYyA/IEkgdGhpbmsgSSBjYW4gcGljayB1cCB0aGUgZmVhdHVyZSBh
Z2Fpbi4NCj4gYW55IG90aGVyIGZlYXR1cmVzIHdoZXJlIHZpcnRpby1ibGsgaXMgbGFnZ2luZyBi
ZWhpbmQgTlZNZT8NCkZyb20gdGhlIGVmZmljaWVuY3kgY29uc2lkZXJhdGlvbiwgSSBjb21wYXJl
ZCB0aGUgc29sdXRpb24gd2l0aCB2aG9zdC11c2VyLWJsaywNCkluZGVlZCwgdGhlIHR3byBzb2x1
dGlvbiBhcmUgYWxtb3N0IGF0IHRoZSBzYW1lIGxldmVsLCBJT1BTL0NQVSB1dGlsaXphdGlvbiBp
bnNpZGUgR3Vlc3QvS1ZNIGV2ZW50cyhWTV9FWElULA0KS1ZNX0ZBU1RfTU1JTyxLVk1fTVNJX1NF
VF9JUlEsS1ZNX01TUikgYXJlIGFsbW9zdCBzYW1lLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gUGFv
bG8NCg==
