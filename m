Received: from eggs.gnu.org ([2001:4830:134:3::10]:41905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gFYUd-0002x8-CF
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 01:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gFYUZ-0002be-Cs
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 01:47:39 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:6518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1gFYUT-0002CZ-Iw
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 01:47:31 -0400
Date: Thu, 25 Oct 2018 13:47:12 +0800 (CST)
Message-ID: <201810251347121915659@zte.com.cn>
In-Reply-To: <43045a7f-4092-c039-af58-6221db22d3f4@redhat.com>
References: 20181018130434.23237-1-philmd@redhat.com,
	43045a7f-4092-c039-af58-6221db22d3f4@redhat.com
Mime-Version: 1.0
From: <peng.hao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_v3_0/4=5D_hw/misc=3A_Add_a_MMIO_?=
 =?utf-8?q?interface_to_the_pvpanicdevice?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, wency@cn.fujitsu.com, hutao@cn.fujitsu.com

Pk9uIDE4LzEwLzIwMTggMTU6MDQsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOgo+PiBI
aSwgdGhpcyBzZXJpZXMgdGFrZXMgUGVuZyBIYW8ncyBwcmV2aW91cyB3b3JrIGJ1dCByYXRoZXIg
dGhhbiBhZGRpbmcgeWV0Cj4+IGFub3RoZXIgZGV2aWNlLCBzaW1wbHkgYWRkIHRoZSBNTUlPIGlu
dGVyZmFjZSB0byB0aGUgY3VycmVudCBkZXZpY2UgKHdoaWNoCj4+IG9ubHkgaW1wbGVtZW50cyB0
aGUgSS9PIHBvcnQgYWNjZXNzKS4KPj4KPj4gVGhlIGZpcnN0IHBhdGNoZXMgYXJlIHNpbXBsZSBj
bGVhbnVwczoKPj4gLSBwYXRjaCAxIG1vdmUgdGhlIHB2cGFuaWMgZGV2aWNlIHdpdGggdGhlICdv
Y21tb24gb2JqZWN0cycgc28gd2UgY29tcGlsZQo+PiAgIGl0IG9uY2UgZm9yIHRoZSB4ODYvYXJt
L2FhcmNoNjQgYXJjaHMsCj4+IC0gcGF0Y2ggMiBzaW1wbHkgcmVuYW1lcyBJU0EgZmllbGRzL2Rl
ZmluaXRpb25zIHRvIGdlbmVyaWMgb25lcy4KPj4KPj4gVGhlbiBpbnN0ZWFkIG9mIGFkZC91c2Ug
dGhlIE1NSU8gcHZwYW5pYyBkZXZpY2UgaW4gdGhlIHZpcnQgbWFjaGluZSBpbiBhbgo+PiB1bmlx
dWUgcGF0Y2gsIEkgc3BsaXQgaXQgaW4gdHdvIGRpc3RpbmN0IHBhdGNoZXM6Cj4+IC0gcGF0Y2gg
MyB1c2VzIFBlbmcgSGFvJ3Mgd29yaywgYnV0IGFkZCB0aGUgTU1JTyBpbnRlcmZhY2UgdG8gdGhl
IGV4aXN0aW5nCj4+ICAgZGV2aWNlIChubyBsb2dpY2FsIGNoYW5nZSkuCj4+IC0gcGF0Y2ggNCBp
cyBQZW5nIEhhbydzIHdvcmsgaW4gdGhlIHZpcnQgbWFjaGluZSAobm8gbG9naWNhbCBjaGFuZ2Up
Lgo+Pgo+PiB2MiBmcm9tIFBlbmcgSGFvIGlzOgo+PiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOC0xMC9tc2cwMzQzMy5odG1sCj4+Cj4+IFJlZ2FyZHMs
Cj4+Cj4+IFBoaWwuCj4+Cj4+IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICg0KToKPj4gICBody9t
aXNjL3B2cGFuaWM6IEJ1aWxkIHRoZSBwdnBhbmljIGRldmljZSBpbiAkKGNvbW1vbi1vYmopCj4+
ICAgaHcvbWlzYy9wdnBhbmljOiBDb3NtZXRpYyByZW5hbWluZwo+Cj5Pb3BzIEkgZmFpbGVkIHdo
ZW4gcmViYXNpbmcsIHRoZXNlIHR3byBhcmUgc3VwcG9zZWQgdG8gYmUgZnJvbQo+Cj5QZW5nIEhh
bwo+Cm5vdyBpdCBjYW4gd29ya3MuCkluIHJlZmFjdG9yaW5nIGNvZGUsIHRoZXJlIGlzIHN0aWxs
IGEgbmVlZCB0byBhZGQgYSB0eXBlIHRvIGRpc3Rpbmd1aXNoIGRpZmZlcmVudCBidXMgZGV2aWNl
LgpJIGFkZCBhIHR5cGUgVFlQRV9QVlBBTklDX01NSU8gZm9yIHN5c2J1cyBwdnBhbmljIGRldmlj
ZSBhbmQgCm9yaWduYWwgVFlQRV9QVlBBTklDICBmb3IgaXNhIHB2cGFuaWMgZGVpdmNlLgoKYmlu
ZGxpbmctRFQgInFlbXUscHZwYW5pYy1tbWlvIiBpbiBrZXJuZWwgIGlzIGluIHJldmlldy4KSSB3
aWxsIHJlc3VibWl0IHBhdGNoZXMuCgpUaGFua3MuCgo+d2l0aCBiZWxvdyBteSBTLW8tYjoKPltQ
TUQ6IFVzZSBUWVBFX1BWUEFOSUMgZGVmaW5pdGlvbiwgc3BsaXQgaW4gMiBwYXRjaGVzLAo+aW1w
cm92ZWQgcGF0Y2ggc3ViamVjdF0KPgo+PiAgIGh3L21pc2MvcHZwYW5pYzogQWRkIHRoZSBNTUlP
IGludGVyZmFjZQo+PiAgIGh3L2FybS92aXJ0OiBVc2UgdGhlIHB2cGFuaWMgZGV2aWNlCj4+Cj4+
ICBkZWZhdWx0LWNvbmZpZ3MvYXJtLXNvZnRtbXUubWFrIHwgIDIgKy0KPj4gIGh3L2FybS92aXJ0
LmMgICAgICAgICAgICAgICAgICAgfCAyMSArKysrKysrKysrCj4+ICBody9taXNjL01ha2VmaWxl
Lm9ianMgICAgICAgICAgIHwgIDIgKy0KPj4gIGh3L21pc2MvcHZwYW5pYy5jICAgICAgICAgICAg
ICAgfCA2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0KPj4gIGluY2x1ZGUvaHcv
YXJtL3ZpcnQuaCAgICAgICAgICAgfCAgMSArCj4+ICA1IGZpbGVzIGNoYW5nZWQsIDg0IGluc2Vy
dGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+Pg==
