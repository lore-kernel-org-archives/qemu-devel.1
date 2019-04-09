Received: from eggs.gnu.org ([209.51.188.92]:50839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDmZq-0008FX-Ig
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDmZp-0005Ut-Nl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:57:58 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 9 Apr 2019 08:57:51 +0000
Message-ID: <1207047a-e028-b9d1-5614-00fb2450336f@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5E4E89F51B1494E8E725EDE866D6F00@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 1/3] block: include base when checking
 image chain for block allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>

MDguMDQuMjAxOSAyMToyMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoaXMgcGF0Y2gg
aXMgdXNlZCBpbiB0aGUgJ2Jsb2NrL3N0cmVhbTogaW50cm9kdWNlIGEgYm90dG9tIG5vZGUnDQo+
IHRoYXQgaXMgZm9sbG93aW5nLiBJbnN0ZWFkIG9mIHRoZSBiYXNlIG5vZGUsIHRoZSBjYWxsZXIg
bWF5IHBhc3MNCj4gdGhlIG5vZGUgdGhhdCBoYXMgdGhlIGJhc2UgYXMgaXRzIGJhY2tpbmcgaW1h
Z2UgdG8gdGhlIGZ1bmN0aW9uDQo+IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlKCkgd2l0aCBhIG5l
dyBwYXJhbWV0ZXIgaW5jbHVkZV9iYXNlID0gdHJ1ZQ0KPiBhbmQgZ2V0IHJpZCBvZiB0aGUgZGVw
ZW5kZW5jeSBvbiB0aGUgYmFzZSB0aGF0IG1heSBjaGFuZ2UgZHVyaW5nDQo+IGNvbW1pdC9zdHJl
YW0gcGFyYWxsZWwgam9icy4gTm93LCBpZiB0aGUgc3BlY2lmaWVkIGJhc2UgaXMgbm90DQo+IGZv
dW5kIGluIHRoZSBiYWNraW5nIGltYWdlIGNoYWluLCB0aGUgUUVNVSB3aWxsIGNyYXNoLg0KPiAN
Cj4gU3VnZ2VzdGVkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5PHZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2g8YW5kcmV5
LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K
