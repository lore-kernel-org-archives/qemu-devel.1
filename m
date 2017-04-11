Received: from eggs.gnu.org ([2001:4830:134:3::10]:48509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cxkZK-0003zh-60
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cxkZH-000832-04
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:26:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:15655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cxkZG-00082q-M8
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:26:02 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Tue, 11 Apr 2017 01:25:59 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A58917@ORSMSX112.amr.corp.intel.com>
References: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
	<1491612336-31066-2-git-send-email-anthony.xu@intel.com>
	<c3a267fe-d6bb-c72c-0f88-9fa10551f4fd@redhat.com>
In-Reply-To: <c3a267fe-d6bb-c72c-0f88-9fa10551f4fd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/4] pam:refactor PAM related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

PiBPbiAwOC8wNC8yMDE3IDA4OjQ1LCBBbnRob255IFh1IHdyb3RlOg0KPiA+IHNwbGl0IFBBTSBT
TVJBTSBmdW5jdGlvbnMgaW4gcGlpeC5jDQo+ID4gY3JlYXRlIG1jaF9pbml0X3BhbSBpbiBxMzUu
Yw0KPiANCj4gQ291bGQgeW91IGZ1cnRoZXIgbW92ZQ0KPiANCj4gICAgIE1lbW9yeVJlZ2lvbiAq
cmFtX21lbW9yeTsNCj4gICAgIE1lbW9yeVJlZ2lvbiAqc3lzdGVtX21lbW9yeTsNCj4gICAgIE1l
bW9yeVJlZ2lvbiAqcGNpX2FkZHJlc3Nfc3BhY2U7DQo+ICAgICBQQU1NZW1vcnlSZWdpb24gcGFt
X3JlZ2lvbnNbMTNdOw0KPiANCj4gZnJvbSB0aGUgbm9ydGhicmlkZ2UgZGV2aWNlcyB1cCB0byBQ
Q01hY2hpbmVTdGF0ZSwgYW5kIG1vdmUgdGhlIGNvbW1vbg0KPiBjb2RlIGZvciBQSUlYIGFuZCBR
MzUgdG8gaHcvcGNpLWhvc3QvcGFtLmM/DQo+IA0KPiBJdCBsb29rcyBsaWtlIHlvdSBjYW4gZGVm
aW5lIGEgYmV0dGVyIEFQSSB0aGFuIHdoYXQgcGFtLmMgY3VycmVudGx5DQo+IHByb3ZpZGVzOg0K
PiANCj4gdm9pZCBwY19pbml0X3BhbShQQ01hY2hpbmVTdGF0ZSAqcGNfbWFjaGluZSwgRGV2aWNl
U3RhdGUgKmQpOw0KPiB2b2lkIHBjX3VwZGF0ZV9wYW0oUENNYWNoaW5lU3RhdGUgKnBjX21hY2hp
bmUsIHVpbnQ4X3QgKnBhbV9jb25maWcpOw0KPiANCj4gb3IgZXZlbiByZW1vdmUgIkRldmljZVN0
YXRlICpkIiBiZWNhdXNlIHRoZSBvd25lciBvZiB0aGUgbWVtb3J5IHJlZ2lvbnMNCj4gY2FuIGJl
IHRoZSBQQ01hY2hpbmVTdGF0ZS4NCj4gDQoNCkdvb2QgaWRlYSENCldpbGwgZG8uDQoNCkFudGhv
bnkNCg==
