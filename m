Received: from eggs.gnu.org ([2001:4830:134:3::10]:48645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eMr67-0003pq-DK
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 03:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eMr62-0007yj-Es
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 02:59:59 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:4437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eMr61-0007yN-Rh
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 02:59:54 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 7 Dec 2017 07:59:28 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4CC4FC@DGGEMA505-MBS.china.huawei.com>
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
	<1512545840-10256-2-git-send-email-longpeng2@huawei.com>
	<0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
In-Reply-To: <0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>

PiANCj4gT24gMTIvMDYvMjAxNyAwODozNyBBTSwgTG9uZ3BlbmcoTWlrZSkgd3JvdGU6DQo+ID4g
K1xmaWVsZHtvdXRjb21lX2xlbn0gaXMgdGhlIHNpemUgb2Ygc3RydWN0IHZpcnRpb19jcnlwdG9f
c2Vzc2lvbl9pbnB1dCBvcg0KPiA+ICtaRVJPIGZvciB0aGUgc2Vzc2lvbi1kZXN0cm95IG9wZXJh
dGlvbi4NCj4gDQo+IFRoaXMgYWluJ3QgY29ycmVjdC4gSXQgc2hvdWxkIGhhdmUgYmVlbiBzb21l
dGhpbmcgbGlrZQ0KPiB2aXJ0aW9fY3J5cHRvX2Rlc3Ryb3lfc2Vzc2lvbl9pbnB1dC4NCj4gDQpS
aWdodCwgd2lsbCBmaXggaXQuDQoNCj4gPiArDQo+ID4gKw0KPiA+ICtccGFyYWdyYXBoe1Nlc3Np
b24gb3BlcmF0aW9ufVxsYWJlbHtzZWM6RGV2aWNlIFR5cGVzIC8gQ3J5cHRvIERldmljZSAvDQo+
IERldmljZQ0KPiA+ICtPcGVyYXRpb24gLyBDb250cm9sIFZpcnRxdWV1ZSAvIFNlc3Npb24gb3Bl
cmF0aW9ufQ0KPiA+ICsNCj4gPiArVGhlIHNlc3Npb24gaXMgYSBoYW5kbGUgd2hpY2ggZGVzY3Jp
YmVzIHRoZSBjcnlwdG9ncmFwaGljIHBhcmFtZXRlcnMgdG8gYmUNCj4gPiArYXBwbGllZCB0byBh
IG51bWJlciBvZiBidWZmZXJzLg0KPiA+ICsNCj4gPiArVGhlIGZvbGxvd2luZyBzdHJ1Y3R1cmUg
c3RvcmVzIHRoZSByZXN1bHQgb2Ygc2Vzc2lvbiBjcmVhdGlvbiBzZXQgYnkgdGhlDQo+IGRldmlj
ZToNCj4gPiArDQo+ID4gK1xiZWdpbntsc3RsaXN0aW5nfQ0KPiA+ICtzdHJ1Y3QgdmlydGlvX2Ny
eXB0b19zZXNzaW9uX2lucHV0IHsNCj4gPiArICAgIC8qIERldmljZSB3cml0ZSBvbmx5IHBvcnRp
b24gKi8NCj4gPiArICAgIGxlNjQgc2Vzc2lvbl9pZDsNCj4gPiArICAgIGxlMzIgc3RhdHVzOw0K
PiA+ICsgICAgbGUzMiBwYWRkaW5nOw0KPiA+ICt9Ow0KPiA+ICtcZW5ke2xzdGxpc3Rpbmd9DQo+
ID4gKw0KPiA+ICtBIHJlcXVlc3QgdG8gZGVzdHJveSBhIHNlc3Npb24gaW5jbHVkZXMgdGhlIGZv
bGxvd2luZyBpbmZvcm1hdGlvbjoNCj4gPiArDQo+ID4gK1xiZWdpbntsc3RsaXN0aW5nfQ0KPiA+
ICtzdHJ1Y3QgdmlydGlvX2NyeXB0b19kZXN0cm95X3Nlc3Npb25fZmxmIHsNCj4gPiArICAgIC8q
IERldmljZSByZWFkIG9ubHkgcG9ydGlvbiAqLw0KPiA+ICsgICAgbGU2NCAgc2Vzc2lvbl9pZDsN
Cj4gPiArICAgIC8qIERldmljZSB3cml0ZSBvbmx5IHBvcnRpb24gKi8NCj4gDQo+IFRoaXMgaXMg
dGhlIGRldmljZSB3cml0YWJsZSBwb3J0aW9uIGFuZCB0aHVzIHdoYXQgd2UgY2FsIG9wX291dGNv
bWUgYWJvdmUuDQo+IFNvIGl0IHNob3VsZCBoYXZlIGJlZW4NCj4gfTsNCj4gDQo+IA0KPiBzdHJ1
Y3QgdmlydGlvX2NyeXB0b19kZXN0cm95X3Nlc3Npb25faW5wdXQgew0KPiA+ICsgICAgbGUzMiAg
c3RhdHVzOw0KPiA+ICsgICAgbGUzMiAgcGFkZGluZzsNCj4gPiArfTsNCj4gDQo+IElmIHdlIGFy
ZW4ndCBjb25zaXN0ZW50IGFib3V0IGl0IHRoZSBkaXZpZGluZyBpbnRvIHBhcnRzIChsaWtlIG9w
IHNwZWNpZmljDQo+IGZpeGVkIGFuZCB2YXJpYWJsZSBsZW5ndGggKG91dHB1dCkgZmllbGRzLCBv
cGVyYXRpb24gb3V0Y29tZSAoaW5wdXQpKQ0KPiBpc24ndCByZWFsbHkgaGVscGZ1bC4NCj4gDQpJ
dCdzIG9rIHRvIHVzLCB3ZSBjYW4gZG8gaXQuIEFueSBvdGhlciBjb21tZW50cz8NCg0KVGhhbmtz
LA0KLUdvbmdsZWkNCg0K
