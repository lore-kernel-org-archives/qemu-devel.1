Received: from eggs.gnu.org ([2001:4830:134:3::10]:42875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cPAjO-0001oF-3S
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cPAjK-0005Co-Sd
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:17:34 -0500
Received: from mta01.ornl.gov ([128.219.177.137]:45086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nutarojj@ornl.gov>) id 1cPAjK-0005Ca-HM
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:17:30 -0500
From: "Nutaro, James J." <nutarojj@ornl.gov>
Date: Thu, 5 Jan 2017 16:17:26 +0000
Message-ID: <563ff5f884ab45dd82a76698c705a18a@EXCHCS32.ornl.gov>
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

VjUgZmFpbGVkIHRvIGJ1aWxkIHdpdGggTWluR1csIHNvIEkgaGFkIHRvIG1vdmUgdGhlIGFycGEv
aW5ldC5oIHRvIGEgcGxhY2UgaW5zaWRlIHRoZSAjaWZuZGVmIGJsb2NrIGluIHFxcS5jLiBBbHNv
IGZpeGVkIHNvbWUgZm9ybWF0dGluZyBwcm9ibGVtcy4gT3RoZXJ3aXNlIHRoZXkgYXJlIHRoZSBz
YW1lLiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3cyENCg0KSmltDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBQYW9sbyBCb256aW5pIFttYWlsdG86cGJvbnppbmlAcmVkaGF0LmNv
bV0gDQpTZW50OiBUaHVyc2RheSwgSmFudWFyeSAwNSwgMjAxNyAxMDoyNyBBTQ0KVG86IE51dGFy
bywgSmFtZXMgSi47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2
Nl0gcXFxOiBtb2R1bGUgZm9yIHN5bmNocm9uaXppbmcgd2l0aCBhIHNpbXVsYXRpb24NCg0KDQoN
Ck9uIDA1LzAxLzIwMTcgMTY6MDcsIEphbWVzIEouIE51dGFybyB3cm90ZToNCj4gVGhpcyBwYXRj
aCBhZGRzIGFuIGludGVyZmFjZSBmb3IgcGFjaW5nIHRoZSBleGVjdXRpb24gb2YgUUVNVSB0byBt
YXRjaCBhbiBleHRlcm5hbA0KPiBzaW11bGF0aW9uIGNsb2NrLiBJdHMgYWltIGlzIHRvIHBlcm1p
dCBRRU1VIHRvIGJlIHVzZWQgYXMgYSBtb2R1bGUgd2l0aGluIGENCj4gbGFyZ2VyIHNpbXVsYXRp
b24gc3lzdGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgSi4gTnV0YXJvIDxudXRhcm9q
akBvcm5sLmdvdj4NCg0KV2hhdCdzIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdjUgYW5kIHY2Pw0K
DQo+ICsoMikgRm9yayBRRU1VIHdpdGggdGhlIGFwcHJvcHJpYXRlIGNvbW1hbmQgbGluZSBhcmd1
bWVudHMuDQo+ICsgICAgVGhlIC1xcXEgcGFydCBvZiB0aGUgYXJndW1lbnQgd2lsbCBsb29rIHNv
bWV0aGluZyBsaWtlDQo+ICsNCj4gKyAgICAgICAtcXFxIHNvY2s9c29ja3NbMV0NCg0KTm8gbmVl
ZCBmb3IgLXFxcSwganVzdCBtYWtlIGl0ICItaWNvdW50IGV4dGNsb2NrPUZEIi4NCg0KUGFvbG8N
Cg0K
