Received: from eggs.gnu.org ([2001:4830:134:3::10]:56184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1e1W4s-0007Ch-D3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1e1W4o-0004Ne-DY
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:18:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1e1W4n-0004Kw-QY
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:18:26 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 9 Oct 2017 11:17:47 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA3FBDD3@DGGEMA505-MBX.china.huawei.com>
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
	<2d8ae3d3-438b-da84-4959-cf63f4f4ce99@linux.vnet.ibm.com>
	<59B9D439.10807@huawei.com>
	<7e490af1-9caa-c96d-5f62-308f1b5d8805@linux.vnet.ibm.com>
	<59BF1E9B.2030408@huawei.com>
	<64d90f78-a2ae-be37-672b-e47aa3d4ecb2@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA3FBCC5@DGGEMA505-MBX.china.huawei.com>
	<7eaac82c-0d8b-47f1-94dd-772b3abf31f9@linux.vnet.ibm.com>
In-Reply-To: <7eaac82c-0d8b-47f1-94dd-772b3abf31f9@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [RFC 0/8]
 virtio-crypto: add multiplexing mode support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "mst@redhat.com" <mst@redhat.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, Luonengjun <luonengjun@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "john.griffin@intel.com" <john.griffin@intel.com>, "agraf@suse.de" <agraf@suse.de>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEhhbGlsIFBhc2ljIFttYWls
dG86cGFzaWNAbGludXgudm5ldC5pYm0uY29tXQ0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMDks
IDIwMTcgNzowNSBQTQ0KPiANCj4gT24gMTAvMDkvMjAxNyAxMToyMiBBTSwgR29uZ2xlaSAoQXJl
aSkgd3JvdGU6DQo+ID4gVGhlIG5leHQgcGF0Y2ggcmVmYWN0b3JzIG1ha2Ugc2Vuc2UgdG8gbWUs
DQo+ID4gYnV0IHdoeSBkbyB3ZSBuZWVkIHRvIGRlY291cGxlIHRoZSB2aXJ0aW8tY3J5cHRvLmg/
DQo+ID4NCj4gPg0KPiANCj4gSSB3YW50ZWQgdG8gYmUgYWJsZSB0byBmcmVlbHkgY2hhbmdlIHRo
ZSBob3N0IHNpZGUgYW5kIHRlc3Qgd2l0aCBhbiB1bmNoYW5nZWQNCj4gZ3Vlc3Qgc2lkZSwgdGhh
dCdzIHdoeSBJJ3ZlIGRvbmUgdGhhdC4gSXQncyBqdXN0IGZvciB0ZXN0aW5nLiBJIGhhZCB0byBk
byB0aGF0DQo+IGJlY2F1c2Ugd2UgZG9uJ3QgaGF2ZSBhIG11eCBjYXBhYmxlIGxpbnV4IGRyaXZl
ci4gTmVpdGhlciBvZiB0aGVzZSBwYXRjaGVzIGlzDQo+IGludGVuZGVkIGZvciBpbmNsdXNpb24u
IEknbSBqdXN0IHRyeWluZyB0byBtYWtlIGEgcG9pbnQgd2l0aCB0aGVtOiB3ZSBjYW4NCj4gbWFr
ZSB0aGlzIHN1YnN0YW50aWFsbHkgc2ltcGxlciAoY29tcGFyZWQgdG8gdGhpcyBSRkMpLg0KPiAN
Ckkgc2VlLg0KDQo+IFNvIGhvdyBkbyB3ZSBwcm9jZWVkIGhlcmU/IEl0IHdvdWxkIGJlIG5pY2Ug
dG8gc2VlIGEgY2xlYW5lZCB1cCB2ZXJzaW9uIG9mDQoNCk1heWJlIExvbmdwZW5nIGNhbiBhcHBs
eSB5b3VyIHRlc3QgcGF0Y2hlcyBpbiB0aGUgZm9sbG93aW5nIHBhdGNoIHNldCB3aGVuDQpoZSBo
YXMgdGltZS4gQExvbmdwZW5nDQoNCj4gdGhpcyBzZXJpZXMgc29vbi4gSWYgSSByZWNhbGwgY29y
cmVjdGx5IHRoZXJlIHdlcmUgYWxzbyBvdGhlciB0aGluZ3Mgd2hpY2gNCj4gY2FuIGJlIGRvbmUg
aW4gYSBsZXNzIGNvbnZvbHV0ZWQgbWFubmVyLg0KPiANCk9oPyBXaGljaCB0aGluZ3M/DQoNCj4g
Pj4gVGhlIGJhc2ljIGlkZWEgYmVoaW5kIHRoZSB3aG9sZSB0aGluZyBpcyB0aGF0IHRpbmdpbmcg
YWJvdXQgdGhlIHJlcXVlc3RzIHB1dA0KPiA+PiBvbiB0aGUgdmlydHF1ZXVlcyBpbiB0ZXJtcyBv
ZiBqdXN0IGNvbXBsaWNhdGVzIHRoaW5ncyB1bm5lY2Vzc2FyaWx5Lg0KPiA+Pg0KPiA+PiBJIGNv
dWxkIGd1ZXNzIEkgd2lsbCBwb3N0IHRoZSBpbnRlcmVzdGluZyBwYXJ0IGFzIGEgcmVwbHkgdG8g
dGhpcyBhbmQgdGhlIGxlc3MNCj4gPj4gaW50ZXJlc3RpbmcgcGFydCAoZGVjb3VwbGluZykgYXMg
YW4gYXR0YWNobWVudC4gWW91IGFyZSBzdXBwb3NlZCB0byBhcHBseQ0KPiBmaXJzdA0KPiA+PiB0
aGUgYXR0YWNobWVudCB0aGVuIHRoZSBwYXJ0IGFmdGVyIHRoZSBzY2lzc29ycyBsaW5lLg0KPiA+
Pg0KPiA+PiBPZiBjb3Vyc2Ugc2hvdWxkIHlvdSBjb3VsZCByZXNwaW4gdGhlIHNlcmllcyBwcmVm
ZXJhYmx5IHdpdGggdGhlIHRlc3QNCj4gPj4gaW5jbHVkZWQgSSBjYW4gcmViYXNlIG15IHN0dWZm
Lg0KPiA+Pg0KPiA+PiBQbGVhc2UgbGV0IG1lIGtub3cgYWJvdXQgeW91ciBvcGluaW9uLg0KPiA+
Pg0KPiA+IFRoYW5rcyBmb3IgeW91ciB3b3JrLCBIYWxpbC4gV2hhdCdzIHlvdXIgb3BpbmlvbiBh
Ym91dCB2aXJ0aW8gY3J5cHRvIHNwZWMgdjIwPw0KPiANCj4gSSdtIG9uIGl0LiBJJ3ZlIGFscmVh
ZHkgc3RhcnRlZCB3aXR0aW5nIG9uIEZyaWRheSBidXQgdGhpbmdzIHR1cm5lZCBvdXQgYSBiaXQg
bW9yZQ0KPiBpbnRlcmVzdGluZyB0aGF0IGV4cGVjdGVkLiBTbyBJJ3ZlIHBvc3Rwb25lZCB0byB0
b2RheS4gT2YgY291cnNlIHRoZSB0d28gdGhpbmdzDQo+IGFyZQ0KPiBjb25uZWN0ZWQuIEkgd2ls
bCB0cnkgdG8gZ2l2ZSBzb21lIGZlZWRiYWNrIHRvZGF5Lg0KPiANClNvdW5kcyBnb29kLg0KDQpU
aGFua3MsDQotR29uZ2xlaQ0KDQo=
