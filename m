Received: from eggs.gnu.org ([2001:4830:134:3::10]:39626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1er99S-0001AR-OX
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1er99P-0001ld-Ax
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:20:38 -0500
Received: from mail-dm3nam03on0064.outbound.protection.outlook.com
	([104.47.41.64]:31232
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1er99P-0001kK-2z
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:20:35 -0500
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Wed, 28 Feb 2018 21:20:32 +0000
Message-ID: <CY4PR12MB17689DD425516CB53270EE6995C70@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
	<1519439425-27883-2-git-send-email-babu.moger@amd.com>
	<20180228173813.GA8418@flask>
	<8df70311-a3fd-f27f-6054-9076fc3f23e3@redhat.com>
In-Reply-To: <8df70311-a3fd-f27f-6054-9076fc3f23e3@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/5] target/i386: Fix a minor typo found
 while reviwing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "Hook,
	Gary" <Gary.Hook@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "pixo@polepetko.eu" <pixo@polepetko.eu>, "rth@twiddle.net" <rth@twiddle.net>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEVyaWMgQmxha2UgW21haWx0
bzplYmxha2VAcmVkaGF0LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyOCwgMjAx
OCAxMjo0OSBQTQ0KPiBUbzogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhhdC5jb20+OyBN
b2dlciwgQmFidQ0KPiA8QmFidS5Nb2dlckBhbWQuY29tPg0KPiBDYzogZWhhYmtvc3RAcmVkaGF0
LmNvbTsga3ZtQHZnZXIua2VybmVsLm9yZzsgbXRvc2F0dGlAcmVkaGF0LmNvbTsNCj4gSG9vaywg
R2FyeSA8R2FyeS5Ib29rQGFtZC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IHBib256
aW5pQHJlZGhhdC5jb207IHBpeG9AcG9sZXBldGtvLmV1OyBydGhAdHdpZGRsZS5uZXQNCj4gU3Vi
amVjdDogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjIgMS81XSB0YXJnZXQvaTM4NjogRml4IGEg
bWlub3IgdHlwbw0KPiBmb3VuZCB3aGlsZSByZXZpd2luZw0KPiANCj4gT24gMDIvMjgvMjAxOCAx
MTozOCBBTSwgUmFkaW0gS3LEjW3DocWZIHdyb3RlOg0KPiA+IDIwMTgtMDItMjMgMjE6MzAtMDUw
MCwgQmFidSBNb2dlcjoNCj4gDQo+IEluIHRoZSBzdWJqZWN0IGxpbmU6IHMvcmV2aXdpbmcvcmV2
aWV3aW5nLyAgW0l0J3MgbmV2ZXIgYSBnb29kIHNpZ24gd2hlbg0KPiBhIGZpeCBjbGFpbWluZyB0
byBmaXggYSB0eXBvIGludHJvZHVjZXMgYSB0eXBvIDspIF0NCg0KR29vZCBjYXRjaCBFcmljLiBT
b3JyeSBhYm91dCB0aGF0LiAgV2UgZG9u4oCZdCBuZWVkIHRoaXMgcGF0Y2ggYW55bW9yZS4gVGhh
bmtzLg0KDQo+IA0KPiBPciBnbyBmb3IgYSBzaG9ydGVyIHN1YmplY3Q6DQo+ICAgdGFyZ2V0L2kz
ODY6IEZpeCBhIG1pbm9yIHR5cG8NCj4gDQo+ID4+IENoYW5nZWQgS1ZNX0NQVUlEX0ZMQUdfU0lH
TklGQ0FOVF9JTkRFWCB0bw0KPiBLVk1fQ1BVSURfRkxBR19TSUdOSUZJQ0FOVF9JTkRFWA0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQo+
ID4+IC0tLQ0KPiAtLQ0KPiBFcmljIEJsYWtlLCBQcmluY2lwYWwgU29mdHdhcmUgRW5naW5lZXIN
Cj4gUmVkIEhhdCwgSW5jLiAgICAgICAgICAgKzEtOTE5LTMwMS0zMjY2DQo+IFZpcnR1YWxpemF0
aW9uOiAgcWVtdS5vcmcgfCBsaWJ2aXJ0Lm9yZw0K
