Received: from eggs.gnu.org ([2001:4830:134:3::10]:50504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gKKqh-0000KC-Gp
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 05:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gKKqZ-0001SQ-Hg
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 05:14:07 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 7 Nov 2018 10:08:35 +0000
Message-ID: <d2d60a6f-536e-4f55-7d7c-60e8ca1d4831@virtuozzo.com>
References: <20181015160633.63130-1-vsementsov@virtuozzo.com>
	<20181015160633.63130-4-vsementsov@virtuozzo.com>
	<20181106175720.GI4758@linux.fritz.box>
In-Reply-To: <20181106175720.GI4758@linux.fritz.box>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <91EA024B57C8FA408DABC8084CADCEA8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 03/11] block: allow serialized reads to
 intersect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "famz@redhat.com" <famz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>

MDYuMTEuMjAxOCAyMDo1NywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTUuMTAuMjAxOCB1bSAx
ODowNiBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IE90
aGVyd2lzZSwgaWYgd2UgaGF2ZSBzZXJpYWxpemVkIHJlYWQtcGFydCBpbiBjb3B5X3JhbmdlIGZy
b20gYmFja2luZw0KPj4gZmlsZSB0byBpdHMgcGFyZW50IGlmIENvVyB0YWtlIHBsYWNlLCB0aGlz
IENvVydzIHN1Yi1yZWFkcyB3aWxsDQo+PiBpbnRlcnNlY3Qgd2l0aCBmaXJzdGx5IGNyZWF0ZWQg
c2VyaWFsaXplZCByZWFkIHJlcXVlc3QuDQo+Pg0KPj4gQW55d2F5LCByZWFkcyBzaG91bGQgbm90
IGluZmx1ZW5jZSBvbiBkaXNrIHZpZXcsIGxldCdzIGFsbG93IHRoZW0gdG8NCj4+IGludGVyc2Vj
dC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IFdoYXQgYWJvdXQgcmVhZHMgdGhhdCBpbnRlcm5h
bGx5IHRyaWdnZXIgd3JpdGVzLCBzdWNoIGFzIGNvcHktb24tcmVhZD8NCg0Kb29wcyA6KS4geWVz
LCBJJ3ZlIHRvIHJldGhpbmsgdGhpcyB0aGluZy4NCg0KPg0KPiBLZXZpbg0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg0K
