Received: from eggs.gnu.org ([209.51.188.92]:38960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hKyHN-0005wU-4V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 00:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hKy8E-0004Ae-J8
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 00:43:12 -0400
Received: from mail-eopbgr120131.outbound.protection.outlook.com
	([40.107.12.131]:36095
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hKy8E-0004AA-27
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 00:43:10 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 29 Apr 2019 04:43:06 +0000
Message-ID: <79d19dc9-f312-bb19-3895-781e48e21056@virtuozzo.com>
References: <20190426102115.30002-1-yury-kotov@yandex-team.ru>
In-Reply-To: <20190426102115.30002-1-yury-kotov@yandex-team.ru>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBBD6E7B70AB8743A18F514BBC486E35@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] trace: fix runstate tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

T29wcywgbXkgZmF1bHQsIHNvcnJ5OiggVGhhbmsgeW91IGZvciBmaXhpbmchDQoNCk1heSBiZSBh
ZGRlZCwgdGhhdCBpdCBpcyBicm9rZW4gc2luY2UgZmYxMmUzYWUzZDAuDQoNClJldmlld2VkLWJ5
OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+
DQoNCjI2LjA0LjIwMTkgMTM6MjEsIFl1cnkgS290b3Ygd3JvdGU6DQo+IFNpZ25lZC1vZmYtYnk6
IFl1cnkgS290b3YgPHl1cnkta290b3ZAeWFuZGV4LXRlYW0ucnU+DQo+IC0tLQ0KPiAgIHZsLmMg
fCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdmwuYyBiL3ZsLmMNCj4gaW5kZXggZmY1ZGZiNmZiYy4uYWQ5
YjE4MWU1NyAxMDA2NDQNCj4gLS0tIGEvdmwuYw0KPiArKysgYi92bC5jDQo+IEBAIC03MjUsNyAr
NzI1LDcgQEAgdm9pZCBydW5zdGF0ZV9zZXQoUnVuU3RhdGUgbmV3X3N0YXRlKQ0KPiAgICAgICBh
c3NlcnQobmV3X3N0YXRlIDwgUlVOX1NUQVRFX19NQVgpOw0KPiAgIA0KPiAgICAgICB0cmFjZV9y
dW5zdGF0ZV9zZXQoY3VycmVudF9ydW5fc3RhdGUsIFJ1blN0YXRlX3N0cihjdXJyZW50X3J1bl9z
dGF0ZSksDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIG5ld19zdGF0ZSwgUnVuU3RhdGVfc3Ry
KGN1cnJlbnRfcnVuX3N0YXRlKSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG5ld19zdGF0
ZSwgUnVuU3RhdGVfc3RyKG5ld19zdGF0ZSkpOw0KPiAgIA0KPiAgICAgICBpZiAoY3VycmVudF9y
dW5fc3RhdGUgPT0gbmV3X3N0YXRlKSB7DQo+ICAgICAgICAgICByZXR1cm47DQo+IA0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
