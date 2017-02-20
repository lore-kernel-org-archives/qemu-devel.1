Received: from eggs.gnu.org ([2001:4830:134:3::10]:40124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cfmYE-00078A-0C
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cfmYA-0003GQ-T4
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:54:42 -0500
Received: from [45.249.212.187] (port=2535 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cfmYA-0003EW-7c
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:54:38 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 20 Feb 2017 11:54:10 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1C1608@DGGEMA505-MBX.china.huawei.com>
References: <589C099A.9090605@huawei.com>
	<AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
	<105e5774-38c3-0683-ca08-64f6ed53c643@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B6988@DGGEMA505-MBX.china.huawei.com>
	<2127602137.20489688.1486827559449.JavaMail.zimbra@redhat.com>
	<1486980300.17184.28.camel@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1BD1CA@DGGEMA505-MBX.china.huawei.com>
	<ea1dbe94-7343-ef9e-56e1-9c6d8bcd78d6@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1C13C3@DGGEMA505-MBX.china.huawei.com>
	<43632326-97a1-1f60-39f4-1044cd596b66@redhat.com>
In-Reply-To: <43632326-97a1-1f60-39f4-1044cd596b66@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Help] Windows2012 as Guest 64+cores on KVM Halts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Vadim Rozenfeld <vrozenfe@redhat.com>
Cc: Hangaohuai <hangaohuai@huawei.com>, Yan Vugenfirer <yvugenfi@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>

PiANCj4gT24gMjAvMDIvMjAxNyAxMDoxOSwgR29uZ2xlaSAoQXJlaSkgd3JvdGU6DQo+ID4gSGkg
UGFvbG8sDQo+ID4NCj4gPj4NCj4gPj4NCj4gPj4gT24gMTYvMDIvMjAxNyAwMjozMSwgR29uZ2xl
aSAoQXJlaSkgd3JvdGU6DQo+ID4+PiBBbmQgdGhlIGJlbG93IHBhdGNoIHdvcmtzIGZvciBtZSwg
SSBjYW4gc3VwcG9ydCBtYXggMjU1IHZjcHVzIGZvcg0KPiBXUzIwMTINCj4gPj4+IHdpdGggaHlw
ZXItdiBlbmxpZ2h0ZW5tZW50cy4NCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kz
ODYva3ZtLmMgYi90YXJnZXQvaTM4Ni9rdm0uYw0KPiA+Pj4gaW5kZXggMjdmZDA1MC4uZWZlM2Ni
YyAxMDA2NDQNCj4gPj4+IC0tLSBhL3RhcmdldC9pMzg2L2t2bS5jDQo+ID4+PiArKysgYi90YXJn
ZXQvaTM4Ni9rdm0uYw0KPiA+Pj4gQEAgLTc3Miw3ICs3NzIsNyBAQCBpbnQga3ZtX2FyY2hfaW5p
dF92Y3B1KENQVVN0YXRlICpjcykNCj4gPj4+DQo+ID4+PiAgICAgICAgICBjID0gJmNwdWlkX2Rh
dGEuZW50cmllc1tjcHVpZF9pKytdOw0KPiA+Pj4gICAgICAgICAgYy0+ZnVuY3Rpb24gPSBIWVBF
UlZfQ1BVSURfSU1QTEVNRU5UX0xJTUlUUzsNCj4gPj4+IC0gICAgICAgIGMtPmVheCA9IDB4NDA7
DQo+ID4+PiArICAgICAgICBjLT5lYXggPSAtMTsNCj4gPj4+ICAgICAgICAgIGMtPmVieCA9IDB4
NDA7DQo+ID4+Pg0KPiA+Pj4gICAgICAgICAga3ZtX2Jhc2UgPSBLVk1fQ1BVSURfU0lHTkFUVVJF
X05FWFQ7DQo+ID4+DQo+ID4+IFRoaXMgbmVlZHMgdG8gZGVwZW5kIG9uIHRoZSBtYWNoaW5lIHR5
cGUsIGJ1dCBhcGFydCBmcm9tIHRoYXQgSSB0aGluaw0KPiA+DQo+ID4gSSBkb24ndCBrbm93IHdo
eS4gQmVjYXVzZSB0aGUgbmVnYXRpdmUgZWZmZWN0cyBmb3IgdGhpcyBjaGFuZ2UgZG9uJ3QgZXhp
c3QNCj4gPiBvbiBjdXJyZW50IFFFTVUgSUlVQywgYW5kIHdlIGRvbid0IGhhdmUgY29tcGF0aWJs
ZSBwcm9ibGVtcyBmb3IgbGl2ZQ0KPiBtaWdyYXRpb24uDQo+IA0KPiBDUFVJRCBzaG91bGQgbmV2
ZXIgY2hhbmdlIHdpdGggdGhlIHNhbWUgbWFjaGluZSB0eXBlIGFuZCBjb21tYW5kIGxpbmUuDQo+
IA0KT0ssIHRoZW4gaG93IGRvIHdlIGFkZCBjb21wYXQgY29kZSBmb3IgdGhlIENQVUlEIGNoYW5n
ZT8gSXQncyBub3QgYSB2aXNpYmxlIHByb3BlcnR5Lg0KDQpUaGFua3MsDQotR29uZ2xlaQ0KDQo+
IFBhb2xvDQo+IA0KPiA+PiB5b3Ugc2hvdWxkIHN1Ym1pdCB0aGUgcGF0Y2ggZm9yIDIuOS4NCj4g
Pj4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiAtR29uZ2xlaQ0KPiA+DQo=
