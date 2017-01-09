Received: from eggs.gnu.org ([2001:4830:134:3::10]:56421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cQdMy-0002AC-AE
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cQdMu-00062V-5J
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:04:28 -0500
Received: from mta01.ornl.gov ([128.219.177.137]:55196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nutarojj@ornl.gov>) id 1cQdMt-00060n-S9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:04:24 -0500
From: "Nutaro, James J." <nutarojj@ornl.gov>
Date: Mon, 9 Jan 2017 17:04:19 +0000
Message-ID: <283fd6b709734ccdbeb6d217f8b32043@EXCHCS32.ornl.gov>
References: <1483628868-10496-1-git-send-email-nutarojj@ornl.gov>
	<0f3d6652-e633-c02e-7234-0d5b885d31ea@redhat.com>
In-Reply-To: <0f3d6652-e633-c02e-7234-0d5b885d31ea@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6] qqq: module for synchronizing with a
 simulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

VGhhbmtzIGFnYWluIFBhb2xvLiBXaGVuIEkgY2hhbmdlIHRoZSBjb21tYW5kIGxpbmUgc3dpdGNo
ZXMsIGlzIGl0IGJlc3QgdG8gc3VibWl0IGEgd2hvbGUgbmV3IHZlcnNpb24gb2YgdGhlIHBhdGNo
PyBPciBpcyB0aGVyZSBhbm90aGVyIG1ldGhvZCBmb3IgbWFuYWdpbmcgcGF0Y2ggcmV2aXNpb25z
Pw0KDQpUaGFua3MsDQoNCkppbQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
UGFvbG8gQm9uemluaSBbbWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dIA0KU2VudDogVGh1cnNk
YXksIEphbnVhcnkgMDUsIDIwMTcgMTA6MjcgQU0NClRvOiBOdXRhcm8sIEphbWVzIEouOyBxZW11
LWRldmVsQG5vbmdudS5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjZdIHFxcTogbW9kdWxlIGZv
ciBzeW5jaHJvbml6aW5nIHdpdGggYSBzaW11bGF0aW9uDQoNCg0KDQpPbiAwNS8wMS8yMDE3IDE2
OjA3LCBKYW1lcyBKLiBOdXRhcm8gd3JvdGU6DQo+IFRoaXMgcGF0Y2ggYWRkcyBhbiBpbnRlcmZh
Y2UgZm9yIHBhY2luZyB0aGUgZXhlY3V0aW9uIG9mIFFFTVUgdG8gbWF0Y2ggYW4gZXh0ZXJuYWwN
Cj4gc2ltdWxhdGlvbiBjbG9jay4gSXRzIGFpbSBpcyB0byBwZXJtaXQgUUVNVSB0byBiZSB1c2Vk
IGFzIGEgbW9kdWxlIHdpdGhpbiBhDQo+IGxhcmdlciBzaW11bGF0aW9uIHN5c3RlbS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEphbWVzIEouIE51dGFybyA8bnV0YXJvampAb3JubC5nb3Y+DQoNCldo
YXQncyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHY1IGFuZCB2Nj8NCg0KPiArKDIpIEZvcmsgUUVN
VSB3aXRoIHRoZSBhcHByb3ByaWF0ZSBjb21tYW5kIGxpbmUgYXJndW1lbnRzLg0KPiArICAgIFRo
ZSAtcXFxIHBhcnQgb2YgdGhlIGFyZ3VtZW50IHdpbGwgbG9vayBzb21ldGhpbmcgbGlrZQ0KPiAr
DQo+ICsgICAgICAgLXFxcSBzb2NrPXNvY2tzWzFdDQoNCk5vIG5lZWQgZm9yIC1xcXEsIGp1c3Qg
bWFrZSBpdCAiLWljb3VudCBleHRjbG9jaz1GRCIuDQoNClBhb2xvDQoNCg==
