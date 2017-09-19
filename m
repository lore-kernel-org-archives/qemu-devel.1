Received: from eggs.gnu.org ([2001:4830:134:3::10]:54882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xin.zeng@intel.com>) id 1duDTi-0002mu-Aa
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xin.zeng@intel.com>) id 1duDTb-0000Xs-R8
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:01:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:33161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xin.zeng@intel.com>) id 1duDTb-0000Vj-FY
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:01:51 -0400
From: "Zeng, Xin" <xin.zeng@intel.com>
Date: Tue, 19 Sep 2017 08:01:46 +0000
Message-ID: <82063967A54EF84C8AFCD6BD7F6AD93310E11D28@SHSMSX103.ccr.corp.intel.com>
References: <1505092362-10544-1-git-send-email-longpeng2@huawei.com>
	<1505092362-10544-2-git-send-email-longpeng2@huawei.com>
	<67d5549e-84de-ee85-00a7-37edc52234c4@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA3D9A7B@DGGEMA505-MBX.china.huawei.com>
	<73b9f2a8-6746-593b-4277-3ea757476130@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA3D9B61@DGGEMA505-MBX.china.huawei.com>
	<82063967A54EF84C8AFCD6BD7F6AD93310E1111B@SHSMSX103.ccr.corp.intel.com>
	<e7e10450-806a-00f6-f9d3-65460b692f34@linux.vnet.ibm.com>
In-Reply-To: <e7e10450-806a-00f6-f9d3-65460b692f34@linux.vnet.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH REPOST v19 1/2]
 virtio-crypto: Add virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng <longpeng2@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Griffin,
	John" <john.griffin@intel.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "Ma, Liang J" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Keating,
	Brian A" <brian.a.keating@intel.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>

b24gU2VwdGVtYmVyIDE5LCAyMDE3IDEyOjMzIEFNIEhhbGlsIFBhc2ljIFdyb3RlOg0KPCA+IDwg
PiA+PiBEZXN0cm95IGRvZXMgbm90IG5lZWQgdG8gc3BlY2lmeSBxdWV1ZV9pZC4gVGhhdCBtZWFu
cyBzZXNzaW9uX2lkJ3MNCjwgYXJlbid0DQo8ID4gPCA+ID4+IHF1ZXVlIHNjb3BlZCBmcm9tIG5h
bWVzcGFjZSBwZXJzcGVjdGl2ZS4gVGhlIHF1ZXN0aW9uIHJlbWFpbnMgd2hhdA0KPCBpcw0KPCA+
IDwgPiA+PiBxdWV1ZV9pZCBnb29kIGZvciwgYW5kIHdoZXRoZXIgYSBzZXNzaW9uIHR5cGUgb3Ag
cmVxdWVzdCBzaG91bGQgYmUNCjwgPiA8ID4gPj4gcmVqZWN0ZWQgaWYgdGhlIHRoZSBzZXNzaW9u
IGlkIG9yaWdpbmF0ZXMgZnJvbSBhIHNlc3Npb24gY3JlYXRpb24NCjwgPiA8ID4gPj4gcmVxdWVz
dCBzcGVjaWZ5aW5nIGEgZGlmZmVyZW50IGRhdGFxdWV1ZSAobm90IHRoZSBkYXRhcXVldWUgY29u
dGFpbmluZw0KPCA+IDwgPiA+PiB0aGUgZ2l2ZW4gcmVxdWVzdCk/DQo8ID4gPCA+ID4+DQo8ID4g
PCA+ID4gTXkgb3JpZ2luYWwgaWRlYSBhYm91dCB0aGUgcXVldWVfaWQgaXMgdXNpbmcgdGhlIHF1
ZXVlX2lkIHRvIHNwZWNpZnkNCjwgd2hpY2gNCjwgPiA8ID4gPiBkYXRlcXVldWUgb2YgdGhlIGZv
bGxvd2luZyBkYXRhIHJlcXVlc3RzIHdpbGwgYmUgdXNlZC4gQnV0IGFmdGVyIGRlZXANCjwgPiA8
ID4gdGhpbmtpbmcsDQo8ID4gPCA+ID4gSSBmaW5kIHRoYXQgdGhlIHF1ZXVlX2lkIGlzIHN1cGVy
Zmx1b3VzLCBhbmQgdGhlIGN1cnJlbnQgY29kZSBpbiBRRU1VDQo8IGFsc28NCjwgPiA8ID4gPiBk
b24ndCB1c2UgdGhlIHF1ZXVlX2lkIHZhbHVlIGFzIHdlbGwuIFRoYXQncyBiZWNhdXNlIHRoZSB3
ZSBjYW4gdXNlDQo8ID4gPCA+IHNlc3Npb25faWQNCjwgPiA8ID4gPiB0byBmaW5kIHRoZSBwZXJ2
aW91cyBzZXNzaW9uIGluZm9ybWF0aW9uIGFuZCBnZXQgdGhlIGN1cnJlbnQgZGF0YXF1ZXVlIGlk
DQo8ID4gPCA+ID4gZnJvbSB0aGUgdXNlZCB2aXJ0cXVldWUgLg0KPCA+IDwgPiA+DQo8ID4gPCA+
ID4gU28gbWF5YmUgd2Ugc2hvdWxkIGRyb3AgdGhlIHF1ZXVlX2lkIHRoaXMgdGltZS4NCjwgPiA8
ID4gPg0KPCA+IDwgPiA+DQo8ID4gPCA+DQo8ID4gPCA+IFNvdW5kcyByZWFzb25hYmxlIHRvIG1l
LiBXZSBjYW4gbWFrZSBpdCByZXNlcnZlZCBhbmQgaWdub3JlZCBpbg0KPCA+IDwgPiB0aGUgc3Bl
Y2lmaWNhdGlvbi4gTGludXggdXNlcyBpdCwgYnV0IGl0J3MgYWx3YXlzIHNldCB0byAwIGFzIHdl
IG9ubHkNCjwgPiA8ID4gc3VwcG9ydCBvbmUgZGF0YS1xdWV1ZSAoaWYgSSdtIG5vdCB3cm9uZyku
IFNvIHJlc2VydmVkIGFuZCBtdXN0IGJlIHplcm8NCjwgPiA8ID4gaXMgYW4gb3B0aW9uIHRvby4N
CjwgPiA8ID4NCjwgPiA8IE1ha2VzIHNlbnNlIHRvIGtlZXBpbmcgY29tcGF0aWJpbGl0eS4NCjwg
PiA8DQo8ID4NCjwgPiBJZiB3ZSBhbHdheXMgc2V0IGl0IHRvIDAsIGFuZCBiYWNrZW5kIGRldmlj
ZSBkb2Vzbid0IHNwZWNpZnkgdGhlIHF1ZXVlDQo8ID4gaWQgd2hlbiBjcmVhdGluZyBzZXNzaW9u
LCB0aGlzIHdvcmtzIG9ubHkgd2hlbiBvbmUgZGF0YSBxdWV1ZSBpcw0KPCA+IHN1cHBvcnRlZC4g
QnV0IGlmIHdlIHdhbnQgdG8gc3VwcG9ydCBtdWx0aSBkYXRhIHF1ZXVlcywNCjwgPiBob3cgZG9l
cyBmcm9udGVuZCBkcml2ZXIga25vdyB3aGljaCBxdWV1ZSBpdCBzaG91bGQgdXNlIHdoZW4NCjwg
PiBzZW5kaW5nIHJlcXVlc3RzIHRvIHRoZSB2aXJ0IHF1ZXVlPyBBbmQgZnVydGhlcm1vcmUsIGlm
IHRoZSBkYXRhIHF1ZXVlDQo8ID4gaWQgd2hpY2ggY2FuIGJlIHVzZWQgaXMgZGV0ZXJtaW5lZCBi
eSBiYWNrZW5kIGRldmljZSwgaG93IGRvZXMNCjwgPiBndWVzdCBmcm9udGVuZCBkcml2ZXIga25v
dyB3aGljaCBxdWV1ZSBjYW4gYmUgdXNlZCB3aGVuIG9wZXJhdGluZw0KPCA+IGluIHN0YXRlbGVz
cyBtb2RlIGluIGNhc2UgbXVsdGkgZGF0YSBxdWV1ZSBpcyBzdXBwb3J0ZWQ/DQo8IA0KPCBBRkFJ
VSB5b3UgYW5zd2VyZWQgeW91ciBvd24gcXVlc3Rpb25zIChxdWVzdGlvbnMgYWJvdmUsIGFuc3dl
cnMgYmVsb3cpLg0KPCBHb25nbGVpDQo8IGhhcyBqdXN0IHN0YXRlZCB0aGF0IGhlIGludGVuZHMg
dG8gYWJhbmRvbiB0aGUgcXVldWVfaWQuDQo8IA0KPCA+IFNvIGZyb20gbXkgcG9pbnQgb2Ygdmll
dywgc2Vzc2lvbiBzaG91bGQgb25seSBiZSBhc3NvY2lhdGVkIHdpdGggc2VydmljZQ0KPCA+IHJl
bGF0ZWQgaW5mb3JtYXRpb24sIGJ1dCBub3QgYXNzb2NpYXRlZCB3aXRoIHRoZSB0cmFuc3BvcnQg
bGF5ZXIgaW5mb3JtYXRpb24sDQo8ID4gaS5lLiBkYXRhIHF1ZXVlIGlkIGluIHRoaXMgY2FzZS4g
VGhlIGRhdGEgcXVldWUgdG8gYmUgdXNlZCBzaG91bGQgYmUgY2hvc2VuIGJ5DQo8ID4gZnJvbnRl
bmQgZHJpdmVyLiBGcm9udGVuZCBkcml2ZXIgY2FuIHVzZSBhbnkgdmFsaWQgZGF0YSBxdWV1ZSB0
byBzZW5kIHJlcXVlc3RzDQo8ID4gdG8gYmFja2VuZCBkZXZpY2UsIGJhY2tlbmQgZGV2aWNlIG5l
ZWQgdG8gZXh0cmFjdCB0aGUgc2Vzc2lvbiBpbmZvcm1hdGlvbg0KPCA+IGZyb20gdGhlIHJlcXVl
c3QgcGFja2V0IGFuZCByZXRyaWV2ZSB0aGUgcmVxdWVzdCdzIHNlc3Npb24gaW5mbyB0aGVuIGhh
bmRsZSBpdA0KPCA+IGNvcnJlc3BvbmRpbmdseS4NCjwgDQo8IEFGQUlVIHRoYXQncyB3aGF0IHdl
IGhhdmUgYWdyZWVkLCBiYXNpY2FsbHkuIEknbSBub3Qgc3VyZSBhYm91dCB5b3VyIHdvcmRpbmcN
CjwgKGZvciBpbnN0YW5jZSBJIHdvdWxkIGhhdmUgc2FpZCBzZXNzaW9uIGlkZW50aWZpZXIgaW5z
dGVhZCBvZiBzZXNzaW9uIGluZm9ybWF0aW9uKSwNCjwgYnV0IEkgdGhpbmsgd2UgdGhpbmsgdGhl
IHNhbWUuIEluIHNob3J0IGNvbmNlcHR1YWxseSBhbGwgY29uZmlndXJlZCBkYXRhIHF1ZXVlcw0K
PCBhcmUgZXF1aXZhbGVudCBpbiB0aGUgc2Vuc2UgdGhhdCBpdCBkb2VzIG5vdCBtYXR0ZXIgb24g
d2hpY2ggcXVldWUgYSByZXF1ZXN0IGlzDQo8IHBsYWNlZCAtLSBtb2R1bG8gY2FwYWNpdHkuDQoN
CkFjdHVhbGx5IEkgYWdyZWVkIHdpdGggeW91ciBwb2ludCB0byBtYWtlIHF1ZXVlX2lkIHJlc2Vy
dmVkICBpbiANCmN1cnJlbnQgaW1wbGVtZW50YXRpb24gYW5kIGlnbm9yZWQgaW4gdGhlIHNwZWMu
IEkganVzdCB3YW50IHRvIGNsYXJpZnkgdGhlIA0KdXNhZ2Ugb2YgdmlydCBxdWV1ZXMgZXNwZWNp
YWxseSB3aGVuIG11bHRpIGRhdGEgcXVldWUgaXMgc3VwcG9ydGVkLg0KTm93IGl0J3MgY2xlYXIs
IHRoYW5rcy4NCg0KQ2hlZXJzDQpYaW4NCg0KPCANCjwgSGFsaWwNCjwgDQo8ID4NCjwgPiA8IFRo
YW5rcywNCjwgPiA8IC1Hb25nbGVpDQo8ID5uDQo8IA0KPCANCjwgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo8IFRv
IHVuc3Vic2NyaWJlLCBlLW1haWw6IHZpcnRpby1kZXYtdW5zdWJzY3JpYmVAbGlzdHMub2FzaXMt
b3Blbi5vcmcNCjwgRm9yIGFkZGl0aW9uYWwgY29tbWFuZHMsIGUtbWFpbDogdmlydGlvLWRldi1o
ZWxwQGxpc3RzLm9hc2lzLW9wZW4ub3JnDQoNCg==
