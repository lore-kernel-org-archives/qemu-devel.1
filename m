Received: from eggs.gnu.org ([2001:4830:134:3::10]:57161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cfk8z-00022S-VR
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cfk8w-0002pw-PL
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:20:29 -0500
Received: from [45.249.212.187] (port=2534 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cfk8w-0002oW-4N
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:20:26 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 20 Feb 2017 09:19:01 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1C13C3@DGGEMA505-MBX.china.huawei.com>
References: <589C099A.9090605@huawei.com>
	<AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
	<105e5774-38c3-0683-ca08-64f6ed53c643@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B6988@DGGEMA505-MBX.china.huawei.com>
	<2127602137.20489688.1486827559449.JavaMail.zimbra@redhat.com>
	<1486980300.17184.28.camel@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1BD1CA@DGGEMA505-MBX.china.huawei.com>
	<ea1dbe94-7343-ef9e-56e1-9c6d8bcd78d6@redhat.com>
In-Reply-To: <ea1dbe94-7343-ef9e-56e1-9c6d8bcd78d6@redhat.com>
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
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Hangaohuai <hangaohuai@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>

SGkgUGFvbG8sDQoNCj4gDQo+IA0KPiBPbiAxNi8wMi8yMDE3IDAyOjMxLCBHb25nbGVpIChBcmVp
KSB3cm90ZToNCj4gPiBBbmQgdGhlIGJlbG93IHBhdGNoIHdvcmtzIGZvciBtZSwgSSBjYW4gc3Vw
cG9ydCBtYXggMjU1IHZjcHVzIGZvciBXUzIwMTINCj4gPiB3aXRoIGh5cGVyLXYgZW5saWdodGVu
bWVudHMuDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYva3ZtLmMgYi90YXJnZXQv
aTM4Ni9rdm0uYw0KPiA+IGluZGV4IDI3ZmQwNTAuLmVmZTNjYmMgMTAwNjQ0DQo+ID4gLS0tIGEv
dGFyZ2V0L2kzODYva3ZtLmMNCj4gPiArKysgYi90YXJnZXQvaTM4Ni9rdm0uYw0KPiA+IEBAIC03
NzIsNyArNzcyLDcgQEAgaW50IGt2bV9hcmNoX2luaXRfdmNwdShDUFVTdGF0ZSAqY3MpDQo+ID4N
Cj4gPiAgICAgICAgICBjID0gJmNwdWlkX2RhdGEuZW50cmllc1tjcHVpZF9pKytdOw0KPiA+ICAg
ICAgICAgIGMtPmZ1bmN0aW9uID0gSFlQRVJWX0NQVUlEX0lNUExFTUVOVF9MSU1JVFM7DQo+ID4g
LSAgICAgICAgYy0+ZWF4ID0gMHg0MDsNCj4gPiArICAgICAgICBjLT5lYXggPSAtMTsNCj4gPiAg
ICAgICAgICBjLT5lYnggPSAweDQwOw0KPiA+DQo+ID4gICAgICAgICAga3ZtX2Jhc2UgPSBLVk1f
Q1BVSURfU0lHTkFUVVJFX05FWFQ7DQo+IA0KPiBUaGlzIG5lZWRzIHRvIGRlcGVuZCBvbiB0aGUg
bWFjaGluZSB0eXBlLCBidXQgYXBhcnQgZnJvbSB0aGF0IEkgdGhpbmsNCg0KSSBkb24ndCBrbm93
IHdoeS4gQmVjYXVzZSB0aGUgbmVnYXRpdmUgZWZmZWN0cyBmb3IgdGhpcyBjaGFuZ2UgZG9uJ3Qg
ZXhpc3QNCm9uIGN1cnJlbnQgUUVNVSBJSVVDLCBhbmQgd2UgZG9uJ3QgaGF2ZSBjb21wYXRpYmxl
IHByb2JsZW1zIGZvciBsaXZlIG1pZ3JhdGlvbi4NCg0KPiB5b3Ugc2hvdWxkIHN1Ym1pdCB0aGUg
cGF0Y2ggZm9yIDIuOS4NCj4gDQoNClRoYW5rcywNCi1Hb25nbGVpDQo=
