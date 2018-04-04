Received: from eggs.gnu.org ([2001:4830:134:3::10]:51414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3kq1-00078F-AB
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3kpx-00009v-9p
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:00:41 -0400
Received: from smtp66.cstnet.cn ([159.226.251.66]:40225 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3kpw-00008X-Tk
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:00:37 -0400
Date: Thu, 5 Apr 2018 00:00:31 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <06bd734b-3b48-ab51-3425-4cbb2dfe3bc0@redhat.com>
References: <152276983686.1416.16137563993301721352@71c20359a636>
	<06bd734b-3b48-ab51-3425-4cbb2dfe3bc0@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <13cc673.2fff.16291635e5b.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH 0/2 RFC] Implement Hex file loader and add
 test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, no-reply@patchew.org, stefanha@gmail.com, jim@groklearning.com, famz@redhat.com, joel@jms.id.au

QSBiaXQgZW1iYXJyYXNzaW5nLCB0aGlzIG1pc3Rha2Ugd2FzIGludHJvZHVjZWQgYnkgbWUuIEkg
c3VibWl0dGVkIGEgY29ycmVzcG9uZGluZyBwYXRjaCB0byBmaXggaXQsIGJ1dCBubyBvbmUgaGFz
IHJldmlld2VkIGl0LgpTZWUgbGluayBiZWxvdzoKaHR0cDovL2xpc3RzLm5vbmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOC0wMy9tc2cwNjUwNi5odG1sCgoiRXJpYyBCbGFrZSIg
PGVibGFrZUByZWRoYXQuY29tPndyb3RlOgo+IE9uIDA0LzAzLzIwMTggMTA6MzcgQU0sIG5vLXJl
cGx5QHBhdGNoZXcub3JnIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+IFRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yDQo+ID4gbW9yZSBpbmZvcm1hdGlvbjoNCj4gPiANCj4gDQo+ID4gPT09IE9VVFBVVCBCRUdJ
TiA9PT0NCj4gPiBDaGVja2luZyBQQVRDSCAxLzI6IEltcGxlbWVudCAuaGV4IGZpbGUgbG9hZGVy
Li4uDQo+ID4gRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0
aGlzIHN0YXRlbWVudA0KPiA+ICMyMjA6IEZJTEU6IGh3L2NvcmUvbG9hZGVyLmM6MTQ2MzoNCj4g
PiArICAgIH0gd2hpbGUgKCsraGV4X2Jsb2IgIT0gZW5kKTsNCj4gPiBbLi4uXQ0KPiANCj4gRmFs
c2UgcG9zaXRpdmU7IHRoaXMgaXMgYSBrbm93biBidWcgaW4gY2hlY2twYXRjaC5wbCwgYW5kIHRo
ZXJlIGlzIGV2ZW4NCj4gYSBwYXRjaCBwcm9wb3NlZCB0byByZXNvbHZlIGl0LCBidXQgbm8gb25l
IGhhcyBpbmNvcnBvcmF0ZWQgdGhlIHBhdGNoIHlldDoNCj4gDQo+IGh0dHBzOi8vbGlzdHMuZ251
Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4LTAzL21zZzA1MjMyLmh0bWwNCj4gDQo+
IC0tIA0KPiBFcmljIEJsYWtlLCBQcmluY2lwYWwgU29mdHdhcmUgRW5naW5lZXINCj4gUmVkIEhh
dCwgSW5jLiAgICAgICAgICAgKzEtOTE5LTMwMS0zMjY2DQo+IFZpcnR1YWxpemF0aW9uOiAgcWVt
dS5vcmcgfCBsaWJ2aXJ0Lm9yZw0KPiANCg==
