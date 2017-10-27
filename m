Received: from eggs.gnu.org ([2001:4830:134:3::10]:42826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7tSB-0007Fg-QZ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7tS6-0006N2-Sx
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:28:55 -0400
From: Changlimin <changlimin@h3c.com>
Date: Fri, 27 Oct 2017 01:28:10 +0000
Message-ID: <BC29A004BA570342A4CC0044A3845572CFCE6147@H3CMLB12-EX.srv.huawei-3com.com>
References: <BC29A004BA570342A4CC0044A3845572CFCE5592@H3CMLB12-EX.srv.huawei-3com.com>
	<20171025133115.GA23458@lemon>
	<BC29A004BA570342A4CC0044A3845572CFCE5962@H3CMLB12-EX.srv.huawei-3com.com>
	<f10f73b8-6b6b-a30e-a147-b7fcaa28b182@redhat.com>
	<BC29A004BA570342A4CC0044A3845572CFCE5D44@H3CMLB12-EX.srv.huawei-3com.com>
	<c9c95933-c70c-f16c-dd70-9b66aede987a@redhat.com>
In-Reply-To: <c9c95933-c70c-f16c-dd70-9b66aede987a@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'locking' when disable image locking with option locking=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

SSB0cmllZCBsb2NraW5nPW9mZiwgaXQgc3VwcG9ydHMgcWNvdzINCg0KLWRyaXZlIGZpbGUuZmls
ZW5hbWU9ciAwNjA1LXNoYXJlLmltZyxmb3JtYXQ9cWNvdzIsaWY9bm9uZSxpZD1kcml2ZS12aXJ0
aW8tZGlzazEsY2FjaGU9ZGlyZWN0c3luYyxhaW89bmF0aXZlLGZpbGUubG9ja2luZz1vZmYgDQoN
ClRoYW5rIHlvdSB2ZXJ5IG11Y2guDQoNCkJSDQpDaGFuZyBMaW1pbg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWF4IFJlaXR6IFttYWlsdG86bXJlaXR6QHJlZGhhdC5jb21d
IA0KU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjYsIDIwMTcgMzozMyBQTQ0KVG86IGNoYW5nbGlt
aW4gMDAxNDggKENsb3VkKTsgRmFtIFpoZW5nDQpDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBR
ZW11LWJsb2NrDQpTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxdIEJsb2NrIGZvcm1hdCAncmF3JyBk
b2VzIG5vdCBzdXBwb3J0IHRoZSBvcHRpb24gJ2xvY2tpbmcnIHdoZW4gZGlzYWJsZSBpbWFnZSBs
b2NraW5nIHdpdGggb3B0aW9uIGxvY2tpbmc9b2ZmDQoNCk9uIDIwMTctMTAtMjYgMDk6MTgsIENo
YW5nbGltaW4gd3JvdGU6DQo+IElmIHRoZSBxY293MiBmaWxlIGlzIGNyZWF0ZWQgd2l0aCBwcmVh
bGxvY2F0aW9uPWZ1bGwsIEkgdGhpbmsgbWV0YWRhdGEgd2lsbCBub3QgY29ycnVwdCB3aGVuIGl0
IGlzIHNoYXJlZCBiZXR3ZWVuIHR3byB2bXM/IFNuYXBzaG90IGlzIG5vdCByZXF1aXJlZC4gDQo+
IA0KPiBJcyB0aGlzIHJpZ2h0Pw0KDQpJIHdvdWxkbid0IGNvdW50IG9uIGl0Lg0KDQpJZiB5b3Ug
cmVhbGx5IHdhbnQgdG8gdGFrZSB0aGUgcmlzaywgeW91IGNhbiBwcm9iYWJseSB1c2UgdGhlIGZp
bGUubG9ja2luZz1vZmYgb3B0aW9uIGFnYWluLg0KDQpNYXgNCg0K
