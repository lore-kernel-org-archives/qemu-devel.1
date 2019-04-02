Received: from eggs.gnu.org ([209.51.188.92]:47598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oscar.zhangbo@huawei.com>) id 1hBDA9-0004Ks-2r
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oscar.zhangbo@huawei.com>) id 1hBD9z-0000L6-Sp
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:44:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2492 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <oscar.zhangbo@huawei.com>)
	id 1hBD9v-0007qE-PX
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:44:38 -0400
From: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Date: Tue, 2 Apr 2019 06:44:13 +0000
Message-ID: <0259E1C966E8C54AA93AA2B1240828E65D0A8D5F@dggeml509-mbx.china.huawei.com>
References: <0259E1C966E8C54AA93AA2B1240828E65D08A619@dggeml509-mbx.china.huawei.com>
	<20190318131914.GH10608@angien.pipo.sk>
	<0259E1C966E8C54AA93AA2B1240828E65D08F146@dggeml509-mbx.china.huawei.com>
	<20190329073629.GC4288@angien.pipo.sk>
In-Reply-To: <20190329073629.GC4288@angien.pipo.sk>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [libvirt] Can jobs suck like qemu-pr-helper does
 be transfered to libvirtd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "libvirt-list@redhat.com" <libvirt-list@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

PlsuLi5dDQo+DQo+PiA+PlRoaXMgZG9lcyBub3QgcGxheSB3ZWxsIHdpdGggdGhlIGZhY3QgdGhh
dCBwcm9jZXNzZXMgYXMgdGhlIFBSIGhlbHBlcg0KPj4gPj5hcmUgYWx3YXlzIHJlcXVpcmVkLg0K
Pj4gPj4NCj4+ID4+TWVyZ2luZyB0aGVtIGludG8gbGlidmlydGQgd291bGQgbWFrZSB0aGUgVk0g
c3RvcCB1bnRpbCBsaWJ2aXJ0ZCBpcw0KPj4gPj5ydW5uaW5nIGFnYWluLiBBZGRpdGlvbmFsbHkg
aWYgYW55IG9mIHRoZSBvcGVyYXRpb25zIHJlcXVpcmUgcGVyc2lzdGVudA0KPj4gPj5rZXJuZWwg
c3RhdGUgYXMgZS5nLiBmaWxlIGRlc2NyaXB0b3JzLCB0aGlzIHdvdWxkIGJlIGltcG9zc2libGUg
YXMNCj4+ID4+c3RvcHBpbmcgbGlidmlydGQgcHJvY2VzcyB3b3VsZCBjbG9zZSB0aGUgRkRzIHdo
aWNoIG1heSBiZSB0aGVuDQo+PiA+PmltcG9zc2libGUgdG8gcmVvcGVuIHByb3Blcmx5IGUuZy4g
ZHVlIHRvIHN0YXRlLg0KPj4gPg0KPj4gPlRoYW5rcyEgQmVzaWRlcyB0aGVzZSByZWFzb25zIGFi
b3ZlLCB3aWxsIGl0IHdlYWtlbiBzZWN1cml0eSBpZiB3ZSBsZXQgbGlidmlydGQNCj5kbw0KPj4g
PnRoZXNlIGpvYnM/IEZvciBleGFtcGxlLA0KPj4gPlN1Y2ggc2F5aW5ncywgbGlrZSAibGlidmly
dGQgd291bGQgYmVjb21lIHRoZSBmb2N1cyBmcm9tIGF0dGFja2luZyBmb3JjZXMiLA0KPm1ha2UN
Cj4+ID5zZW5zZT8NCj4+DQo+PiBJZiB0aGVyZSdzIG5vIHNlY3VyaXR5IGNvbmNlcm4sIHRoZW4s
IHdpbGwgaXQgYmUgT0sgdG8gYWRkIGEgbmV3IEtWTSBpb2N0bCwgd2hpY2gNCj5hbGxvd3MNCj4+
IHFlbXUgdG8gYXNrIGt2bSBtb2R1bGUgdG8gZG8gdGhlIGhpZ2ggcHJpbGlkZ2VkIGpvYnM/DQo+
DQo+V2VsbCB0aGVyZSBhY3R1YWxseSBpcyBzZWN1cml0eSBjb25jZXJuIGluIHFlbXUuIExpYnZp
cnQgYXR0ZW1wdHMgdG8gcnVuDQo+cWVtdSB3aXRoIHRoZSBsZWFzdCBhbW91bnQgb2YgcHJpdmls
ZWdlcyBwb3NzaWJsZSBhcyB0aGUgJ3VudHJ1c3RlZCcNCj5ndWVzdCBpbnRlcmFjdHMgZGlyZWN0
bHkgd2l0aCBxZW11Lg0KPg0KPlRoYXQgaXMgaW4gdGhlIGVuZCB0aGUgcmVhc29uICdxZW11LXBy
LWhlbHBlcicgZXhpc3RzIHNlcGFyYXRlbHkuDQoNClRoZW4sIHN1cHBvc2Ugd2UgaGF2ZSB0aGlz
IHNjZW5hcmlvOg0KMSBJbnNpZGUgdGhlIGd1ZXN0LCAgdGhlIHVzZXIgYmluZHMgY2VydGFpbiBp
cnFzIHRvIGNlcnRhaW4gdmNwdXMNCjIgcWVtdSBoZWxwcyB0byBiaW5kIHRoZSBpcnFzIHRvIHRo
ZSBwY3B1cw0KDQpCZXNpZGVzIGxldHRpbmcgYW5vdGhlciBhZ2VudCBkYWVtb24oc2ltaWxhciB0
byBwci1oZWxwZXIpIHRvIGRvIHRoZSBiaW5kaW5nIGpvYiwgY2FuDQp3ZSBhZGQgYSBuZXcgS1ZN
IGlvY3RsIGFuZCBsZXQgcWVtdSBjYWxsIGt2bSBtb2R1bGUgdG8gZG8gdGhlIGJpbmRpbmcgam9i
Pw0K
