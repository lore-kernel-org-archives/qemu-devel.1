Received: from eggs.gnu.org ([2001:4830:134:3::10]:53559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1gX7pW-0000YC-3U
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1gX7pT-0006NO-EN
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:57:50 -0500
Received: from mail-eopbgr810053.outbound.protection.outlook.com
	([40.107.81.53]:31072
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Thomas.Lendacky@amd.com>)
	id 1gX7pT-0006Lf-1o
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:57:47 -0500
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Date: Wed, 12 Dec 2018 16:57:42 +0000
Message-ID: <c4bdc91b-3946-0345-bb57-f3e2e71b9ae3@amd.com>
References: <20181211205346.11118-1-ehabkost@redhat.com>
	<20181211205346.11118-5-ehabkost@redhat.com>
In-Reply-To: <20181211205346.11118-5-ehabkost@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F884494B3A6B44B90661219FADCE0FA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 4/4] i386: Add "stibp" flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

T24gMTIvMTEvMjAxOCAwMjo1MyBQTSwgRWR1YXJkbyBIYWJrb3N0IHdyb3RlOg0KPiBUaGUgU1RJ
QlAgZmxhZyBtYXkgYmUgc3VwcG9ydGVkIGJ5IHRoZSBob3N0IEtWTSBtb2R1bGUsIHNvIFFFTVUN
Cj4gY2FuIGFsbG93IGl0IHRvIGJlIGNvbmZpZ3VyZWQgbWFudWFsbHksIGFuZCBpdCBjYW4gYmUg
ZXhwb3NlZCB0bw0KPiBndWVzdHMgd2hlbiB1c2luZyAiLWNwdSBob3N0Ii4NCj4gDQo+IE5vIGFk
ZGl0aW9uYWwgbWlncmF0aW9uIGNvZGUgaXMgcmVxdWlyZWQgYmVjYXVzZSB0aGUgd2hvbGUNCj4g
Y29udGVudHMgb2Ygc3BlY19jdHJsIGlzIGFscmVhZHkgbWlncmF0ZWQgaW4gdGhlICJjcHUvc3Bl
Y19jdHJsIg0KPiBzZWN0aW9uLg0KPiANCj4gQ29ycmVzcG9uZGluZyBLVk0gcGF0Y2ggd2FzIHN1
Ym1pdHRlZCBhdDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE4MTIwNTE5MTk1
Ni4zMTQ4MC0xLWVoYWJrb3N0QHJlZGhhdC5jb20vDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFZHVh
cmRvIEhhYmtvc3QgPGVoYWJrb3N0QHJlZGhhdC5jb20+DQo+IE1lc3NhZ2UtSWQ6IDwyMDE4MTIx
MDE4MDI1MC4zMTI5OS0xLWVoYWJrb3N0QHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEVk
dWFyZG8gSGFia29zdCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICB0YXJnZXQvaTM4
Ni9jcHUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2NwdS5jIGIvdGFyZ2V0L2kz
ODYvY3B1LmMNCj4gaW5kZXggODZhOTM0ZDQ1MC4uMTJmNTU5YjZhZiAxMDA2NDQNCj4gLS0tIGEv
dGFyZ2V0L2kzODYvY3B1LmMNCj4gKysrIGIvdGFyZ2V0L2kzODYvY3B1LmMNCj4gQEAgLTEwNDIs
NyArMTA0Miw3IEBAIHN0YXRpYyBGZWF0dXJlV29yZEluZm8gZmVhdHVyZV93b3JkX2luZm9bRkVB
VFVSRV9XT1JEU10gPSB7DQo+ICAgICAgICAgICAgICBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMLA0K
PiAgICAgICAgICAgICAgTlVMTCwgTlVMTCwgInBjb25maWciLCBOVUxMLA0KPiAgICAgICAgICAg
ICAgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwNCj4gLSAgICAgICAgICAgIE5VTEwsIE5VTEwsICJz
cGVjLWN0cmwiLCBOVUxMLA0KPiArICAgICAgICAgICAgTlVMTCwgTlVMTCwgInNwZWMtY3RybCIs
ICJzdGlicCIsDQoNCkkgZ3Vlc3MgSSBtaXNzZWQgdGhpcyBlYXJsaWVyLiBJcyB0aGVyZSBhIGNv
cnJlc3BvbmRpbmcgcGF0Y2ggZm9yIHRoZSBBTUQNClNUSUJQIGJpdCAoQ1BVSUQgMHg4MDAwMDAw
OF9FQlhbMTVdKSB0aGF0IGlzIGluIEtWTT8NCg0KVGhhbmtzLA0KVG9tDQoNCj4gICAgICAgICAg
ICAgIE5VTEwsICJhcmNoLWNhcGFiaWxpdGllcyIsIE5VTEwsICJzc2JkIiwNCj4gICAgICAgICAg
fSwNCj4gICAgICAgICAgLmNwdWlkID0gew0KPiANCg==
