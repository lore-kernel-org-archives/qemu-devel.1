Received: from eggs.gnu.org ([209.51.188.92]:47520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpac4-0001Iy-Ud
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpac1-0006Ic-5W
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:20:15 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 1 Feb 2019 15:19:41 +0000
Message-ID: <b31d7f28-fc84-f9ad-6327-0afa2a26fc9f@virtuozzo.com>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB9E9E36E6F7B54580AF95D9939A0A4E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>

MzEuMDEuMjAxOSAxNjo0NiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IEluIHRoZSAnRm9y
bWF0IHNwZWNpZmljIGluZm9ybWF0aW9uJyBzZWN0aW9uIG9mIHRoZSAncWVtdS1pbWcgaW5mbycN
Cj4gY29tbWFuZCBvdXRwdXQsIHRoZSBzdXBwbGVtZW50YWwgaW5mb3JtYXRpb24gYWJvdXQgZXhp
c3RpbmcgUUNPVzINCj4gYml0bWFwcyB3aWxsIGJlIHNob3duLCBzdWNoIGFzIGEgYml0bWFwIG5h
bWUsIGZsYWdzIGFuZCBncmFudWxhcml0eToNCj4gDQo+IGltYWdlOiAvdnovdm1wcml2YXRlL1ZN
MS9oYXJkZGlzay5oZGQNCj4gZmlsZSBmb3JtYXQ6IHFjb3cyDQo+IHZpcnR1YWwgc2l6ZTogNjRH
ICg2ODcxOTQ3NjczNiBieXRlcykNCj4gZGlzayBzaXplOiAzLjBNDQo+IGNsdXN0ZXJfc2l6ZTog
MTA0ODU3Ng0KPiBGb3JtYXQgc3BlY2lmaWMgaW5mb3JtYXRpb246DQo+ICAgICAgY29tcGF0OiAx
LjENCj4gICAgICBsYXp5IHJlZmNvdW50czogdHJ1ZQ0KPiAgICAgIGJpdG1hcHM6DQo+ICAgICAg
ICAgIFswXToNCj4gICAgICAgICAgICAgIGZsYWdzOg0KPiAgICAgICAgICAgICAgICAgIFswXTog
aW4tdXNlDQo+ICAgICAgICAgICAgICAgICAgWzFdOiBhdXRvDQo+ICAgICAgICAgICAgICBuYW1l
OiBiYWNrLXVwMQ0KPiAgICAgICAgICAgICAgdW5rbm93biBmbGFnczogNA0KPiAgICAgICAgICAg
ICAgZ3JhbnVsYXJpdHk6IDY1NTM2DQo+ICAgICAgICAgIFsxXToNCj4gICAgICAgICAgICAgIGZs
YWdzOg0KPiAgICAgICAgICAgICAgICAgIFswXTogaW4tdXNlDQo+ICAgICAgICAgICAgICAgICAg
WzFdOiBhdXRvDQo+ICAgICAgICAgICAgICBuYW1lOiBiYWNrLXVwMg0KPiAgICAgICAgICAgICAg
dW5rbm93biBmbGFnczogOA0KPiAgICAgICAgICAgICAgZ3JhbnVsYXJpdHk6IDY1NTM2DQo+ICAg
ICAgcmVmY291bnQgYml0czogMTYNCj4gICAgICBjb3JydXB0OiBmYWxzZQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5j
b20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50
c292QHZpcnR1b3p6by5jb20+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
