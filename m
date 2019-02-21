Received: from eggs.gnu.org ([209.51.188.92]:33319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1gwhIB-0001DB-76
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1gwhIA-00062K-4f
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:53:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:42238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1gwhI9-0005yc-SW
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:53:06 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Thu, 21 Feb 2019 05:52:53 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19C95040C@SHSMSX104.ccr.corp.intel.com>
References: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
	<20190220102252.GB2608@work-vm>
	<e76e19a8-1c98-7c62-5587-ab0b898d2473@nvidia.com>
In-Reply-To: <e76e19a8-1c98-7c62-5587-ab0b898d2473@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Add migration support for VFIO
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>, "Yang, Ziye" <ziye.yang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>, "Liu,
	Yi L" <yi.l.liu@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "eauger@redhat.com" <eauger@redhat.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Wang,
	Zhi A" <zhi.a.wang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "yulei.zhang@intel.com" <yulei.zhang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

PiBGcm9tOiBLaXJ0aSBXYW5raGVkZSBbbWFpbHRvOmt3YW5raGVkZUBudmlkaWEuY29tXQ0KPiBT
ZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjEsIDIwMTkgMToyNSBQTQ0KPiANCj4gT24gMi8yMC8y
MDE5IDM6NTIgUE0sIERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgd3JvdGU6DQo+ID4gKiBLaXJ0aSBX
YW5raGVkZSAoa3dhbmtoZWRlQG52aWRpYS5jb20pIHdyb3RlOg0KPiA+PiBBZGQgbWlncmF0aW9u
IHN1cHBvcnQgZm9yIFZGSU8gZGV2aWNlDQo+ID4NCj4gPiBIaSBLaXJ0aSwNCj4gPiAgIENhbiB5
b3UgZXhwbGFpbiBob3cgdGhpcyBjb21wYXJlcyBhbmQgd29ya3Mgd2l0aCBZYW4gWmhhbydzDQo+
ID4gc2V0Pw0KPiANCj4gVGhpcyBwYXRjaCBzZXQgaXMgaW5jcmVtZW50YWwgdmVyc2lvbiBvZiBt
eSBwcmV2aW91cyBwYXRjaCBzZXQ6DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvY292
ZXIvMTAwMDcxOS8NCj4gVGhpcyB0YWtlcyBjYXJlIG9mIHRoZSBmZWVkYmFja3MgcmVjZWl2ZWQg
b24gcHJldmlvdXMgdmVyc2lvbi4NCj4gDQo+IFRoaXMgcGF0Y2ggc2V0IGlzIGRpZmZlcmVudCB0
aGFuIFlhbiBaaGFvJ3Mgc2V0Lg0KPiANCg0KSSBjYW4gaGVscCBnaXZlIHNvbWUgYmFja2dyb3Vu
ZCBhYm91dCBZYW4ncyB3b3JrOg0KDQpUaGVyZSB3YXMgYSBiaWcgZ2FwIGJldHdlZW4gS2lydGkn
cyBsYXN0IHZlcnNpb24gYW5kIHRoZSBvdmVyYWxsIHJldmlldw0KY29tbWVudHMsIGVzcGVjaWFs
bHkgdGhpcyBvbmU6DQpodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL3FlbXUtZGV2ZWxAbm9u
Z251Lm9yZy9tc2c1NzY2NTIuaHRtbA0KDQpUaGVuIHRoZXJlIHdhcyBubyByZXBseSBmcm9tIEtp
cnRpIHdoZXRoZXIgc2hlIGFncmVlZCB3aXRoIHRoZSBjb21tZW50cw0KYW5kIHdhcyB3b3JraW5n
IG9uIGEgbmV3IHZlcnNpb24uDQoNClRoZW4gd2UgdGhpbmsgd2Ugc2hvdWxkIGp1bXAgaW4gdG8g
a2VlcCB0aGUgYmFsbCBtb3ZpbmcsIGJhc2VkIG9uDQphIGZyZXNoIGltcGxlbWVudGF0aW9uIGFj
Y29yZGluZyB0byByZWNvbW1lbmRlZCBkaXJlY3Rpb24sIGkuZS4gZm9jdXNpbmcNCm9uIGRldmlj
ZSBzdGF0ZSBtYW5hZ2VtZW50IGluc3RlYWQgb2Ygc3RpY2tpbmcgdG8gbWlncmF0aW9uIGZsb3cg
aW4ga2VybmVsDQpBUEkgZGVzaWduLg0KDQphbmQgYWxzbyBtb3JlIGltcG9ydGFudGx5IHdlIHBy
b3ZpZGVkIGtlcm5lbCBzaWRlIGltcGxlbWVudGF0aW9uIGJhc2VkDQpvbiBJbnRlbCBHVlQtZyB0
byBnaXZlIHRoZSB3aG9sZSBwaWN0dXJlIG9mIGJvdGggdXNlci9rZXJuZWwgc2lkZSBjaGFuZ2Vz
Lg0KVGhhdCBzaG91bGQgZ2l2ZSBwZW9wbGUgYSBiZXR0ZXIgdW5kZXJzdGFuZGluZyBvZiBob3cg
dGhvc2UgbmV3IEFQSXMNCmFyZSBleHBlY3RlZCB0byBiZSB1c2VkIGJ5IFFlbXUsIGFuZCB0byBi
ZSBpbXBsZW1lbnRlZCBieSB2ZW5kb3IgZHJpdmVyLg0KDQpUaGF0IGlzIHdoeSBZYW4ganVzdCBz
aGFyZWQgaGVyIHdvcmsuDQoNCk5vdyBpdCdzIGdyZWF0IHRvIHNlZSB0aGF0IEtpcnRpIGlzIHN0
aWxsIGFjdGl2ZWx5IHdvcmtpbmcgb24gdGhpcyBlZmZvcnQgYW5kIGlzDQphbHNvIG1vdmluZyB0
b3dhcmQgdGhlIHJpZ2h0IGRpcmVjdGlvbi4gTGV0J3MgaGF2ZSBhIGNsb3NlIGxvb2sgYXQgdHdv
DQppbXBsZW1lbnRhdGlvbnMgYW5kIHRoZW4gY2hvb3NlIGEgY2xlYW5lciBvbmUgYXMgYmFzZSBm
b3IgZnV0dXJlDQplbmhhbmNlbWVudHMuIDotKQ0KDQpUaGFua3MNCktldmluDQo=
