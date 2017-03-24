Received: from eggs.gnu.org ([2001:4830:134:3::10]:49241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crSI9-00045v-Fy
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crSI3-0005tu-MU
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:42:21 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:17870
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crSI3-0005tD-DC
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:42:15 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 24 Mar 2017 16:42:13 +0000
Message-ID: <1bd386167cff4ef9a281139afb9308dc@AMSPEX02CL03.citrite.net>
References: <20170316141953.16161-1-jgross@suse.com>
	<20170316141953.16161-3-jgross@suse.com>
	<alpine.DEB.2.10.1703161306380.15430@sstabellini-ThinkPad-X260>
	<214bc24d-1c0c-16d6-9c33-e20962b150d2@suse.com>
	<alpine.DEB.2.10.1703171123520.22036@sstabellini-ThinkPad-X260>
	<da852b5f-2490-c483-984d-c7be4f83b9a7@suse.com>
	<alpine.DEB.2.10.1703211152240.11679@sstabellini-ThinkPad-X260>
	<f1f79b77-f3bf-4bb0-135c-802bd5829de5@suse.com>
	<alpine.DEB.2.10.1703221120530.13499@sstabellini-ThinkPad-X260>
	<2fb1da9d14c14eb4826a87657f7d0eb1@AMSPEX02CL03.citrite.net>
	<550ea61e-c9ba-5afc-12b5-438a2a57af6e@suse.com>
	<7208ddd9b76b4196be0a3d3cd12aee71@AMSPEX02CL03.citrite.net>
	<20f2b3ce-218b-4d61-6af1-8c70b751ed18@suse.com>
	<0103d60e-cd96-ab48-70fb-f75ba1273f39@suse.com>
In-Reply-To: <0103d60e-cd96-ab48-70fb-f75ba1273f39@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 2/2] configure: use pkg-config
 for obtaining xen version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Juergen Gross' <jgross@suse.com>, 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KW3NuaXBdDQo+ID4+IFRoYXQncyBhIGNoYW5n
ZSBpbiBiZWhhdmlvdXIgdGhhdCBJLCBhbmQgcHJvYmFibHkgb3RoZXJzLCBoYXZlIGxvbmcgYmVl
bg0KPiB1c2VkIHRvLiBXaGF0IHdlIHJlYWxseSB3YW50LCBwcmVzdW1hYmx5LCBpcyB0byBoYXZl
IHBrZy1jb25maWcganVzdCBsb29rDQo+IHVuZGVyIHRvb2xzL3BrZ2NvbmZpZyB3aGVuIHF1ZXJ5
aW5nIGZvciB0aGUgdmVyc2lvbiBvZiB4ZW5jb250cm9sLiBDb3VsZA0KPiB0aGF0IG5vdCBiZSBk
b25lIGJ5IHNpbXBseSBzZXR0aW5nIFBLR19DT05GSUdfTElCRElSIGluIFFFTVUncyBjb25maWd1
cmUNCj4gc2NyaXB0LCBvciB3b3VsZCBpdCBzdGlsbCBtZWFuIHBpY2tpbmcgdXAgaW5zdGFsbGVk
IGxpYnJhcmllcyBiZWZvcmUgb25lcyBqdXN0DQo+IGJ1aWx0Pw0KPiA+DQo+ID4gSSBndWVzcyB0
aGlzIHdvdWxkIGJyZWFrIHFlbXUncyBjb25maWd1cmUgYmFkbHkgYXMgaXQgd291bGRuJ3QgZmlu
ZCBhbGwNCj4gPiB0aGUgb3RoZXIgbGlicmFyeSBpbmZvcm1hdGlvbnMgaXQgaXMgbG9va2luZyBm
b3IgdmlhIHBrZy1jb25maWcuDQo+IA0KPiBBYWgsIHdhaXQsIHlvdSBtZWFuIGp1c3QgZm9yIHRo
ZSBYZW4gcXVlcnk/DQo+IA0KPiBUaGlzIG1pZ2h0IGNvbXBsaWNhdGUgdGhpbmdzIGZvciBteSBx
ZW11IHN0dWJkb20gcGxhbnMuLi4NCj4gDQoNCkhvdyBhYm91dCB0aGlzIHBhdGNoIHRvIFFFTVUg
Y29uZmlndXJlPw0KDQpkaWZmIC0tZ2l0IGEvY29uZmlndXJlIGIvY29uZmlndXJlDQppbmRleCBm
ZGY0N2U0Li42ZWY1OTgwIDEwMDc1NQ0KLS0tIGEvY29uZmlndXJlDQorKysgYi9jb25maWd1cmUN
CkBAIC0xOTc0LDYgKzE5NzQsMTAgQEAgZmkNCiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMNCiAjIHhlbiBwcm9iZQ0KDQoreGVuX3F1ZXJ5X3BrZ19jb25maWcoKSB7
DQorICAgIFBLR19DT05GSUdfTElCRElSPSAke3BrZ19jb25maWdfZXhlfSAiJEAiDQorfQ0KKw0K
IGlmIHRlc3QgIiR4ZW4iICE9ICJubyIgOyB0aGVuDQogICB4ZW5fbGlicz0iLWx4ZW5zdG9yZSAt
bHhlbmN0cmwgLWx4ZW5ndWVzdCINCiAgIHhlbl9zdGFibGVfbGlicz0iLWx4ZW5mb3JlaWdubWVt
b3J5IC1seGVuZ250dGFiIC1seGVuZXZ0Y2huIg0KQEAgLTE5OTcsOSArMjAwMSw5IEBAIEVPRg0K
ICAgICB4ZW49bm8NCg0KICAgIyBYZW4gdmVyc2lvbiB2aWEgcGtnLWNvbmZpZyAoWGVuIDQuOS4w
IGFuZCBuZXdlcikNCi0gIGVsaWYgJHBrZ19jb25maWcgLS1leGlzdHMgeGVuY29udHJvbCA7IHRo
ZW4NCisgIGVsaWYgeGVuX3F1ZXJ5X3BrZ19jb25maWcgLS1leGlzdHMgeGVuY29udHJvbDsgdGhl
bg0KICAgICB4ZW5fY3RybF92ZXJzaW9uPSIkKHByaW50ZiAnJWQlMDJkJTAyZCcgXA0KLSAgICAg
ICQoJHBrZ19jb25maWcgLS1tb2R2ZXJzaW9uIHhlbmNvbnRyb2wgfCBzZWQgJ3MvXC4vIC9nJykg
KSINCisgICAgICAkKHhlbl9xdWVyeV9wa2dfY29uZmlnIC0tbW9kdmVyc2lvbiB4ZW5jb250cm9s
IHwgc2VkICdzL1wuLyAvZycpICkiDQogICAgIHhlbj15ZXMNCg0KICAgZWxpZg0KQEAgLTIyMTYs
OCArMjIyMCw4IEBAIEVPRg0KICAgICBpZiB0ZXN0ICR4ZW5fY3RybF92ZXJzaW9uIC1nZSA0MDkw
MCA7IHRoZW4NCiAgICAgICB4ZW5fcGM9InhlbmNvbnRyb2wgeGVuc3RvcmUgeGVuZ3Vlc3QgeGVu
Zm9yZWlnbm1lbW9yeSB4ZW5nbnR0YWIgeGVuZXZ0Y2huIg0KICAgICAgIHhlbl9wYz0iJHhlbl9w
YyB4ZW5kZXZpY2Vtb2RlbCINCi0gICAgICB4ZW5fbGlicz0iJCgkcGtnX2NvbmZpZyAtLWxpYnMg
JHhlbl9wYykiDQotICAgICAgUUVNVV9DRkxBR1M9IiRRRU1VX0NGTEFHUyAkKCRwa2dfY29uZmln
IC0tY2ZsYWdzICR4ZW5fcGMpIg0KKyAgICAgIHhlbl9saWJzPSIkKHhlbl9xdWVyeV9wa2dfY29u
ZmlnIC0tbGlicyAkeGVuX3BjKSINCisgICAgICBRRU1VX0NGTEFHUz0iJFFFTVVfQ0ZMQUdTICQo
eGVuX3F1ZXJ5X3BrZ19jb25maWcgLS1jZmxhZ3MgJHhlbl9wYykiDQogICAgIGVsaWYgdGVzdCAk
eGVuX2N0cmxfdmVyc2lvbiAtZ2UgNDA3MDEgOyB0aGVuDQogICAgICAgbGlic19zb2Z0bW11PSIk
eGVuX3N0YWJsZV9saWJzICRsaWJzX3NvZnRtbXUiDQogICAgIGZpDQoNClRoaXMgYXBwZWFycyB0
byBEVFJUIGZvciBtZSB3aGVuIHN3aXRjaGluZyBiZXR3ZWVuIHZlcnNpb25zIG9mIFhlbi4NCg0K
ICBQYXVsDQo=
