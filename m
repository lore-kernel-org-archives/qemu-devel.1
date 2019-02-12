Received: from eggs.gnu.org ([209.51.188.92]:52273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gtNNY-0003oj-8l
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 21:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gtNNL-0006se-QM
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 21:00:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:35380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1gtNN5-0006Ym-B9
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 21:00:32 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 12 Feb 2019 01:59:38 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B7B4E39@SHSMSX103.ccr.corp.intel.com>
References: <20190211165756.GN2627@work-vm>
	<20190211122058-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190211122058-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] virtio-blk io bar size changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "ldoktor@redhat.com" <ldoktor@redhat.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIFttYWlsdG86bXN0QHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDEy
LCAyMDE5IDE6MjMgQU0NCj4gVG86IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgPGRnaWxiZXJ0QHJl
ZGhhdC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IExpdSwgQ2hhbmdwZW5nIDxj
aGFuZ3BlbmcubGl1QGludGVsLmNvbT47DQo+IHN0ZWZhbmhhQHJlZGhhdC5jb207IGxkb2t0b3JA
cmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogdmlydGlvLWJsayBpbyBiYXIgc2l6ZSBjaGFuZ2Vk
DQo+IA0KPiBPbiBNb24sIEZlYiAxMSwgMjAxOSBhdCAwNDo1ODoxOVBNICswMDAwLCBEci4gRGF2
aWQgQWxhbiBHaWxiZXJ0IHdyb3RlOg0KPiA+IEhpLA0KPiA+ICAgTHVrw6HFoSByZXBvcnRlZCB0
aGF0IHRoZXJlJ3MgYSBtaWdyYXRpb24gYnJlYWthZ2UgYmV0d2VlbiAzLjEgYW5kDQo+ID4gY3Vy
cmVudCBoZWFkIHdpdGggdmlydGlvLWJsazsgICBpdCBsb29rcyBsaWtlIHRoZSBpbyBiYXIgY2hh
bmdlcyBmcm9tIDY0DQo+ID4gdG8gMTI4IGJ5dGVzIGFuZCBteSBiaXNlY3Qgc3VnZ2VzdHMgaXQn
czoNCj4gPg0KPiA+IGNvbW1pdCBjYWExZWU0MzEzMWMwNjAzNDdiMzI4OTNhYmQ0MWZlNDg2NWVh
YTJlIChIRUFELCByZWZzL2Jpc2VjdC9iYWQpDQo+ID4gQXV0aG9yOiBDaGFuZ3BlbmcgTGl1IDxj
aGFuZ3BlbmcubGl1QGludGVsLmNvbT4NCj4gPiBEYXRlOiAgIFdlZCBKYW4gMTYgMTM6MTk6MzAg
MjAxOSArMDgwMA0KPiA+DQo+ID4gICAgIHZob3N0LXVzZXItYmxrOiBhZGQgZGlzY2FyZC93cml0
ZSB6ZXJvZXMgZmVhdHVyZXMgc3VwcG9ydA0KPiA+DQo+ID4NCj4gPiBIb3cgZG8gd2UgZml4IHRo
YXQ/DQo+ID4NCj4gPiBEYXZlDQo+IA0KPiBRdWlja2x5IDopDQo+IA0KPiBTZWUgdGhlIGxvZ2lj
IGFyb3VuZCB2aXJ0aW9fbmV0X3NldF9jb25maWdfc2l6ZQ0KPiBhbmQgc3RhdGljIFZpcnRJT0Zl
YXR1cmUgZmVhdHVyZV9zaXplcyAtIHdlIG5lZWQgdG8NCj4gYWRkIHNvbWV0aGluZyBzaW1pbGFy
IHRvIHZpcnRpbyBibGsgbm93Lg0KQ29ycmVjdCwgYWZ0ZXIgdGhpcyBjb21taXQgdGhlIEJBUiBj
b25maWcgc2l6ZSBpcyBjaGFuZ2VkLCBJIHdpbGwgc3VibWl0IGEgcGF0Y2ggdG8gZml4IHRoaXMu
DQo+IA0KPiANCj4gPiAtLQ0KPiA+IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgLyBkZ2lsYmVydEBy
ZWRoYXQuY29tIC8gTWFuY2hlc3RlciwgVUsNCg==
