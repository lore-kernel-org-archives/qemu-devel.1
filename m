Received: from eggs.gnu.org ([2001:4830:134:3::10]:58071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fBElv-00030Z-F5
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 03:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fBEls-0001qb-AF
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 03:23:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:31863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1fBEls-0001p8-0H
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 03:23:20 -0400
From: "Zhang, Tina" <tina.zhang@intel.com>
Date: Wed, 25 Apr 2018 07:23:09 +0000
Message-ID: <237F54289DF84E4997F34151298ABEBC7C7E69D4@SHSMSX101.ccr.corp.intel.com>
References: <1524471278-22546-1-git-send-email-tina.zhang@intel.com>
	<1524471278-22546-3-git-send-email-tina.zhang@intel.com>
	<20180423131202.zcyam25lkh7khbil@sirius.home.kraxel.org>
	<237F54289DF84E4997F34151298ABEBC7C7E5046@SHSMSX101.ccr.corp.intel.com>
	<20180424081615.qx7d3ssemk3lothw@sirius.home.kraxel.org>
In-Reply-To: <20180424081615.qx7d3ssemk3lothw@sirius.home.kraxel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] ui: introduce vfio_display_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Yuan, Hang" <hang.yuan@intel.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogaW50ZWwtZ3Z0LWRldiBb
bWFpbHRvOmludGVsLWd2dC1kZXYtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmddIE9uDQo+
IEJlaGFsZiBPZiBHZXJkIEhvZmZtYW5uDQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDI0LCAyMDE4
IDQ6MTYgUE0NCj4gVG86IFpoYW5nLCBUaW5hIDx0aW5hLnpoYW5nQGludGVsLmNvbT4NCj4gQ2M6
IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBpbnRlbC1ndnQtZGV2QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsgcWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZzsgemhlbnl1d0BsaW51eC5pbnRlbC5j
b207IFl1YW4sIEhhbmcNCj4gPGhhbmcueXVhbkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMi8yXSB1aTogaW50cm9kdWNlIHZmaW9fZGlzcGxheV9yZXNldA0KPiANCj4gICBIaSwN
Cj4gDQo+ID4gQWZ0ZXIgcmV2aWV3aW5nIHRoaXMgcGF0Y2gtc2V0IGFnYWluLCBJIHRoaW5rIHdl
IG1pZ2h0IG5vdCBuZWVkIHRoZQ0KPiA+IHByb3Bvc2VkIGRweV9nZnhfc3dpdGNoX3N1cmZhY2Uo
KSBhbnkgbW9yZS4gIFRoZSByZWFzb24gSSBwcm9wb3NlZCBpdA0KPiA+IHdhcyBiZWNhdXNlIEkg
dGhvdWdodCBnZnguZHMgaXMgY2hhbmdlZCB0byB0aGUgc3VyZmFjZSByZWxhdGVkIHRvDQo+ID4g
Z3Vlc3QgZG1hLWJ1ZiBmcmFtZWJ1ZmZlciBhbmQgd2UgbmVlZCB0byBzd2l0Y2ggaXQgd2l0aCBR
ZW11Q29uc29sZSdzDQo+ID4gRGlzcGxheVN1cmdmYWNlIGR1cmluZyByZXNldC4gIEJ1dCBhZnRl
ciByZXZpZXdpbmcgdGhlIGNvZGUsDQo+ID4gdmMtPmdmeC5kcyBpcyBhbHdheXMgcG9pbnRpbmcg
dG8gdGhlIHZhbGlkIFFlbXVDb25zb2xlcycNCj4gPiBEaXNwbGF5U3VyZmFjZS4gU28gd2UgZG9u
4oCZdCBuZWVkIGRweV9nZnhfc3dpdGNoX3N1cmZhY2UoKSB0byB0YWtlIGNhcmUNCj4gPiBvZiBp
dC4NCj4gDQo+IEdvb2QsIHRoaXMgaXMgd2hhdCBJIGV4cGVjdGVkLg0KPiANCj4gPiA+IE1heWJl
IHlvdSBqdXN0IG5lZWQgYSBmdWxsIGRpc3BsYXkgdXBkYXRlIGFmdGVyIGRpc2FibGluZyB0aGUg
Z2wNCj4gPiA+IHNjYW5vdXQ/DQo+ID4gRG8geW91IHN0aWxsIHRoaW5rIHVwZGF0aW5nIGZ1bGwg
ZGlzcGxheSBpcyBuZWVkZWQ/DQo+IA0KPiBJdCBjZXJ0YWlubHkgaXNuJ3QgcmVxdWlyZWQsIGd0
ayB3b3VsZG4ndCBhY2Nlc3MgdGhlIGRtYS1idWYgYW55IG1vcmUgYWZ0ZXINCj4gc2Nhbm91dF9k
aXNhYmxlKCkuDQo+IA0KPiBXaXRob3V0IGRpc3BsYXkgdXBkYXRlIHRoZSBsYXN0IGd1ZXN0IGRp
c3BsYXkgbWF5IHJlbWFpbiB2aXNpYmxlIHVudGlsIHRoZSBndWVzdA0KPiByZWxvYWRzIHRoZSBk
cml2ZXIgdGhvdWdoLiAgV2l0aCBkaXNwbGF5IHVwZGF0ZSB0aGUgZ3RrIHVpIHNob3VsZCBzaG93
IHRoZQ0KPiAoYmxhbmspIERpc3BsYXlTdXJmYWNlIGluc3RlYWQuICBTbyBpdCBpcyBtb3JlIGNv
c21ldGljYWwuDQpJbmRlZWQuIFRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLiBJIHdpbGwgc2VuZCBv
dXQgdGhlIG5leHQgdmVyc2lvbiBvZiB0aGlzIHBhdGNoLXNldC4NClRoYW5rcy4NCg0KQlIsDQpU
aW5hDQo+IA0KPiBjaGVlcnMsDQo+ICAgR2VyZA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gaW50ZWwtZ3Z0LWRldiBtYWlsaW5nIGxpc3QN
Cj4gaW50ZWwtZ3Z0LWRldkBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1ndnQtZGV2DQo=
