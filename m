Received: from eggs.gnu.org ([209.51.188.92]:39444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2c5-0002ai-8k
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2c4-0006v2-7y
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:30:17 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 29 Apr 2019 09:30:07 +0000
Message-ID: <2bc77854-242f-87a7-b09d-7f23dbec108f@virtuozzo.com>
References: <20190426221528.30293-1-jsnow@redhat.com>
	<20190426221528.30293-3-jsnow@redhat.com>
In-Reply-To: <20190426221528.30293-3-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3845AC2D2D8BE40AF1E10CBF2576A02@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 2/2] docs/interop/bitmaps: rewrite and
 modernize doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kchamart@redhat.com" <kchamart@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "aliang@redhat.com" <aliang@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, Fam Zheng <fam@euphon.net>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>

MjcuMDQuMjAxOSAxOjE1LCBKb2huIFNub3cgd3JvdGU6DQo+IFRoaXMganVzdCBhYm91dCByZXdy
aXRlcyB0aGUgZW50aXJldHkgb2YgdGhlIGJpdG1hcHMucnN0IGRvY3VtZW50IHRvDQo+IG1ha2Ug
aXQgY29uc2lzdGVudCB3aXRoIHRoZSA0LjAgcmVsZWFzZS4gSSBoYXZlIGFkZGVkIG5ldyBmZWF0
dXJlcyBzZWVuDQo+IGluIHRoZSA0LjAgcmVsZWFzZSwgYXMgd2VsbCBhcyB0cmllZCB0byBjbGFy
aWZ5IHNvbWUgcG9pbnRzIHRoYXQga2VlcA0KPiBjb21pbmcgdXAgd2hlbiBkaXNjdXNzaW5nIHRo
aXMgZmVhdHVyZSBib3RoIGluLWhvdXNlIGFuZCB1cHN0cmVhbS4NCj4gDQo+IFllcywgaXQncyBh
IGxvdCBsb25nZXIsIG1vc3RseSBkdWUgdG8gZXhhbXBsZXMuIEkgZ2V0IGEgYml0IGNoYXR0eS4N
Cj4gSSBjb3VsZCB1c2UgYSBnb29kIGVkaXRvciB0byBoZWxwIHJlaWduIGluIG15IGNoYXR0aW5l
c3MuDQo+IA0KPiBJdCBkb2VzIG5vdCB5ZXQgY292ZXIgcHVsbCBiYWNrdXBzIG9yIG1pZ3JhdGlv
biBkZXRhaWxzLCBidXQgSSBpbnRlbmQgdG8NCj4ga2VlcCBleHRlbmRpbmcgdGhpcyBkb2N1bWVu
dCB0byBjb3ZlciB0aG9zZSBjYXNlcy4NCj4gDQo+IFBsZWFzZSB0cnkgY29tcGlsaW5nIGl0IHdp
dGggc3BoaW54IGFuZCBsb29rIGF0IHRoZSByZW5kZXJlZCBvdXRwdXQsIEkNCj4gZG9uJ3QgaGF2
ZSBob3N0aW5nIHRvIHNoYXJlIG15IGNvcHkgYXQgcHJlc2VudC4gSSB0aGluayB0aGlzIG5ldyBs
YXlvdXQNCj4gcmVhZHMgbmljZXIgaW4gdGhlIEhUTUwgZm9ybWF0IHRoYW4gdGhlIG9sZCBvbmUg
ZGlkLCBhdCB0aGUgZXhwZW5zZSBvZg0KPiBsb29raW5nIGxlc3MgcmVhZGFibGUgaW4gdGhlIHNv
dXJjZSB0cmVlIGl0c2VsZiAodGhvdWdoIG5vdCBjb21wbGV0ZWx5DQo+IHVubWFuYWdhYmxlLiBX
ZSBkaWQgZGVjaWRlIHRvIGNvbnZlcnQgaXQgZnJvbSBNYXJrZG93biB0byBSZVNULCBhZnRlcg0K
PiBhbGwsIHNvIEkgYW0gZ29pbmcgYWxsLWluIG9uIFJlU1QuKQ0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSm9obiBTbm93PGpzbm93QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==
