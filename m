Received: from eggs.gnu.org ([2001:4830:134:3::10]:33283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cfnsN-0003Id-AD
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cfnsI-0006Z6-Cl
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:19:35 -0500
Received: from [45.249.212.189] (port=2395 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cfnsH-0006WJ-QE
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:19:30 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 20 Feb 2017 13:18:40 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1C16C5@DGGEMA505-MBX.china.huawei.com>
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
	<33183CC9F5247A488A2544077AF19020DA1C1608@DGGEMA505-MBX.china.huawei.com>
	<ec45f714-66f7-ba93-70c2-e2a033ad4ccd@redhat.com>
In-Reply-To: <ec45f714-66f7-ba93-70c2-e2a033ad4ccd@redhat.com>
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

PiANCj4gDQo+IE9uIDIwLzAyLzIwMTcgMTI6NTQsIEdvbmdsZWkgKEFyZWkpIHdyb3RlOg0KPiA+
Pg0KPiA+PiBPbiAyMC8wMi8yMDE3IDEwOjE5LCBHb25nbGVpIChBcmVpKSB3cm90ZToNCj4gPj4+
IEhpIFBhb2xvLA0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gT24gMTYvMDIvMjAxNyAw
MjozMSwgR29uZ2xlaSAoQXJlaSkgd3JvdGU6DQo+ID4+Pj4+IEFuZCB0aGUgYmVsb3cgcGF0Y2gg
d29ya3MgZm9yIG1lLCBJIGNhbiBzdXBwb3J0IG1heCAyNTUgdmNwdXMgZm9yDQo+ID4+IFdTMjAx
Mg0KPiA+Pj4+PiB3aXRoIGh5cGVyLXYgZW5saWdodGVubWVudHMuDQo+ID4+Pj4+DQo+ID4+Pj4+
IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9rdm0uYyBiL3RhcmdldC9pMzg2L2t2bS5jDQo+ID4+
Pj4+IGluZGV4IDI3ZmQwNTAuLmVmZTNjYmMgMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL3RhcmdldC9p
Mzg2L2t2bS5jDQo+ID4+Pj4+ICsrKyBiL3RhcmdldC9pMzg2L2t2bS5jDQo+ID4+Pj4+IEBAIC03
NzIsNyArNzcyLDcgQEAgaW50IGt2bV9hcmNoX2luaXRfdmNwdShDUFVTdGF0ZSAqY3MpDQo+ID4+
Pj4+DQo+ID4+Pj4+ICAgICAgICAgIGMgPSAmY3B1aWRfZGF0YS5lbnRyaWVzW2NwdWlkX2krK107
DQo+ID4+Pj4+ICAgICAgICAgIGMtPmZ1bmN0aW9uID0gSFlQRVJWX0NQVUlEX0lNUExFTUVOVF9M
SU1JVFM7DQo+ID4+Pj4+IC0gICAgICAgIGMtPmVheCA9IDB4NDA7DQo+ID4+Pj4+ICsgICAgICAg
IGMtPmVheCA9IC0xOw0KPiA+Pj4+PiAgICAgICAgICBjLT5lYnggPSAweDQwOw0KPiA+Pj4+Pg0K
PiA+Pj4+PiAgICAgICAgICBrdm1fYmFzZSA9IEtWTV9DUFVJRF9TSUdOQVRVUkVfTkVYVDsNCj4g
Pj4+Pg0KPiA+Pj4+IFRoaXMgbmVlZHMgdG8gZGVwZW5kIG9uIHRoZSBtYWNoaW5lIHR5cGUsIGJ1
dCBhcGFydCBmcm9tIHRoYXQgSSB0aGluaw0KPiA+Pj4NCj4gPj4+IEkgZG9uJ3Qga25vdyB3aHku
IEJlY2F1c2UgdGhlIG5lZ2F0aXZlIGVmZmVjdHMgZm9yIHRoaXMgY2hhbmdlIGRvbid0IGV4aXN0
DQo+ID4+PiBvbiBjdXJyZW50IFFFTVUgSUlVQywgYW5kIHdlIGRvbid0IGhhdmUgY29tcGF0aWJs
ZSBwcm9ibGVtcyBmb3IgbGl2ZQ0KPiA+PiBtaWdyYXRpb24uDQo+ID4+DQo+ID4+IENQVUlEIHNo
b3VsZCBuZXZlciBjaGFuZ2Ugd2l0aCB0aGUgc2FtZSBtYWNoaW5lIHR5cGUgYW5kIGNvbW1hbmQg
bGluZS4NCj4gPj4NCj4gPiBPSywgdGhlbiBob3cgZG8gd2UgYWRkIGNvbXBhdCBjb2RlIGZvciB0
aGUgQ1BVSUQgY2hhbmdlPyBJdCdzIG5vdCBhIHZpc2libGUNCj4gcHJvcGVydHkuDQo+IA0KPiBZ
b3UgY2FuIGFkZCBhIG5ldyBwcm9wZXJ0eSwgc29tZXRoaW5nIGxpa2UgaHYtY3B1aWQtbGltaXRz
LWVheC4NCj4gDQpTb3VuZHMgZ29vZC4gTGV0IG1lIHRyeS4gIDopDQoNClRoYW5rcywNCi1Hb25n
bGVpDQo=
