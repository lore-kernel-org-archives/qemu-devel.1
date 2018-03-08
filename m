Received: from eggs.gnu.org ([2001:4830:134:3::10]:45058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.b.zhang@intel.com>) id 1etjYD-0003Rl-BV
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.b.zhang@intel.com>) id 1etjY9-0002zs-4N
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:36:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:47349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.b.zhang@intel.com>)
	id 1etjY8-0002zT-RK
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:36:49 -0500
From: "Zhang, Chao B" <chao.b.zhang@intel.com>
Date: Thu, 8 Mar 2018 00:36:39 +0000
Message-ID: <FF72C7E4248F3C4E9BDF19D4918E90F249662416@shsmsx102.ccr.corp.intel.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180307155746.18526-3-marcandre.lureau@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 2/8] SecurityPkg/Tcg2Pei: drop
 PeiReadOnlyVariable from Depex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>, "pjones@redhat.com" <pjones@redhat.com>, "Yao,
	Jiewen" <jiewen.yao@intel.com>, "lersek@redhat.com" <lersek@redhat.com>

SGkgTHVyZWF1Og0KICAgSSB0aGluayB3ZSBjYW4gcmVtb3ZlIHNhbWUgZGVwZW5kZW5jeSBpbiBU
Y2dQZWkuIA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogZWRrMi1kZXZlbCBb
bWFpbHRvOmVkazItZGV2ZWwtYm91bmNlc0BsaXN0cy4wMS5vcmddIE9uIEJlaGFsZiBPZiBtYXJj
YW5kcmUubHVyZWF1QHJlZGhhdC5jb20NClNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggNywgMjAxOCAx
MTo1OCBQTQ0KVG86IGVkazItZGV2ZWxAbGlzdHMuMDEub3JnDQpDYzogcWVtdS1kZXZlbEBub25n
bnUub3JnOyBqYXZpZXJtQHJlZGhhdC5jb207IHBqb25lc0ByZWRoYXQuY29tOyBZYW8sIEppZXdl
biA8amlld2VuLnlhb0BpbnRlbC5jb20+OyBsZXJzZWtAcmVkaGF0LmNvbQ0KU3ViamVjdDogW2Vk
azJdIFtQQVRDSCB2MiAyLzhdIFNlY3VyaXR5UGtnL1RjZzJQZWk6IGRyb3AgUGVpUmVhZE9ubHlW
YXJpYWJsZSBmcm9tIERlcGV4DQoNCkZyb206IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJl
Lmx1cmVhdUByZWRoYXQuY29tPg0KDQpUaGUgbW9kdWxlIGRvZXNuJ3QgdXNlIHJlYWQtb25seSB2
YXJpYWJsZS4NCg0KQ2M6IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5jb20+DQpDb250cmli
dXRlZC11bmRlcjogVGlhbm9Db3JlIENvbnRyaWJ1dGlvbiBBZ3JlZW1lbnQgMS4xDQpTaWduZWQt
b2ZmLWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4N
Ci0tLQ0KIFNlY3VyaXR5UGtnL1RjZy9UY2cyUGVpL1RjZzJQZWkuaW5mIHwgMSAtDQogMSBmaWxl
IGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL1NlY3VyaXR5UGtnL1RjZy9U
Y2cyUGVpL1RjZzJQZWkuaW5mIGIvU2VjdXJpdHlQa2cvVGNnL1RjZzJQZWkvVGNnMlBlaS5pbmYN
CmluZGV4IGJjOTEwYzNiYWY5Ny4uYTRhYWUxNDg4ZmY4IDEwMDY0NA0KLS0tIGEvU2VjdXJpdHlQ
a2cvVGNnL1RjZzJQZWkvVGNnMlBlaS5pbmYNCisrKyBiL1NlY3VyaXR5UGtnL1RjZy9UY2cyUGVp
L1RjZzJQZWkuaW5mDQpAQCAtOTEsNyArOTEsNiBAQCBbUGNkXQ0KIA0KIFtEZXBleF0NCiAgIGdF
ZmlQZWlNYXN0ZXJCb290TW9kZVBwaUd1aWQgQU5EDQotICBnRWZpUGVpUmVhZE9ubHlWYXJpYWJs
ZTJQcGlHdWlkIEFORA0KICAgZ0VmaVRwbURldmljZVNlbGVjdGVkR3VpZA0KIA0KIFtVc2VyRXh0
ZW5zaW9ucy5UaWFub0NvcmUuIkV4dHJhRmlsZXMiXQ0KLS0gDQoyLjE2LjIuMzQ2Lmc5Nzc5MzU1
ZTM0DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpl
ZGsyLWRldmVsIG1haWxpbmcgbGlzdA0KZWRrMi1kZXZlbEBsaXN0cy4wMS5vcmcNCmh0dHBzOi8v
bGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vZWRrMi1kZXZlbA0K
