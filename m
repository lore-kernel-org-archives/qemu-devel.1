Received: from eggs.gnu.org ([2001:4830:134:3::10]:36701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQGHZ-0007Qo-Gg
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:34:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQGHY-0003dv-PQ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:34:25 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Nov 2018 18:34:16 +0000
Message-ID: <695fbd12-293f-5fae-d119-4e9e312442a7@virtuozzo.com>
References: <20181031113418.29796-1-anton.nefedov@virtuozzo.com>
	<20181031113418.29796-9-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181031113418.29796-9-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE416E42503962479D848B00294731B0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 8/9] file-posix: account discard
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

MzEuMTAuMjAxOCAxNDozNSwgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gVGhpcyB3aWxsIGhlbHAg
dG8gaWRlbnRpZnkgaG93IG1hbnkgb2YgdGhlIHVzZXItaXNzdWVkIGRpc2NhcmQgb3BlcmF0aW9u
cw0KPiAoYWNjb3VudGVkIG9uIGEgZGV2aWNlIGxldmVsKSBoYXZlIGFjdHVhbGx5IHN1Y2VlZGVk
IGRvd24gb24gdGhlIGhvc3QgZmlsZQ0KPiAoZXZlbiB0aG91Z2ggdGhlIG51bWJlcnMgd2lsbCBu
b3QgYmUgZXhhY3RseSB0aGUgc2FtZSBpZiBub24tcmF3IGZvcm1hdA0KPiBkcml2ZXIgaXMgdXNl
ZCAoZS5nLiBxY293MiBzZW5kaW5nIG1ldGFkYXRhIGRpc2NhcmRzKSkuDQo+IA0KPiBOb3RlIHRo
YXQgdGhlc2UgbnVtYmVycyB3aWxsIG5vdCBpbmNsdWRlIGRpc2NhcmRzIHRyaWdnZXJlZCBieQ0K
PiB3cml0ZS16ZXJvZXMgKyBNQVlfVU5NQVAgY2FsbHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBB
bnRvbiBOZWZlZG92IDxhbnRvbi5uZWZlZG92QHZpcnR1b3p6by5jb20+DQoNClJldmlld2VkLWJ5
OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+
DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
