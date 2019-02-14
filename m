Received: from eggs.gnu.org ([209.51.188.92]:55954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1guBYc-000666-Bp
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 02:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1guBYa-00017L-8h
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 02:35:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:23491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1guBYZ-0000un-SU
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 02:35:40 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Thu, 14 Feb 2019 07:35:20 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19C9402DA@SHSMSX104.ccr.corp.intel.com>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<1548824953-23413-3-git-send-email-yi.y.sun@linux.intel.com>
	<20190212062728.GK1011@xz-x1> <20190213090041.GF16968@yi.y.sun>
	<20190213104224.GA4405@xz-x1> <20190214015204.GG16968@yi.y.sun>
	<20190214032435.GA3197@xz-x1> <20190214062730.GH16968@yi.y.sun>
	<20190214071330.GA9932@xz-x1>
In-Reply-To: <20190214071330.GA9932@xz-x1>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1 2/3] intel_iommu: add 256 bits qi_desc
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Yi Sun <yi.y.sun@linux.intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVy
c2RheSwgRmVicnVhcnkgMTQsIDIwMTkgMzoxNCBQTQ0KPiANCj4gPg0KPiA+ID4gV2hlbiAyNTYg
Yml0cyBpbnZhbGlkYXRpb24gZGVzY3JpcHRvciBpcyB1c2VkLCB0aGUgZ3Vlc3QgZHJpdmVyDQo+
ID4gPiBzaG91bGQgYmUgcmVzcG9uc2libGUgdG8gZmlsbCBpbiB6ZXJvcyBpbnRvIHJlc2VydmVk
IGZpZWxkcy4NCj4gPiA+DQo+ID4gPiBBbm90aGVyIHF1ZXN0aW9uOiBpcyB2YWxbMl0gJiB2YWxb
M10gdXNlZCBpbiBhbnkgcGxhY2UgZXZlbiB3aXRoDQo+ID4gPiAyNTZiaXRzIG1vZGU/ICBGcm9t
IHdoYXQgSSBzZWUgZnJvbSB0aGUgc3BlYyAoY2hhcCA2LjUuMiksIGFsbCBvZiB0aGVtDQo+ID4g
PiBzZWVtcyB0byBiZSByZXNlcnZlZCBhcyB6ZXJvcywgdGhlbiBJIGRvbid0IHVuZGVyc3RhbmQg
d2h5IGJvdGhlcg0KPiA+ID4gZXh0ZW5kaW5nIHRoaXMgdG8gMjU2Yml0cy4uLiAgRGlkIEkgbWlz
cyBzb21ldGhpbmc/DQo+ID4gPg0KDQpQUlEgaXMgZXh0ZW5kZWQgdG8gY2FycnkgbGFyZ2VyIHBy
aXZhdGUgZGF0YSB3aGljaCByZXF1aXJlcyAyNTZiaXRzDQptb2RlLiBZb3UgY2FuIHRha2UgYSBs
b29rIGF0IDcuNS4xLjEgUGFnZSBSZXF1ZXN0IERlc2NyaXB0b3IuDQoNClRoYW5rcw0KS2V2aW4N
Cg0K
