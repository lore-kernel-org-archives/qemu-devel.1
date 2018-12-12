Received: from eggs.gnu.org ([2001:4830:134:3::10]:33150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=877c75a5a=Paul.Durrant@citrix.com>)
	id 1gX0iu-00075K-KL
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=877c75a5a=Paul.Durrant@citrix.com>)
	id 1gX0it-00086e-Oi
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:22:32 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 12 Dec 2018 09:22:23 +0000
Message-ID: <c3e4bfee4a904eccb2be812a7f9eb641@AMSPEX02CL03.citrite.net>
References: <154115285434.11300.8459925605672823399.stgit@dhcp-3-135.uk.xensource.com>
	<20181102110412.GD7521@dhcp-200-186.str.redhat.com>
	<20181212085951.GA7604@aepfle.de>
In-Reply-To: <20181212085951.GA7604@aepfle.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Xen-devel] xen_disk qdevification (was: [PATCH
 0/3] Performance improvements for xen_disk v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Olaf Hering' <olaf@aepfle.de>, Kevin Wolf <kwolf@redhat.com>
Cc: Tim Smith <tim.smith@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbGFmIEhlcmluZyBbbWFpbHRv
Om9sYWZAYWVwZmxlLmRlXQ0KPiBTZW50OiAxMiBEZWNlbWJlciAyMDE4IDA5OjAwDQo+IFRvOiBL
ZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPg0KPiBDYzogVGltIFNtaXRoIDx0aW0uc21pdGhA
Y2l0cml4LmNvbT47IFN0ZWZhbm8gU3RhYmVsbGluaQ0KPiA8c3N0YWJlbGxpbmlAa2VybmVsLm9y
Zz47IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsgYXJtYnJ1QHJlZGhhdC5jb207IHFlbXUtDQo+IGRl
dmVsQG5vbmdudS5vcmc7IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+OyBQYXVsIER1cnJh
bnQNCj4gPFBhdWwuRHVycmFudEBjaXRyaXguY29tPjsgQW50aG9ueSBQZXJhcmQgPGFudGhvbnku
cGVyYXJkQGNpdHJpeC5jb20+Ow0KPiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcNCj4g
U3ViamVjdDogUmU6IFtYZW4tZGV2ZWxdIHhlbl9kaXNrIHFkZXZpZmljYXRpb24gKHdhczogW1BB
VENIIDAvM10NCj4gUGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzIGZvciB4ZW5fZGlzayB2MikNCj4g
DQo+IE9uIEZyaSwgTm92IDAyLCBLZXZpbiBXb2xmIHdyb3RlOg0KPiANCj4gPiBBIHdoaWxlIGFn
bywgYSBkb3duc3RyZWFtIHBhdGNoIHJldmlldyBmb3VuZCBvdXQgdGhhdCB0aGVyZSBhcmUgc29t
ZSBRTVANCj4gPiBjb21tYW5kcyB0aGF0IHdvdWxkIGltbWVkaWF0ZWx5IGNyYXNoIGlmIGEgeGVu
X2Rpc2sgZGV2aWNlIHdlcmUgcHJlc2VudA0KPiA+IGJlY2F1c2Ugb2YgdGhlIGxhY2tpbmcgcWRl
dmlmaWNhdGlvbi4gVGhpcyBpcyBub3QgdGhlIGNvZGUgcXVhbGl0eQ0KPiA+IHN0YW5kYXJkIEkg
ZW52aXNpb24gZm9yIFFFTVUuIEl0J3MgdGltZSBmb3Igbm9uLXFkZXYgZGV2aWNlcyB0byBnby4N
Cj4gDQo+IERvIHlvdSBoYXZlIHRoYXQgYmFja3dhcmRzIGJ5IGFueSBjaGFuY2U/IElNTyB0aGUg
cHJlc2VuY2Ugb2YgYXNzZXJ0KCkNCj4gY29udHJpYnV0ZXMgdG8gYmFkIGNvZGUgcXVhbGl0eSwg
bm90IHRoZSBkcml2ZXJzIHRoYXQgdHJpZ2dlciB0aG9zZQ0KPiBhc3NlcnRzLiBJdCBpcyBiYWQg
ZW5vdWdoIHRoYXQgdHdvIFFFTVUgcmVsZWFzZXMgd2VudCBvdXQgd2hpbGUgYmVpbmcgaW4NCj4g
YmFkIHNoYXBlLg0KPiANCj4gQW55d2F5LCBob3BlZnVsbHkgUGF1bCBvciB3aG9ldmVyIHdpbGwg
ZmluZCB0aGUgdGltZSBhbmQgZW5lcmd5IHRvDQo+IGNvbnZlcnQgdGhlIGNvZGUgYXQgc29tZSBw
b2ludC4NCg0KSXQncyBkb25lLiBWNCBvZiBteSBzZXJpZXMgaGFzIGFja3MgZnJvbSB0aGUgWGVu
IG1haW50YWluZXJzLiBJIHRoaW5rIGl0IG5lZWRzIHNvbWUgb3RoZXIgYWNrcyBmcm9tIGJsb2Nr
IG1haW50YWluZXJzIGJ1dCBpdCdzIGJhc2ljYWxseSByZWFkeSB0byBnbyBpbiAoYW5kIEkndmUg
dmVyaWZpZWQgdGhhdCBubyBhc3NlcnQgaXMgdHJpcHBlZCBieSB4ZW50b3AgYXQgbGVhc3QpLiBB
bHNvIEkgaG9wZSB0byBwb3N0IHRoZSByZS1iYXNlZCBwYXRjaGVzIGZyb20gVGltIChvbmUgb2Yg
d2hpY2ggZml4ZXMgdGhlIG1lbW9yeSBpc3N1ZXMpIGxhdGVyIHRvZGF5Lg0KDQogIFBhdWwNCg0K
PiANCj4gT2xhZg0K
