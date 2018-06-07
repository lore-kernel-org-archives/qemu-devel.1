Received: from eggs.gnu.org ([2001:4830:134:3::10]:36384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fQtaB-0004VK-MX
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fQta8-0006Y0-K4
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:59:59 -0400
Received: from [45.249.212.255] (port=55516 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1fQta8-0006WJ-6k
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:59:56 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 7 Jun 2018 11:13:02 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB012108@dggeml511-mbx.china.huawei.com>
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
	<50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
	<bbb4f800-1d16-3dcc-9abb-8a3024777923@redhat.com>
In-Reply-To: <bbb4f800-1d16-3dcc-9abb-8a3024777923@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] An emulation failure occurs,
 if I hotplug vcpus immediately after the VM start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, xuyandong <xuyandong2@huawei.com>
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhdmlkIEhpbGRlbmJyYW5k
IFttYWlsdG86ZGF2aWRAcmVkaGF0LmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMDcsIDIw
MTggNjo0MCBQTQ0KPiBTdWJqZWN0OiBSZTogQW4gZW11bGF0aW9uIGZhaWx1cmUgb2NjdXJzLGlm
IEkgaG90cGx1ZyB2Y3B1cyBpbW1lZGlhdGVseSBhZnRlciB0aGUNCj4gVk0gc3RhcnQNCj4gDQo+
IE9uIDA2LjA2LjIwMTggMTU6NTcsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+ID4gT24gMDYvMDYv
MjAxOCAxNToyOCwgR29uZ2xlaSAoQXJlaSkgd3JvdGU6DQo+ID4+IGdvbmdsZWkqKioqKioqKjog
bWVtLnNsb3Q6IDMsIG1lbS5ndWVzdF9waHlzX2FkZHI9MHhjMDAwMCwNCj4gPj4gbWVtLnVzZXJz
cGFjZV9hZGRyPTB4N2ZjMzQzZWMwMDAwLCBtZW0uZmxhZ3M9MCwgbWVtb3J5X3NpemU9MHgwDQo+
ID4+IGdvbmdsZWkqKioqKioqKjogbWVtLnNsb3Q6IDMsIG1lbS5ndWVzdF9waHlzX2FkZHI9MHhj
MDAwMCwNCj4gPj4gbWVtLnVzZXJzcGFjZV9hZGRyPTB4N2ZjMzQzZWMwMDAwLCBtZW0uZmxhZ3M9
MCwNCj4gbWVtb3J5X3NpemU9MHg5MDAwDQo+ID4+DQo+ID4+IFdoZW4gdGhlIG1lbW9yeSByZWdp
b24gaXMgY2xlYXJlZCwgdGhlIEtWTSB3aWxsIHRlbGwgdGhlIHNsb3QgdG8gYmUNCj4gPj4gaW52
YWxpZCAod2hpY2ggaXQgaXMgc2V0IHRvIEtWTV9NRU1TTE9UX0lOVkFMSUQpLg0KPiA+Pg0KPiA+
PiBJZiBTZWFCSU9TIGFjY2Vzc2VzIHRoaXMgbWVtb3J5IGFuZCBjYXVzZSBwYWdlIGZhdWx0LCBp
dCB3aWxsIGZpbmQgYW4NCj4gPj4gaW52YWxpZCB2YWx1ZSBhY2NvcmRpbmcgdG8gZ2ZuIChieSBf
X2dmbl90b19wZm5fbWVtc2xvdCksIGFuZCBmaW5hbGx5DQo+ID4+IGl0IHdpbGwgcmV0dXJuIGFu
IGludmFsaWQgdmFsdWUsIGFuZCBmaW5hbGx5IGl0IHdpbGwgcmV0dXJuIGENCj4gPj4gZmFpbHVy
ZS4NCj4gPj4NCj4gPj4gU28sIE15IHF1ZXN0aW9ucyBhcmU6DQo+ID4+DQo+ID4+IDEpIFdoeSBk
b24ndCB3ZSBob2xkIGt2bS0+c2xvdHNfbG9jayBkdXJpbmcgcGFnZSBmYXVsdCBwcm9jZXNzaW5n
Pw0KPiA+DQo+ID4gQmVjYXVzZSBpdCdzIHByb3RlY3RlZCBieSBTUkNVLiAgV2UgZG9uJ3QgbmVl
ZCBrdm0tPnNsb3RzX2xvY2sgb24gdGhlDQo+ID4gcmVhZCBzaWRlLg0KPiA+DQo+ID4+IDIpIEhv
dyBkbyB3ZSBhc3N1cmUgdGhhdCB2Y3B1cyB3aWxsIG5vdCBhY2Nlc3MgdGhlIGNvcnJlc3BvbmRp
bmcNCj4gPj4gcmVnaW9uIHdoZW4gZGVsZXRpbmcgYW4gbWVtb3J5IHNsb3Q/DQo+ID4NCj4gPiBX
ZSBkb24ndC4gIEl0J3MgZ2VuZXJhbGx5IGEgZ3Vlc3QgYnVnIGlmIHRoZXkgZG8sIGJ1dCB0aGUg
cHJvYmxlbSBoZXJlDQo+ID4gaXMgdGhhdCBRRU1VIGlzIHNwbGl0dGluZyBhIG1lbW9yeSByZWdp
b24gaW4gdHdvIHBhcnRzIGFuZCB0aGF0IGlzIG5vdA0KPiA+IGF0b21pYy4NCj4gDQo+IEJUVywg
b25lIHVnbHkgKGJ1dCBRRU1VLW9ubHkpIGZpeCB3b3VsZCBiZSB0byB0ZW1wb3JhcmlseSBwYXVz
ZSBhbGwNCj4gVkNQVXMsIGRvIHRoZSBjaGFuZ2UgYW5kIHRoZW4gdW5wYXVzZSBhbGwgVkNQVXMu
DQo+IA0KDQpUaGUgdXBkYXRpbmcgcHJvY2VzcyBvZiBtZW1vcnkgcmVnaW9uIGlzIHRyaWdnZXJl
ZCBieSB2Y3B1IHRocmVhZCwgbm90DQp0aGUgbWFpbiBwcm9jZXNzIHRob3VnaC4NCg0KVGhhbmtz
LA0KLUdvbmdsZWkNCg0KPiA+DQo+ID4gT25lIGZpeCBjb3VsZCBiZSB0byBhZGQgYSBLVk1fU0VU
X1VTRVJfTUVNT1JZX1JFR0lPTlMgaW9jdGwgdGhhdA0KPiA+IHJlcGxhY2VzIHRoZSBlbnRpcmUg
bWVtb3J5IG1hcCBhdG9taWNhbGx5Lg0KPiA+DQo+ID4gUGFvbG8NCj4gPg0KPiANCj4gDQo+IC0t
DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBEYXZpZCAvIGRoaWxkZW5iDQo=
