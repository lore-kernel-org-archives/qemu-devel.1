Received: from eggs.gnu.org ([2001:4830:134:3::10]:34254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@outlook.com>) id 1gUr3p-0001g7-MA
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@outlook.com>) id 1gUqzB-000456-Fa
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:34:30 -0500
Received: from mail-oln040092014103.outbound.protection.outlook.com
	([40.92.14.103]:15266
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liq3ea@outlook.com>) id 1gUqzB-0003yX-3C
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:34:25 -0500
From: li qiang <liq3ea@outlook.com>
Date: Thu, 6 Dec 2018 10:34:22 +0000
Message-ID: <BN6PR18MB12207477BC1FC04674F98A2E9FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
References: <20181206084816.30485-1-ppandit@redhat.com>
	<BN6PR18MB1220A0A33454573CA39058659FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
	<CAFEAcA_B3FNQXLP4YnL70EPoFUbM89Dh1eFdZSVzpkJrgt+j_g@mail.gmail.com>
In-Reply-To: <CAFEAcA_B3FNQXLP4YnL70EPoFUbM89Dh1eFdZSVzpkJrgt+j_g@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <2527C8445A2693449C4CA2B433D84685@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "public@hansmi.ch" <public@hansmi.ch>, Prasad J Pandit <pjp@fedoraproject.org>, "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>, "liq3ea@gmail.com" <liq3ea@gmail.com>

DQrlnKggMjAxOC8xMi82IDE4OjE2LCBQZXRlciBNYXlkZWxsIOWGmemBkzoNCj4gT24gVGh1LCA2
IERlYyAyMDE4IGF0IDA5OjEwLCBsaSBxaWFuZzxsaXEzZWFAb3V0bG9vay5jb20+ICB3cm90ZToN
Cj4+IE9oLi4uIEZpbmFsbHkgYW5vdGhlciBvbmUgZmluZCB0aGlzLi4uLi4NCj4+DQo+PiBJJ3Zl
IGFscmVhZHkgZm91bmQgdGhpcy4gVGhpcyBpcyB2ZXJ5IGEgc2VyaW91cyBzZWN1cml0eSBpc3N1
ZS4NCj4gSWYgeW91IGZpbmQgYSBzZWN1cml0eSBpc3N1ZSwgd2Ugd291bGQgYXBwcmVjaWF0ZSBp
dCBpZg0KPiB5b3UgbGV0IHVzIGtub3csIHJhdGhlciB0aGFuIGp1c3Qgd2FpdGluZyB0byBzZWUg
aWYNCj4gYW55Ym9keSBlbHNlIG5vdGljZXMgaXQuLi4NCg0KSSdtIHNvcnJ5IGZvciB0aGF0Lg0K
DQpUbyBiZSBwZXJmZWN0LCBJJ20gY3VycmVudGx5IHRyeWluZyB0byB3cml0ZSBhbiBleHAgZm9y
IGk0NDBmeC4NCg0KSSBpbnRlbmQgcmVwb3J0IGl0IGFmdGVyIGNvbXBsZXRpbmcgaXQuDQoNClRo
YW5rcywNCkxpIFFpYW5nDQoNCg0KPiB0aGFua3MNCj4gLS0gUE1NDQo=
