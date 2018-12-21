Received: from eggs.gnu.org ([2001:4830:134:3::10]:35283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gaNjs-00084y-65
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gaNjq-0002gy-5o
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:33:28 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 21 Dec 2018 16:33:14 +0000
Message-ID: <da464c42-3ff6-38c7-bf5a-43631b89dadb@virtuozzo.com>
References: <20181012131509.16370-1-vsementsov@virtuozzo.com>
	<790c1efd-1188-8ff3-f71b-b9dd49dd2bc0@virtuozzo.com>
In-Reply-To: <790c1efd-1188-8ff3-f71b-b9dd49dd2bc0@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC6F89A70DE8804595B8AE8527997679@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/2] improve block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, Denis Lunev <den@virtuozzo.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

MjEuMTIuMjAxOCAxOTozMSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
cGluZw0KDQpvb3BzLCBzaG91bGQgcy8zLjEvNC4wDQoNCj4gDQo+IDEyLjEwLjIwMTggMTY6MTUs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBTdXBwb3J0IFFPTSBwYXRo
IGZvciBibG9jay1sYXRlbmN5LWhpc3RvZ3JhbS1zZXQgYW5kIGRyb3AgeC0gcHJlZml4Lg0KPj4N
Cj4+IExpYnZpcnQgZGlzY3Vzc2lvbiAobm90IHlldCB1cGRhdGVkIGZvciB1c2luZyBpZCBpbnN0
ZWFkIG9mIGRldmljZSk6DQo+PiBodHRwczovL3d3dy5yZWRoYXQuY29tL2FyY2hpdmVzL2xpYnZp
ci1saXN0LzIwMTgtU2VwdGVtYmVyL21zZzAwMDExLmh0bWwNCj4+DQo+PiB2MjogaWQsZGV2aWNl
IC0+IGlkICh3aXRoIGZhbGwgYmFjayB0byBkZXZpY2UgbmFtZSkNCj4+IMKgwqDCoMKgIGZpeCB2
ZXJzaW9ucyBhbmQgYWxsIHJlbWFpbmluZyB4XyBwcmVmaXhlcw0KPj4NCj4+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgKDIpOg0KPj4gwqDCoCBxYXBpOiBtb3ZlIHRvIFFPTSBwYXRoIGZv
ciB4LWJsb2NrLWxhdGVuY3ktaGlzdG9ncmFtLXNldA0KPj4gwqDCoCBxYXBpOiBkcm9wIHgtIGZy
b20geC1ibG9jay1sYXRlbmN5LWhpc3RvZ3JhbS1zZXQNCj4+DQo+PiDCoCBxYXBpL2Jsb2NrLWNv
cmUuanNvbiB8IDI0ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPj4gwqAgYmxvY2svcWFwaS5j
wqDCoMKgwqDCoMKgwqDCoCB8IDEyICsrKysrKy0tLS0tLQ0KPj4gwqAgYmxvY2tkZXYuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMTggKysrKysrKysrKysrKy0tLS0tDQo+PiDCoCAzIGZpbGVzIGNo
YW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPj4NCj4gDQo+IA0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
