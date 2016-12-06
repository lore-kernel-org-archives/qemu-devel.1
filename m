Received: from eggs.gnu.org ([2001:4830:134:3::10]:34037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEC3p-0006m6-Dg
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEC3k-00077E-H2
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:29:17 -0500
Received: from [45.249.212.187] (port=2489 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEC3j-00075E-QB
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:29:12 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 6 Dec 2016 09:28:32 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA154730@DGGEMA505-MBX.china.huawei.com>
References: <1480928380-161760-1-git-send-email-longpeng2@huawei.com>
	<1480928380-161760-2-git-send-email-longpeng2@huawei.com>
	<20161205091842.GA2498@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA152B60@DGGEMA505-MBX.china.huawei.com>
	<20161205165905.GR2498@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA153D9F@DGGEMA505-MBX.china.huawei.com>
	<20161206092152.GD2381@redhat.com>
In-Reply-To: <20161206092152.GD2381@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/3] crypto: add standard des
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: longpeng <longpeng2@huawei.com>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay,
	Euler)" <jianjay.zhou@huawei.com>

Pg0KPiA+ID4gPiA+ID4gICAgICAgICAgfQ0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL3FhcGkv
Y3J5cHRvLmpzb24gYi9xYXBpL2NyeXB0by5qc29uDQo+ID4gPiA+ID4gPiBpbmRleCA1YzlkN2Q0
Li5kNDAzYWI5IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvcWFwaS9jcnlwdG8uanNvbg0KPiA+
ID4gPiA+ID4gKysrIGIvcWFwaS9jcnlwdG8uanNvbg0KPiA+ID4gPiA+ID4gQEAgLTc1LDcgKzc1
LDcgQEANCj4gPiA+ID4gPiA+ICB7ICdlbnVtJzogJ1FDcnlwdG9DaXBoZXJBbGdvcml0aG0nLA0K
PiA+ID4gPiA+ID4gICAgJ3ByZWZpeCc6ICdRQ1JZUFRPX0NJUEhFUl9BTEcnLA0KPiA+ID4gPiA+
ID4gICAgJ2RhdGEnOiBbJ2Flcy0xMjgnLCAnYWVzLTE5MicsICdhZXMtMjU2JywNCj4gPiA+ID4g
PiA+IC0gICAgICAgICAgICdkZXMtcmZiJywNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICdkZXMt
cmZiJywgJ2RlcycsDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBDYW4gd2UgY2FsbCB0aGlzICczZGVz
JyB0byBtYWtlIGl0IGNsZWFyIHRoYXQgdGhpcyBpcyBUcmlwbGUtREVTIGFuZCBub3QNCj4gPiA+
ID4gPiB0aGUgc2luZ2xlLURFUyAod2hpY2ggZGVzLXJmYiBpcykNCj4gPiA+ID4gPg0KPiA+ID4g
PiBBY3R1YWxseSB0aGUgY3VycmVudCBkZXMgaXMgbm90IHRyaXBsZS1ERVMsIGp1c3QgdGhlIHNp
bmdsZS1ERVMsIGFuZCBkZXMtcmZiDQo+IGluDQo+ID4gPiBRRU1VIGlzIGp1c3QgYSB2YXJpYW50
IG9mDQo+ID4gPiA+IHNpbmdsZSBERVMsIHdoaWNoIGNoYW5nZSB0aGUgc3RhbmRhcmQga2V5IGJ5
IGNhbGxpbmcNCj4gPiA+IHFjcnlwdG9fY2lwaGVyX211bmdlX2Rlc19yZmJfa2V5KCkuDQo+ID4g
PiA+DQo+ID4gPiA+IEkgdGhpbmsgd2UgY2FuIGFkZCB0aGUgM2RlcyBzdXBwb3J0IGFzIHdlbGwg
aW4gdGhlIG5leHQgc3RlcC4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGN1cnJlbnQgc2luZ2xlLURF
UyBpbiB0aGUgcGF0Y2ggc2V0IGlzIG9rIHRvIG1lLiA6KQ0KPiA+ID4NCj4gPiA+IFBlciBteSBv
dGhyZSByZXBseSBpbiB0aGlzIHRocmVhZCwNCj4gPg0KPiA+IEkgc2F3IHRoYXQsIHRoYW5rcyBm
b3IgeW91ciBpbmZvcm1hdGlvbiwgRGFuaWVsLg0KPiA+DQo+ID4gPiBJIGRvbid0IHRoaW5rIHdl
IHNob3VsZCBiZSBzdXBwb3J0aW5nDQo+ID4gPiBzaW5nbGUtREVTIGF0IGFsbCBpbiBRRU1VIC8g
Y3J5cHRvZGV2LiBTbyBJTUhPLCB0aGUgY29ycmVjdCBmaXggaXMgdG8NCj4gPiA+IHJlbW92ZSB0
aGUgc2luZ2xlLURFUyBzdXBwb3J0IGZyb20gY3J5cHRvZGV2IGVudGlyZWx5DQo+ID4gPg0KPiA+
IFRoZSBjcnlwdG9kZXYtYnVpbHRpbiBpcyBvbmUga2luZCBvZiBjcnlwdG9kZXYgYmFja2VuZHMu
IEl0IHByb3ZpZGVzIHRoZQ0KPiA+IHJlYWwgY3J5cHRvIGNhcGFiaWxpdHkgZm9yIHZpcnRpbyBj
cnlwdG8gZGV2aWNlLg0KPiA+DQo+ID4gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgYXJ0aWZpY2lh
bGx5IHJlbW92ZSBvbmUgYWxnb3JpdGhtIHN1cHBvcnQgaWYNCj4gPiB0aGUgZnJvbnRlbmQgZHJp
dmVyICh1c2Vycykgd2FudHMgdG8gdXNlIGl0LCB0aG91Z2ggdGhlIGFsZ29yaXRobSBpcw0KPiA+
IHVuc2FmZS4NCj4gDQo+IElJVUMgdGhlIGNyeXB0b2RldiBoYXJkd2FyZSBpcyB1bHRpbWF0ZWx5
IGFib3V0IGFsbG93aW5nIHRoZSBndWVzdA0KPiB0byBvZmZsb2FkIGNyeXB0byBvcGVyYXRpb25z
IHRvIHRoZSBob3N0LCBwb3RlbnRpYWx5IHVzaW5nIGhhcmR3YXJlDQo+IGFjY2VsZXJhdGlvbi4g
SWYgdGhlIGNyeXB0b2RldiBiYWNrZW5kIGRvZXNuJ3Qgc3VwcG9ydCBhIHBhcnRpY3VsYXINCj4g
YWxnb3JpdGhtLCB0aGUgZ3Vlc3QgaXMgc3RpbGwgY2FwYWJsZSBvZiB1c2luZyBpdHMgb3duIGJ1
aWx0LWluDQo+IHN1cHBvcnQgZm9yIHRoYXQgYWxnb3JpdGhtLiBJIHNlZSBubyBjb21wZWxsaW5n
IHJlYXNvbiB0byBwcm92aWRlDQo+IGhvc3Qgb2ZmbG9hZCAvIGFjY2VsZXJhdGlvbiBmb3Igc2lu
Z2xlLURFUy4gSnVzdCBraWxsIHRoaXMgb2Jzb2xldGUNCj4gYWxnb3JpdGhtIGZyb20gY3J5cHRv
ZGV2IGFuZCBpbiB0aGUgdW5saWtlbHkgZXZlbnQgdGhhdCBhIGd1ZXN0DQo+IHJlYWxseSBkb2Vz
IHdhbnQgc2luZ2xlLURFUyBpdCBjYW4gdXNlIGl0cyBidWlsdC1pbiBpbXBsIGluc3RlYWQuDQo+
IA0KTWFrZSBzZW5zZS4gQW5kIEkgZG9uJ3Qgd2FudCB0byBzdXBwb3J0IHNpbmdsZS1ERVMgaW4g
dGhlIHZpcnRpby1jcnlwdG8NCmZyb250ZW5kIGRyaXZlciBhcyB3ZWxsLiBUaGUgZ3Vlc3Qgd2ls
bCB1c2UgdGhlIHNvZnR3YXJlIHJlYWxpemF0aW9uLg0KDQpUaGFua3MsDQotR29uZ2xlaQ0K
