Received: from eggs.gnu.org ([209.51.188.92]:55712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkTFx-0003kj-SE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkTFw-0002Pm-PX
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:28:17 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 18 Jan 2019 12:28:06 +0000
Message-ID: <c58db2e3-6674-1852-4d0a-f606737f3402@virtuozzo.com>
References: <20190117193658.16413-1-eblake@redhat.com>
	<20190117193658.16413-20-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-20-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <88F6ED28EE48654C9C571816A83F4D97@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 19/21] qemu-nbd: Add --list option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

MTcuMDEuMjAxOSAyMjozNiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gV2Ugd2FudCB0byBiZSBhYmxl
IHRvIGRldGVjdCB3aGV0aGVyIGEgZ2l2ZW4gcWVtdSBOQkQgc2VydmVyIGlzDQo+IGV4cG9zaW5n
IHRoZSByaWdodCBleHBvcnQocykgYW5kIGRpcnR5IGJpdG1hcHMsIGF0IGxlYXN0IGZvcg0KPiBy
ZWdyZXNzaW9uIHRlc3RpbmcuICBXZSBjb3VsZCB1c2UgJ25iZC1jbGllbnQgLWwnIGZyb20gdGhl
IHVwc3RyZWFtDQo+IE5CRCBwcm9qZWN0IHRvIGxpc3QgZXhwb3J0cywgYnV0IGl0J3MgYW5ub3lp
bmcgdG8gcmVseSBvbg0KPiBvdXQtb2YtdHJlZSBiaW5hcmllczsgZnVydGhlcm1vcmUsIG5iZC1j
bGllbnQgZG9lc24ndCBuZWNlc3NhcmlseQ0KPiBrbm93IGFib3V0IGFsbCBvZiB0aGUgcWVtdSBO
QkQgZXh0ZW5zaW9ucy4gIFRodXMsIGl0IGlzIHRpbWUgdG8gYWRkDQo+IGEgbmV3IG1vZGUgdG8g
cWVtdS1uYmQgdGhhdCBtZXJlbHkgc25pZmZzIGFsbCBwb3NzaWJsZSBpbmZvcm1hdGlvbg0KPiBm
cm9tIHRoZSBzZXJ2ZXIgZHVyaW5nIGhhbmRzaGFrZSBwaGFzZSwgdGhlbiBkaXNjb25uZWN0cyBh
bmQgZHVtcHMNCj4gdGhlIGluZm9ybWF0aW9uLg0KDQpbLi5dIChobSwgZmlyc3QgdGltZSBJIGRv
IGl0IGZvciBjb21taXQgbWVzc2FnZSkNCg0KPiBOb3QgZG9uZSBoZXJlLCBidXQgbWF5YmUgd29y
dGggZnV0dXJlIGV4cGVyaW1lbnRzOiBjYXB0dXJlDQo+IHRoZSBtZWF0IG9mIE5CREV4cG9ydElu
Zm8gaW50byBhIFFBUEkgc3RydWN0LCBhbmQgdXNlIHRoZQ0KPiBnZW5lcmF0ZWQgUUFQSSBwcmV0
dHktcHJpbnRlcnMgaW5zdGVhZCBvZiBoYW5kLXJvbGxpbmcgb3VyDQo+IG91dHB1dCBsb29wLiAg
SXQgd291bGQgYWxzbyBwZXJtaXQgdXMgdG8gYWRkIGEgSlNPTiBvdXRwdXQNCj4gbW9kZSBmb3Ig
bWFjaGluZSBwYXJzaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtl
QHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBSaWNoYXJkIFcuTS4gSm9uZXMgPHJqb25lc0By
ZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQoNCj4gQEAgLTgxNiw2ICs5NDAsMTEgQEAgaW50
IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiAgICAgICAgICAgfQ0KPiAgICAgICB9DQo+
IA0KPiArICAgIGlmIChsaXN0KSB7DQo+ICsgICAgICAgIHNhZGRyID0gbmJkX2J1aWxkX3NvY2tl
dF9hZGRyZXNzKHNvY2twYXRoLCBiaW5kdG8sIHBvcnQpOw0KPiArICAgICAgICByZXR1cm4gcWVt
dV9uYmRfY2xpZW50X2xpc3Qoc2FkZHIsIHRsc2NyZWRzLCBiaW5kdG8pOw0KDQpub3RlLCB0aGF0
IHRoaXMgbWFpbigpIHByZWZlcnMgdG8gdXNlIGV4aXQoKSBpbnN0ZWFkIG9mIHJldHVybiwgZXZl
biBmb3IgbGFzdCBleGl0KEVYSVRfU1VDQ0VTUykuDQooYnV0IGl0IGhhcyBhbHJlYWR5IG9uZSBy
ZXR1cm4sIHNvIHRoaXMgaXMgbm90IHRoZSBmaXJzdCwgYW5kIGZvciBtZSByZXR1cm4gbG9va3Mg
YmV0dGVyKQ0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
