Received: from eggs.gnu.org ([2001:4830:134:3::10]:60900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1di9vB-0002rh-Kt
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 21:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1di9v8-0007cb-Gy
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 21:48:29 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:60308)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1di9v7-0007cL-LP
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 21:48:26 -0400
Date: Thu, 17 Aug 2017 09:48:13 +0800 (CST)
Message-ID: <201708170948134425916@zte.com.cn>
References: 1502874842-4191-1-git-send-email-wang.yong155@zte.com.cn,
	20170816101446.GC8396@lemon
Mime-Version: 1.0
From: <wang.yong155@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiBSZTogW1BBVENIdjMgMDAvMDJdIFJl?=
 =?utf-8?q?place_the_COLO_comparing_thread_with_IOThread?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, jasowang@redhat.com, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org

Pj4gRnJvbTogV2FuZyBZb25nIDx3YW5nLnlvbmcxNTVAenRlLmNvbS5jbj4+PiA+PiBOb3RlOiBU
aGlzIHNlcmllcyBpcyBiYXNlZCBvbiB0aGUgcGF0Y2ggb2YgInFlbXUtaW90aHJlYWQ6ID4+IElP
VGhyZWFkIHN1cHBvcnRzIHRoZUdNYWluQ29udGV4dCBldmVudCBsb29wIi4+VGhlIHN5bnRheCBm
b3IgcGF0Y2hldyB0byBwaWNrIHVwIHRoZSBkZXBlbmRlbmN5IGF1dG9tYXRpY2FsbHk6DQoNCj5C
YXNlZC1vbjogMTUwMjc4MjA5NS0zOTEyLTEtZ2l0LXNlbmQtZW1haWwtd2FuZy55b25nMTU1QHp0
ZS5jb20uY24NCg0KVGhhbmtzICxJIHdpbGwgc3VibWl0IGFsbCB0aGUgcGF0Y2hlcyB0b2dldGhl
ciBhZ2Fpbi4NCg0KDQoNCg0KV2FuZ1lvbmcNCg0KDQoNCuWOn+Wni+mCruS7tg0KDQoNCg0K5Y+R
5Lu25Lq677yaIDxmYW16QHJlZGhhdC5jb20+DQrmlLbku7bkurrvvJrnjovli4cxMDE3MDUzMA0K
5oqE6YCB5Lq677yaIDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+IDx6aGFuZ2NoZW4u
Zm5zdEBjbi5mdWppdHN1LmNvbT4gPGphc293YW5nQHJlZGhhdC5jb20+IDxwYm9uemluaUByZWRo
YXQuY29tPiA8c3RlZmFuaGFAcmVkaGF0LmNvbT7njovlub8xMDE2NTk5MiA8bGl6aGlqaWFuQGNu
LmZ1aml0c3UuY29tPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0K5pelIOacnyDvvJoyMDE35bm0
MDjmnIgxNuaXpSAxODoxNA0K5Li7IOmimCDvvJpSZTogW1BBVENIdjMgMDAvMDJdIFJlcGxhY2Ug
dGhlIENPTE8gY29tcGFyaW5nIHRocmVhZCB3aXRoIElPVGhyZWFkDQoNCg0KDQoNCg0KT24gV2Vk
LCAwOC8xNiAxNzoxNCwgV2FuZyB5b25nIHdyb3RlOg0KPiBGcm9tOiBXYW5nIFlvbmcgPHdhbmcu
eW9uZzE1NUB6dGUuY29tLmNuPg0KPiANCj4gTm90ZTogVGhpcyBzZXJpZXMgaXMgYmFzZWQgb24g
dGhlIHBhdGNoIG9mICJxZW11LWlvdGhyZWFkOiANCj4gSU9UaHJlYWQgc3VwcG9ydHMgdGhlR01h
aW5Db250ZXh0IGV2ZW50IGxvb3AiLg0KDQpUaGUgc3ludGF4IGZvciBwYXRjaGV3IHRvIHBpY2sg
dXAgdGhlIGRlcGVuZGVuY3kgYXV0b21hdGljYWxseToNCg0KQmFzZWQtb246IDE1MDI3ODIwOTUt
MzkxMi0xLWdpdC1zZW5kLWVtYWlsLXdhbmcueW9uZzE1NUB6dGUuY29tLmNuDQoNCkZhbQ==
