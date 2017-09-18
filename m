Received: from eggs.gnu.org ([2001:4830:134:3::10]:51695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dtw1x-0004Gt-2L
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dtw1r-0006kH-DO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:24:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dtw1p-0006hv-Oe
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:24:03 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 18 Sep 2017 13:23:31 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA3D9B61@DGGEMA505-MBX.china.huawei.com>
References: <1505092362-10544-1-git-send-email-longpeng2@huawei.com>
	<1505092362-10544-2-git-send-email-longpeng2@huawei.com>
	<67d5549e-84de-ee85-00a7-37edc52234c4@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA3D9A7B@DGGEMA505-MBX.china.huawei.com>
	<73b9f2a8-6746-593b-4277-3ea757476130@linux.vnet.ibm.com>
In-Reply-To: <73b9f2a8-6746-593b-4277-3ea757476130@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH REPOST v19 1/2] virtio-crypto: Add virtio
 crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEhhbGlsIFBhc2ljIFttYWls
dG86cGFzaWNAbGludXgudm5ldC5pYm0uY29tXQ0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAx
OCwgMjAxNyA5OjA4IFBNDQo+IFN1YmplY3Q6IFJlOiBbUWVtdS1kZXZlbF0gW1BBVENIIFJFUE9T
VCB2MTkgMS8yXSB2aXJ0aW8tY3J5cHRvOiBBZGQgdmlydGlvDQo+IGNyeXB0byBkZXZpY2Ugc3Bl
Y2lmaWNhdGlvbg0KPiANCj4gDQo+IA0KPiBPbiAwOS8xOC8yMDE3IDAyOjEzIFBNLCBHb25nbGVp
IChBcmVpKSB3cm90ZToNCj4gPj4gRGVzdHJveSBkb2VzIG5vdCBuZWVkIHRvIHNwZWNpZnkgcXVl
dWVfaWQuIFRoYXQgbWVhbnMgc2Vzc2lvbl9pZCdzIGFyZW4ndA0KPiA+PiBxdWV1ZSBzY29wZWQg
ZnJvbSBuYW1lc3BhY2UgcGVyc3BlY3RpdmUuIFRoZSBxdWVzdGlvbiByZW1haW5zIHdoYXQgaXMN
Cj4gPj4gcXVldWVfaWQgZ29vZCBmb3IsIGFuZCB3aGV0aGVyIGEgc2Vzc2lvbiB0eXBlIG9wIHJl
cXVlc3Qgc2hvdWxkIGJlDQo+ID4+IHJlamVjdGVkIGlmIHRoZSB0aGUgc2Vzc2lvbiBpZCBvcmln
aW5hdGVzIGZyb20gYSBzZXNzaW9uIGNyZWF0aW9uDQo+ID4+IHJlcXVlc3Qgc3BlY2lmeWluZyBh
IGRpZmZlcmVudCBkYXRhcXVldWUgKG5vdCB0aGUgZGF0YXF1ZXVlIGNvbnRhaW5pbmcNCj4gPj4g
dGhlIGdpdmVuIHJlcXVlc3QpPw0KPiA+Pg0KPiA+IE15IG9yaWdpbmFsIGlkZWEgYWJvdXQgdGhl
IHF1ZXVlX2lkIGlzIHVzaW5nIHRoZSBxdWV1ZV9pZCB0byBzcGVjaWZ5IHdoaWNoDQo+ID4gZGF0
ZXF1ZXVlIG9mIHRoZSBmb2xsb3dpbmcgZGF0YSByZXF1ZXN0cyB3aWxsIGJlIHVzZWQuIEJ1dCBh
ZnRlciBkZWVwDQo+IHRoaW5raW5nLA0KPiA+IEkgZmluZCB0aGF0IHRoZSBxdWV1ZV9pZCBpcyBz
dXBlcmZsdW91cywgYW5kIHRoZSBjdXJyZW50IGNvZGUgaW4gUUVNVSBhbHNvDQo+ID4gZG9uJ3Qg
dXNlIHRoZSBxdWV1ZV9pZCB2YWx1ZSBhcyB3ZWxsLiBUaGF0J3MgYmVjYXVzZSB0aGUgd2UgY2Fu
IHVzZQ0KPiBzZXNzaW9uX2lkDQo+ID4gdG8gZmluZCB0aGUgcGVydmlvdXMgc2Vzc2lvbiBpbmZv
cm1hdGlvbiBhbmQgZ2V0IHRoZSBjdXJyZW50IGRhdGFxdWV1ZSBpZA0KPiA+IGZyb20gdGhlIHVz
ZWQgdmlydHF1ZXVlIC4NCj4gPg0KPiA+IFNvIG1heWJlIHdlIHNob3VsZCBkcm9wIHRoZSBxdWV1
ZV9pZCB0aGlzIHRpbWUuDQo+ID4NCj4gPg0KPiANCj4gU291bmRzIHJlYXNvbmFibGUgdG8gbWUu
IFdlIGNhbiBtYWtlIGl0IHJlc2VydmVkIGFuZCBpZ25vcmVkIGluDQo+IHRoZSBzcGVjaWZpY2F0
aW9uLiBMaW51eCB1c2VzIGl0LCBidXQgaXQncyBhbHdheXMgc2V0IHRvIDAgYXMgd2Ugb25seQ0K
PiBzdXBwb3J0IG9uZSBkYXRhLXF1ZXVlIChpZiBJJ20gbm90IHdyb25nKS4gU28gcmVzZXJ2ZWQg
YW5kIG11c3QgYmUgemVybw0KPiBpcyBhbiBvcHRpb24gdG9vLg0KPiANCk1ha2VzIHNlbnNlIHRv
IGtlZXBpbmcgY29tcGF0aWJpbGl0eS4gDQoNClRoYW5rcywNCi1Hb25nbGVpDQo=
