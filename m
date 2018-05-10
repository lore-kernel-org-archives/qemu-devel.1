Received: from eggs.gnu.org ([2001:4830:134:3::10]:46549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGbtT-0004Qp-4Q
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGbtP-0005zK-Vx
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:05:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:42474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fGbtP-0005zE-M5
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:05:19 -0400
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Date: Thu, 10 May 2018 03:05:10 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D35269B8FA@SHSMSX103.ccr.corp.intel.com>
References: <1525854869-13975-1-git-send-email-jingqi.liu@intel.com>
	<5c500726-bd2d-2261-68ec-dd39c98d06aa@redhat.com>
In-Reply-To: <5c500726-bd2d-2261-68ec-dd39c98d06aa@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v1 1/7] hmat acpi: Build Memory Subsystem
 Address Range Structre(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>
Cc: "imammedo@redhat.com" <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBCbGFrZSBbbWFp
bHRvOmVibGFrZUByZWRoYXQuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE1heSA5LCAyMDE4IDk6
MTMgUE0NCj4gVG86IExpdSwgSmluZ3FpIDxqaW5ncWkubGl1QGludGVsLmNvbT47IHBib256aW5p
QHJlZGhhdC5jb207IHJ0aEB0d2lkZGxlLm5ldDsNCj4gZWhhYmtvc3RAcmVkaGF0LmNvbQ0KPiBD
YzogaW1hbW1lZG9AcmVkaGF0LmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBtc3RAcmVkaGF0
LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2MSAxLzddIGhtYXQgYWNw
aTogQnVpbGQgTWVtb3J5IFN1YnN5c3RlbQ0KPiBBZGRyZXNzIFJhbmdlIFN0cnVjdHJlKHMpIGlu
IEFDUEkgSE1BVA0KPiANCj4gT24gMDUvMDkvMjAxOCAwMzozNCBBTSwgTGl1IEppbmdxaSB3cm90
ZToNCj4gDQo+IEluIHRoZSBzdWJqZWN0IGxpbmU6IHMvU3RydWN0cmUvU3RydWN0dXJlLw0KPiAN
Cj4gTG9uZyBzdWJqZWN0IGxpbmU7IHJlYWQgJ2dpdCBzaG9ydGxvZyAtMzAnIHRvIGdldCBhIGZl
ZWwgZm9yIG1vcmUgdHlwaWNhbCBzdWJqZWN0cywNCj4gYW5kIHRyeSB0byBrZWVwIGl0IGF0IDYw
IGNoYXJhY3RlcnMgb3IgbGVzcyAoeW91IHN0aWxsIHdhbnQgbGVnaWJsZSBzdWJqZWN0cyBpbiBh
biA4MC0NCj4gY29sdW1uIHdpbmRvdyBldmVuIHdoZW4gZ2l0IGFkZHMgaW5kZW50YXRpb24gYW5k
L29yIGFiYnJldmlhdGVkIGNvbW1pdCBpZA0KPiBwcmVmaXhlcykNCj4gDQo+ID4gSE1BVCBpcyBk
ZWZpbmVkIGluIEFDUEkgNi4yOiA1LjIuMjcgSGV0ZXJvZ2VuZW91cyBNZW1vcnkgQXR0cmlidXRl
IFRhYmxlDQo+IChITUFUKS4NCj4gPiBUaGUgc3BlY2lmaWNhdGlvbiByZWZlcmVuY2VzIGJlbG93
IGxpbms6DQo+ID4gaHR0cDovL3d3dy51ZWZpLm9yZy9zaXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291
cmNlcy9BQ1BJXzZfMi5wZGYNCj4gDQo+IEFsc28sIHlvdXIgbWFpbCB3YXMgc2VudCB3aXRob3V0
IGFueSBJbi1SZXBseS1Ubzogb3IgUmVmZXJlbmNlczoNCj4gaGVhZGVycywgbWVhbmluZyBpdCB3
YXMgbm90IHRocmVhZGVkIHRvIGEgMC83IGNvdmVyIGxldHRlciwgYnV0IGluc3RlYWQNCj4gNyBk
aWZmZXJlbnQgdG9wLWxldmVsIHRocmVhZHMuICBUaGF0IG1ha2VzIGl0IGhhcmRlciB0byB0cmFj
ayByZXBsaWVzIHRvIHlvdXINCj4gdGhyZWFkLg0KPiANCj4gLS0NCj4gRXJpYyBCbGFrZSwgUHJp
bmNpcGFsIFNvZnR3YXJlIEVuZ2luZWVyDQo+IFJlZCBIYXQsIEluYy4gICAgICAgICAgICsxLTkx
OS0zMDEtMzI2Ng0KPiBWaXJ0dWFsaXphdGlvbjogIHFlbXUub3JnIHwgbGlidmlydC5vcmcNCg0K
SGkgRXJpYywNClRoYW5rcyBmb3IgeW91ciByZXZpZXdpbmcuDQpJIHdpbGwgY29ycmVjdCB0aGVz
ZSBpc3N1ZXMuDQoNCkppbmdxaSBMaXUNCg==
