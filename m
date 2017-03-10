Received: from eggs.gnu.org ([2001:4830:134:3::10]:38996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cmQEx-0001uw-5a
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 14:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cmQEu-00018b-42
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 14:30:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:20037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cmQEt-00017A-Qn
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 14:30:12 -0500
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Fri, 10 Mar 2017 19:30:06 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A0FC31@ORSMSX112.amr.corp.intel.com>
References: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
	<867e2a13-b48e-cb85-1eb9-38694e28c172@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A0F66A@ORSMSX112.amr.corp.intel.com>
	<a5f6ed2f-2580-beaa-a5d2-42857588844c@redhat.com>
In-Reply-To: <a5f6ed2f-2580-beaa-a5d2-42857588844c@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v1 1/2] reduce qemu's heap Rss size from
 12252kB to 2752KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Zhong, Yang" <yang.zhong@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Peng, Chao P" <chao.p.peng@intel.com>

PiA+IElkZWFsbHksIGZyZWVpbmcgUU9NIG9iamVjdCBzaG91bGQgbm90IHJlcXVpcmUgYSBnbG9i
YWwgbG9jay4NCj4gPiBJZiB5b3Ugc2VlIGFueSBvdGhlciBRT00gcmVxdWlyaW5nIGEgZ2xvYmFs
IGxvY2ssIHBsZWFzZSBsZXQgdXMga25vdywgd2UNCj4gYXJlIHdpbGxpbmcgdG8gZml4IGl0Lg0K
PiANCj4gQWxsIG9mIHRoZW0uICBXaGVuIHVucGx1Z2dpbmcgYSBkZXZpY2UsIHRoZSBkZXZpY2Ug
b2JqZWN0IHdpbGwgYmUgZnJlZWQNCj4gZnJvbSBhbiBSQ1UgY2FsbGJhY2suDQo+IA0KDQpUaGFu
a3MgZm9yIHlvdXIgcmVwbHksDQpTb21lIG9iamVjdHMgbWF5IG5vdCBuZWVkIGxvY2sgYXQgYWxs
IHRvIGJlIGZyZWVkLA0KU29tZSBvYmplY3RzIG1heSBqdXN0IG5lZWQgYSBzbWFsbCBsb2NrIHRv
IGJlIGZyZWVkLA0KDQpTaG91bGQgd2UgbGV0IFJDVSBjYWxsYmFja3MgdG8gZGVjaWRlIHdoaWNo
IGxvY2sgdGhleSBuZWVkIGluc3RlYWQgb2YgZW5mb3JjaW5nICANCnRoZSBnbG9iYWwgbG9jayBp
biBSQ1UgdGhyZWFkPw0KDQpBcyBmb3IgdGhlIGRldmljZSBvYmplY3QsIGNhbiB3ZSBnZXQgdGhl
IGdsb2JhbCBsb2NrIGluc2lkZSB0aGUgb2JqZWN0IGZyZWUvZGVzdHJveSBmdW5jdGlvbiBmb3Ig
bm93Pw0KDQpJZiB3ZSBjYW4gcmVtb3ZlIHRoZSBnbG9iYWwgbG9jayBpbnNpZGUgUkNVIHRocmVh
ZCwgd2UgY2FuIHNhdmUgOU1CIGhlYXAgbWVtb3J5LCB0aGF0J3MgYSBsb3QhDQoNClBsZWFzZSBz
aGFyZSB3aXRoIHVzIGlmIHlvdSBoYXZlIG90aGVyIGlkZWEgdG8gZG8gdGhpcy4NCg0KVGhhbmtz
DQpBbnRob255DQoNCg0KDQo=
