Received: from eggs.gnu.org ([2001:4830:134:3::10]:51103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1gXXFi-0000YR-Mf
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 15:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1gXXFi-0001qF-1u
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 15:06:34 -0500
From: Denis Lunev <den@virtuozzo.com>
Date: Thu, 13 Dec 2018 20:06:21 +0000
Message-ID: <f9b1bf35-a8d8-f6d8-d0e3-9bb24566ab5f@virtuozzo.com>
References: <20180917145732.48590-1-vsementsov@virtuozzo.com>
	<504d170c-56ee-0cf5-78e0-47aded4c132f@virtuozzo.com>
	<43def1dd-732e-a358-d15f-492eefae0a80@redhat.com>
	<c4c5d8ec-eb90-915c-03d3-95c7517b4b57@virtuozzo.com>
	<091d787b-c2e8-6296-792f-6223015f0d0e@redhat.com>
In-Reply-To: <091d787b-c2e8-6296-792f-6223015f0d0e@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <06536D191CFF714189913B84002A69E0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] ping2 Re: [PATCH v4 0/8] dirty-bitmap: rewrite
 bdrv_dirty_iter_next_area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

T24gMTIvMTMvMTggOToxOCBQTSwgSm9obiBTbm93IHdyb3RlOg0KPg0KPiBPbiAxMi8xMy8xOCA2
OjA3IEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMTIuMTIuMjAx
OCAyMzo0MSwgSm9obiBTbm93IHdyb3RlOg0KPj4+DQo+Pj4gT24gMTIvMTIvMTggNDoyNyBBTSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gcGluZy4gTm8gZGVwZW5k
ZW5jaWVzLCBhcHBseSB0byBtYXN0ZXIuDQo+Pj4+DQo+Pj4gU3VyZSB0aGluZy4NCj4+Pg0KPj4+
IFN0YWdlZCB0byBqc25vdy9iaXRtYXBzLg0KPj4NCj4+IFRoYW5rIHlvdSENCj4+DQo+PiBPb3Bz
LCBJJ3ZlIG1pc3NlZCB5b3VyIGVtYWlsIGFib3V0IHMvZmlydF9kaXJ0eV9vZmYvZmlyc3RfZGly
dHlfb2ZmDQo+Pg0KPj4gSSBjYW4gcmVzZW5kLCBvciB5b3UgY2FuIGZpeCBpbiB5b3VyIGJyYW5j
aCwgYXMgeW91IHByZWZlci4NCj4+IFRoZSB2YXJpYWJsZSB0b3VjaGVzIHR3byBjb21taXRzIGlu
IGpzbm93L2JpdG1hcHM6DQo+Pg0KPiBXaG9vcHMsIEkgZm9yZ290IHRvby4gSSBqdXN0IHJlbWVt
YmVyIHRoYXQgSSB3YXMgd2FpdGluZyBvbiBhIHJlcXVpc2l0ZQ0KPiBhbmQgaXQgZ290IGxvc3Qg
c28gSSB3YXMgaW4gYSBodXJyeSB0byBzdGFnZSBpdCBmb3IgeW91LiBJJ2xsIGp1c3QNCj4gc3F1
YXNoIGFueSBmaXhlcyBpbi4NCj4NCj4gSSdsbCB0cnkgdG8gc2VuZCB0aGUgUFIgd2hlbiB0aGUg
cWVtdS1pbWcgYml0bWFwIGluZm8gcGF0Y2ggaXMgcmVhZHksDQo+IGFsb25nc2lkZSBteSBzZXJp
ZXMgdG8gZHJvcCB0aGUgeC1wcmVmaXggKGFuZCBhZGp1c3QgdGhlIG1lcmdlIEFQSS4pDQo+DQo+
IEFueXRoaW5nIGVsc2UgdXJnZW50IGZvciB0aGUgc3RhcnQgb2YgdGhlIDQuMCB3aW5kb3cgYmVm
b3JlIHdlIGFsbA0KPiBkaXNhcHBlYXIgb24gaG9saWRheSBicmVhaz8NCj4NCj4gLS1qcw0KDQpK
RllJOiBIb2xpZGF5cyBpbiBSdXNzaWEgYXJlIEFGVEVSIE5ldyBZZWFyLCBub3QgYmVmb3JlIDop
DQpXZSB3aWxsIGJlIG9uIHZhY2F0aW9ucyBmcm9tIDAxIHRpbGwgMDguDQoNCkRlbg0K
