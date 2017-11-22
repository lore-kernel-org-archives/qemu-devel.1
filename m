Received: from eggs.gnu.org ([2001:4830:134:3::10]:54734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eHKla-0006kk-9t
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 21:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eHKlW-0000YW-Ac
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 21:27:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:38666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eHKlW-0000WS-22
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 21:27:54 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Wed, 22 Nov 2017 02:27:43 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5DFC0E@SHSMSX103.ccr.corp.intel.com>
References: <1510865080-32027-1-git-send-email-changpeng.liu@intel.com>
	<1510865080-32027-2-git-send-email-changpeng.liu@intel.com>
	<20171120162631.GK4516@stefanha-x1.localdomain>
	<20171120224001-mutt-send-email-mst@kernel.org>
	<776f5005-8bb8-773a-1f16-56b5675e7d74@redhat.com>
In-Reply-To: <776f5005-8bb8-773a-1f16-56b5675e7d74@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDIx
LCAyMDE3IDg6MTYgQU0NCj4gVG86IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+
OyBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQGdtYWlsLmNvbT4NCj4gQ2M6IExpdSwgQ2hhbmdw
ZW5nIDxjaGFuZ3BlbmcubGl1QGludGVsLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4g
bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tOyBmZWxpcGVAbnV0YW5peC5jb207IEhhcnJpcywg
SmFtZXMgUg0KPiA8amFtZXMuci5oYXJyaXNAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDEvNF0gdmhvc3QtdXNlcjogYWRkIG5ldyB2aG9zdCB1c2VyIG1lc3NhZ2VzIHRvIHN1
cHBvcnQNCj4gdmlydGlvIGNvbmZpZyBzcGFjZQ0KPiANCj4gT24gMjAvMTEvMjAxNyAyMTo0NCwg
TWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiA+IExpdmUgbWlncmF0aW9ucyBpcyBzdXBwb3Nl
ZCB0byBiZSBtaWdyYXRpbmcgZ3Vlc3Qgd3JpdGVhYmxlIHN0YXRlIHRvby4NCj4gPiBJZiB5b3Ug
bWVhbiBtaWdyYXRpbmcgUk8gZmllbGRzIGxpa2Ugc2l6ZSwgdGhlbg0KPiA+IEkgZG9uJ3QgdGhp
bmsgaXQncyBhIGdvb2QgaWRlYSB0byByZXVzZSBTRVRfQ09ORklHIGZvciB0aGF0Lg0KPiA+IFNF
VF9DT05GSUcgc2hvdWxkIG9iZXkgZXhhY3RseSB0aGUgdmlydGlvIHNlbWFudGljcy4NCj4gPg0K
PiA+IEFuZCBJIGFncmVlLCBpdCBzaG91bGQgc2F5IHRoYXQgc2xhdmUgbXVzdCB0cmVhdCBpdCBh
cyBhIHdyaXRlLA0KPiA+IGFuZCBnZXQgY29uZmlnIGFzIGEgcmVhZCBhY2NvcmRpbmcgdG8gdmly
dGlvIHNlbWFudGljcy4NCj4gPg0KPiA+IElmIHNvbWVvbmUgbmVlZHMgdG8gcGFzcyBjb25maWd1
cmF0aW9uIGZyb20gcWVtdSB0bw0KPiA+IHNsYXZlLCBsZXQncyBhZGQgc3BlY2lmaWMgbWVzc2Fn
ZXMgd2l0aCBwcmVjaXNlbHkgZGVmaW5lZCBzZW1hbnRpY3MuDQo+IA0KPiBGYWlyIGVub3VnaCwg
YnV0IEknZCBhZGQgbmV2ZXJ0aGVsZXNzIGEgMzItYml0IGZsYWdzIGZpZWxkIHRvIGJvdGgNCj4g
R0VUX0NPTkZJRyBhbmQgU0VUX0NPTkZJRywgYW5kIGRvY3VtZW50IHRoYXQgdGhlIHNsYXZlIE1V
U1QgY2hlY2sgdGhhdA0KPiBpdCBpcyB6ZXJvIGFuZCBvdGhlcndpc2UgZmFpbC4NCk9rLg0KPiAN
Cj4gUGFvbG8NCg==
