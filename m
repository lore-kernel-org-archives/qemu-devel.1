Received: from eggs.gnu.org ([2001:4830:134:3::10]:52734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dLCF4-0003Di-5B
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dLCF1-0006fU-06
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:38:06 -0400
Received: from us-smtp-delivery-101.mimecast.com ([216.205.24.101]:55151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dLCF0-0006dq-Nl
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:38:02 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 14 Jun 2017 17:37:55 +0000
Message-ID: <82A46075-1FA0-400D-A52B-85233A888F9A@nutanix.com>
References: <1497458486-15673-1-git-send-email-felipe@nutanix.com>
	<CAJ+F1CLKvSywR1EN8LXaCd7S1Ya0gebE25QYBWfK4LW2Nmm2=g@mail.gmail.com>
In-Reply-To: <CAJ+F1CLKvSywR1EN8LXaCd7S1Ya0gebE25QYBWfK4LW2Nmm2=g@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH] vhost-user: support cross-endianess
 negatiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mike Cui <cui@nutanix.com>, QEMU Developers <qemu-devel@nongnu.org>

SGVsbG8hDQoNCk9uIDE0IEp1biAyMDE3LCBhdCAxODoxNywgTWFyYy1BbmRyw6kgTHVyZWF1IDxt
YXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbTxtYWlsdG86bWFyY2FuZHJlLmx1cmVhdUBnbWFpbC5j
b20+PiB3cm90ZToNCg0KSA0KDQpPbiBXZWQsIEp1biAxNCwgMjAxNyBhdCA4OjQyIFBNIEZlbGlw
ZSBGcmFuY2lvc2kgPGZlbGlwZUBudXRhbml4LmNvbTxtYWlsdG86ZmVsaXBlQG51dGFuaXguY29t
Pj4gd3JvdGU6DQoNCi4uLg0KQEAgLTU4MCw2ICs1ODEsMTkgQEAgTWFzdGVyIG1lc3NhZ2UgdHlw
ZXMNCiAgICAgICBUaGlzIHJlcXVlc3Qgc2hvdWxkIGJlIHNlbmQgb25seSB3aGVuIFZJUlRJT19G
X0lPTU1VX1BMQVRGT1JNIGZlYXR1cmUNCiAgICAgICBoYXMgYmVlbiBzdWNjZXNzZnVsbHkgbmVn
b3RpYXRlZC4NCg0KKyAqIFZIT1NUX1VTRVJfU0VUX1ZSSU5HX0VORElBTg0KKw0KKyAgICAgIElk
OiAyMg0KKyAgICAgIEVxdWl2YWxlbnQgaW9jdGw6IFZIT1NUX1NFVF9WUklOR19FTkRJQU4NCisg
ICAgICBNYXN0ZXIgcGF5bG9hZDogdnJpbmcgc3RhdGUgZGVzY3JpcHRpb24NCisNCisgICAgICBT
ZXQgdGhlIGVuZGlhbmVzcyBvZiBhIFZRIGZvciBsZWdhY3kgZGV2aWNlcy4gQmlnLWVuZGlhbiBp
cyBpbmRpY2F0ZWQNCisgICAgICB3aXRoIHN0YXRlLm51bSBzZXQgdG8gdHJ1ZSwgYW5kIGxpdHRs
ZS1lbmRpYW4gaXMgaW5kaWNhdGVkIHdpdGggc3RhdGUubnVtDQorICAgICAgc2V0IHRvIGZhbHNl
Lg0KKyAgICAgIFRoaXMgcmVxdWVzdCBzaG91bGQgYmUgc2VudCBvbmx5IHdoZW4gVkhPU1RfVVNF
Ul9QUk9UT0NPTF9GX0NST1NTX0VORElBTg0KKyAgICAgIGhhcyBiZWVuIG5lZ290aWF0ZWQuDQoN
CkFuZCBpdCBjYW4gYmUgc2VudCBhdCBhbnkgdGltZT8gbXVsdGlwbGUgdGltZXM/IERvIHdlIGV4
cGVjdCB0aGUgYmFja2VuZCB0byBoYW5kbGUgYW55IGVuZGlhbmVzcz8NCg0KVGhhbmtzIGZvciB0
aGUgZmVlZGJhY2suIEkgdHJpZWQgdG8gd3JpdGUgdGhlIGRvY3MgdG8gdGhlIHNhbWUgbGV2ZWwg
b2YgZGV0YWlsIG9mIHRoZSBvdGhlciBtZXNzYWdlcywgYnV0IGFncmVlIHRoYXQgd2Ugc2hvdWxk
IHN0YXJ0IHRvIG1ha2UgYW4gZWZmb3J0IHRvIGhhdmUgbW9yZSBlbGFib3JhdGUgZG9jdW1lbnRh
dGlvbi4gSSdsbCBhZGRyZXNzIHlvdXIgcXVlc3Rpb25zIG9uIHRoZSBzcGVjIGFuZCBzZW5kIGEg
djIuDQoNCkkgYWxzbyBub3RpY2VkIHRoZSAiaWQiIGFib3ZlIChvbiB0aGUgZG9jKSBzaG91bGQg
YmUgMjMuDQoNClRoYW5rcywNCkZlbGlwZQ0K
