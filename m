Received: from eggs.gnu.org ([2001:4830:134:3::10]:35095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dPizs-0006Aj-T7
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 01:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dPizn-0004nz-WA
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 01:25:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:22882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dPizn-0004np-N5
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 01:25:03 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Tue, 27 Jun 2017 05:24:31 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73926AF68@shsmsx102.ccr.corp.intel.com>
References: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
	<031ae7b1-9e6a-955e-2d6a-13ed62eb9bd9@redhat.com>
In-Reply-To: <031ae7b1-9e6a-955e-2d6a-13ed62eb9bd9@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/2] virtio-net: enable configurable tx
 queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "stefanha@gmail.com" <stefanha@gmail.com>

T24gVHVlc2RheSwgSnVuZSAyNywgMjAxNyA5OjUxIEFNLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBP
biAwNi8yMi8yMDE3IDA5OjMyIFBNLCBXZWkgV2FuZyB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGVu
YWJsZXMgdGhlIHZpcnRpby1uZXQgdHggcXVldWUgc2l6ZSB0byBiZSBjb25maWd1cmFibGUgDQo+
ID4gYmV0d2VlbiAyNTYgKHRoZSBkZWZhdWx0IHF1ZXVlIHNpemUpIGFuZCAxMDI0IGJ5IHRoZSB1
c2VyIHdoZW4gdGhlIA0KPiA+IHZob3N0LXVzZXIgYmFja2VuZCBpcyB1c2VkLg0KPiANCj4gV2hl
biBzZW5kaW5nIGEgbXVsdGktcGF0Y2ggc2VyaWVzLCBkb24ndCBmb3JnZXQgdGhlIDAvMiBjb3Zl
ciBsZXR0ZXIuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSByZW1pbmRlciwgYW5kIEknbGwgZG8gaXQg
aW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCwNCldlaSANCg==
