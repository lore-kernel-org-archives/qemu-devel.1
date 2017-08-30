Received: from eggs.gnu.org ([2001:4830:134:3::10]:33123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dmqxW-00065q-07
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 20:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dmqxR-0004K6-Vu
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 20:34:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dmqxR-0004J0-4j
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 20:34:13 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 30 Aug 2017 00:33:53 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA395F0A@DGGEMA505-MBX.china.huawei.com>
References: <20170829220337.23427-1-ehabkost@redhat.com>
In-Reply-To: <20170829220337.23427-1-ehabkost@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] qom: Remove unused errp parameter from
 can_be_deleted()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, Lin Ma <lma@suse.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEVkdWFyZG8gSGFia29zdCBb
bWFpbHRvOmVoYWJrb3N0QHJlZGhhdC5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDMw
LCAyMDE3IDY6MDQgQU0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogR29uZ2xl
aSAoQXJlaSk7IFBhb2xvIEJvbnppbmk7IElnb3IgTWFtbWVkb3Y7IEFuZHJlYXMgRsOkcmJlcjsg
TGluIE1hDQo+IFN1YmplY3Q6IFtQQVRDSF0gcW9tOiBSZW1vdmUgdW51c2VkIGVycnAgcGFyYW1l
dGVyIGZyb20gY2FuX2JlX2RlbGV0ZWQoKQ0KPiANCj4gVGhlIGVycnAgYXJndW1lbnQgaXMgaWdu
b3JlZCBieSBhbGwgaW1wbGVtZW50YXRpb25zIG9mIHRoZQ0KPiBtZXRob2QsIGFuZCB1c2VyX2Ny
ZWF0YWJsZV9kZWwoKSB3b3VsZCBicmVhayBpZiBhbnkNCj4gaW1wbGVtZW50YXRpb24gc2V0IGFu
IGVycm9yIChiZWNhdXNlIGl0IGNhbGxzIGVycm9yX3NldGcoZXJycCkgaWYNCj4gdGhlIGZ1bmN0
aW9uIHJldHVybnMgZmFsc2UpLiAgUmVtb3ZlIHRoZSB1bnVzZWQgcGFyYW1ldGVyLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPg0KPiAt
LS0NCj4gIGluY2x1ZGUvcW9tL29iamVjdF9pbnRlcmZhY2VzLmggfCA1ICsrLS0tDQo+ICBiYWNr
ZW5kcy9jcnlwdG9kZXYuYyAgICAgICAgICAgIHwgMiArLQ0KPiAgYmFja2VuZHMvaG9zdG1lbS5j
ICAgICAgICAgICAgICB8IDIgKy0NCj4gIHFvbS9vYmplY3RfaW50ZXJmYWNlcy5jICAgICAgICAg
fCA2ICsrKy0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pDQo+IA0KDQpSZXZpZXdlZC1ieTogR29uZ2xlaSA8YXJlaS5nb25nbGVpQGh1YXdlaS5j
b20+DQo=
