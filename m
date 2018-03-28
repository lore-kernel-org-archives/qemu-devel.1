Received: from eggs.gnu.org ([2001:4830:134:3::10]:57934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1f0zCM-0006y2-CA
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1f0zCJ-0001N3-A8
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:44:18 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:39388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiang.biao2@zte.com.cn>)
	id 1f0zCI-0001LS-UU
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:44:15 -0400
Date: Wed, 28 Mar 2018 08:43:56 +0800 (CST)
Message-ID: <201803280843566488166@zte.com.cn>
In-Reply-To: <19870756-df8d-a2ef-6518-cf7791594824@gmail.com>
References: 20180313075739.11194-1-xiaoguangrong@tencent.com,
	19870756-df8d-a2ef-6518-cf7791594824@gmail.com
Mime-Version: 1.0
From: <jiang.biao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_3/8=5D_migration=3A_support_to_d?=
 =?utf-8?q?etectcompression_and_decompression_errors?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: peterx@redhat.com, kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com, xiaoguangrong@tencent.com, qemu-devel@nongnu.org, pbonzini@redhat.com

PiBPbiAwMy8yNy8yMDE4IDA3OjE3IFBNLCBQZXRlciBYdSB3cm90ZToKPj4gT24gVHVlLCBNYXIg
MjcsIDIwMTggYXQgMDM6NDI6MzJBTSArMDgwMCwgWGlhbyBHdWFuZ3Jvbmcgd3JvdGU6Cj4+IAo+
PiBbLi4uXQo+PiAKPj4+PiBJdCdsbCBiZSB1bmRlcnN0YW5kYWJsZSB0byBtZSBpZiB0aGUgcHJv
YmxlbSBpcyB0aGF0IHRoZSBjb21wcmVzcygpCj4+Pj4gQVBJIGRvZXMgbm90IGFsbG93IHRoZSBp
bnB1dCBidWZmZXIgdG8gYmUgY2hhbmdlZCBkdXJpbmcgdGhlIHdob2xlCj4+Pj4gcGVyaW9kIG9m
IHRoZSBjYWxsLiAgSWYgdGhhdCBpcyBhIG11c3QsIHRoaXMgcGF0Y2ggZm9yIHN1cmUgaGVscHMu
Cj4+Pgo+Pj4gWWVzLCB0aGF0IGlzIGV4YWN0bHkgd2hhdCBpIHdhbnQgdG8gc2F5LiA6KQo+PiAK
Pj4gU28gSSB0aGluayBub3cgSSBrbm93IHdoYXQgdGhpcyBwYXRjaCBpcyBmb3IuIDopIEFuZCB5
ZWFoLCBpdCBtYWtlcwo+PiBzZW5zZS4KPj4gCj4+IFRob3VnaCBhbm90aGVyIHF1ZXN0aW9uIHdv
dWxkIGJlOiBpZiB0aGUgYnVmZmVyIGlzIHVwZGF0ZWQgZHVyaW5nCj4+IGNvbXByZXNzKCkgYW5k
IGNvbXByZXNzKCkgcmV0dXJuZWQgZXJyb3IsIHdvdWxkIHRoYXQgcG9sbHV0ZSB0aGUgd2hvbGUK
Pj4gel9zdHJlYW0gb3IgaXQgb25seSBmYWlscyB0aGUgY29tcHJlc3MoKSBjYWxsPwo+PiAKPgo+
IEkgZ3Vlc3MgZGVmbGF0ZVJlc2V0KCkgY2FuIHJlY292ZXIgZXZlcnl0aGluZywgaS5lLCBrZWVw
IHpfc3RyZWFtIGFzCj4gaXQgaXMgaW5pdCdlZCBieSBkZWZsYXRlX2luaXQoKS4KPgo+PiAoU2Ft
ZSBxdWVzdGlvbiBhcHBsaWVzIHRvIGRlY29tcHJlc3MoKS4pCj4+IAo+PiBJZiBpdCdzIG9ubHkg
YSBjb21wcmVzcygpIGVycm9yIGFuZCBpdCB3b24ndCBwb2xsdXRlIHpfc3RyZWFtIChvciBzYXks
Cj4+IGl0IGNhbiBiZSByZWNvdmVyZWQgYWZ0ZXIgYSBkZWZsYXRlUmVzZXQoKSBhbmQgdGhlbiB3
ZSBjYW4gY29udGludWUgdG8KPj4gY2FsbCBkZWZsYXRlKCkgd2l0aG91dCBwcm9ibGVtKSwgdGhl
biB3ZSdsbCBhY3R1YWxseSBoYXZlIHR3bwo+PiBhbHRlcm5hdGl2ZXMgdG8gc29sdmUgdGhpcyAi
YnVmZmVyIHVwZGF0ZSIgaXNzdWU6Cj4+IAo+PiAxLiBVc2UgdGhlIGFwcHJvYWNoIG9mIGN1cnJl
bnQgcGF0Y2g6IHdlIGNvcHkgdGhlIHBhZ2UgZXZlcnkgdGltZSwgc28KPj4gICAgIGRlZmxhdGUo
KSBuZXZlciBmYWlscyBiZWNhdXNlIHVwZGF0ZSBuZXZlciBoYXBwZW5zLiAgQnV0IGl0J3Mgc2xv
dwo+PiAgICAgc2luY2Ugd2UgY29weSB0aGUgcGFnZXMgZXZlcnkgdGltZS4KPj4gCj4+IDIuIFVz
ZSB0aGUgb2xkIGFwcHJvYWNoLCBhbmQgd2hlbiBjb21wcmVzcygpIGZhaWwsIHdlIGp1c3QgaWdu
b3JlIHRoYXQKPj4gICAgIHBhZ2UgKHNpbmNlIG5vdyB3ZSBrbm93IHRoYXQgZXJyb3IgX211c3Rf
IGJlIGNhdXNlZCBieSBwYWdlIHVwZGF0ZSwKPj4gICAgIHRoZW4gd2UgYXJlIDEwMCUgc3VyZSB0
aGF0IHdlJ2xsIHNlbmQgdGhhdCBwYWdlIGFnYWluIHNvIGl0J2xsIGJlCj4+ICAgICBwZXJmZWN0
bHkgZmluZSkuCj4+IAo+Cj4gTm8sIHdlIGNhbid0IG1ha2UgdGhlIGFzc3VtcHRpb24gdGhhdCAi
ZXJyb3IgX211c3RfIGJlIGNhdXNlZCBieSBwYWdlIHVwZGF0ZSIuIAo+IE5vIGRvY3VtZW50L0FC
SSBhYm91dCBjb21wcmVzcy9kZWNvbXByZXNzIHByb21pc2VkIGl0LiA6KQpTbywgYXMgSSBtZXRp
b25lZCBiZWZvcmUsIGNhbiB3ZSBqdXN0IGRpc3Rpbmd1c2ggdGhlIGRlY29tcHJlc3MvY29tcHJl
c3MgZXJyb3JzIApmcm9tIGVycm9ycyBjYXVzZWQgYnkgcGFnZSB1cGRhdGUgYnkgdGhlIHJldHVy
biBjb2RlIG9mIGluZmxhdGUvZGVmbGF0ZT8KQWNjb3JkaW5nIHRvIHRoZSB6bGliIG1hbnVhbCwg
dGhlcmUgc2VlbXMgdG8gYmUgc2V2ZXJhbCBlcnJvciBjb2RlcyBmb3IgZGlmZmVyZW50IApjYXNl
cywKI2RlZmluZSBaX0VSUk5PICAgICAgICAoLTEpIAojZGVmaW5lIFpfU1RSRUFNX0VSUk9SICgt
MikgCiNkZWZpbmUgWl9EQVRBX0VSUk9SICAgKC0zKSAKI2RlZmluZSBaX01FTV9FUlJPUiAgICAo
LTQpCiNkZWZpbmUgWl9CVUZfRVJST1IgICAgKC01KQojZGVmaW5lIFpfVkVSU0lPTl9FUlJPUiAo
LTYpCkRpZCB5b3UgY2hlY2sgdGhlIHJldHVybiBjb2RlIHdoZW4gc2lsZW50IGZhaWx1cmUobm90
IGNhdXNlZCBieSBwYWdlIHVwZGF0ZSkgCmhhcHBlbmVkIGJlZm9yZT8gOikKCkppYW5nClJlZ2Fy
ZHM=
