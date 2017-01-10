Received: from eggs.gnu.org ([2001:4830:134:3::10]:43183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQulQ-0005i9-WA
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQulN-0000wh-2C
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:38:53 -0500
Received: from [45.249.212.188] (port=2439 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQulG-0000n3-IW
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:38:48 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 10 Jan 2017 11:36:19 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA182ADA@DGGEMA505-MBX.china.huawei.com>
References: <58733617.3050503@huawei.com>
	<20170109134310.GE30228@stefanha-x1.localdomain>
	<20170109162504.GH29989@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182982@DGGEMA505-MBX.china.huawei.com>
	<20170110100355.GD27720@redhat.com>
In-Reply-To: <20170110100355.GD27720@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Question about add AF_ALG backend for virtio-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, longpeng <longpeng2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU-DEV <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>

SGkgRGFuaWVsLA0KDQo+DQo+ID4NCj4gPiA+DQo+ID4gPiBPbiBNb24sIEphbiAwOSwgMjAxNyBh
dCAwMTo0MzoxMFBNICswMDAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6DQo+ID4gPiA+IE9uIE1v
biwgSmFuIDA5LCAyMDE3IGF0IDAzOjA0OjU1UE0gKzA4MDAsIExvbmdwZW5nIChNaWtlKSB3cm90
ZToNCj4gPiA+ID4gPiBJJ20gb25lIG9mIEdvbmdsZWkncyB2aXJ0aW8tY3J5cHRvIHByb2plY3Qg
bWVtYmVycywgYW5kIHdlIHBsYW4gdG8gYWRkIGENCj4gPiA+IEFGX0FMRw0KPiA+ID4gPiA+IGJh
Y2tlbmQgZm9yIHZpcnRpby1jcnlwdG8odGhlcmUncyBvbmx5IGJ1aWx0aW4tYmFja2VuZCBjdXJy
ZW50bHkpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBmb3VuZCB0aGF0IENhdGFsaW4sIFBhb2xv
IGFuZCBTdGVmYW4gaGFkIGRpc2N1c3NlZCBhYm91dCB0aGlzIGluIDIwMTUNCj4gPiA+ID4gPiAo
aHR0cDovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9rdm0vbXNnMTE1NDU3Lmh0bWwpLCBidXQgaXQg
c2VlbXMgdGhhdA0KPiA+ID4gQ2F0YWxpbg0KPiA+ID4gPiA+IGRpZG4ndCBkbyBpdCwgc28gSSdt
IGNvbmZ1c2UgYWJvdXQgd2V0aGVyIGl0IGlzIG5lZWQgdG8gYWRkIGEgQUZfQUxHDQo+ID4gPiBi
YWNrZW5kLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb24/
IFRoYW5rcyA6KQ0KPiA+ID4gPg0KPiA+ID4gPiBJIGhhdmUgbm8gb2JqZWN0aW9ucyB0byBhbiBB
Rl9BTEcgYmFja2VuZCBpbiBRRU1VLg0KPiA+ID4NCj4gPiA+IFJhdGhlciB0aGFuIGRvIGFub3Ro
ZXIgYmFja2VuZCBmb3IgdmlydGlvLWNyeXB0bywgSU1ITywgd2Ugc2hvdWxkIGhhdmUNCj4gPiA+
IGFuIEFGX0FMRyBpbXBsIG9mIHRoZSBjcnlwdG8vIEFQSXMuIFRoYXQgd2F5IGFueSBwb3RlbnRp
YWwgcGVyZm9ybWFuY2UNCj4gPiA+IGJlbmVmaXRzIHdpbGwgZW5oYW5jZSBvdXIgTFVLUyBlbmNy
eXB0aW9uIGNvZGUgdG9vLg0KPiA+ID4NCj4gPiBBY2NvcmRpbmcgdG8gdGhlIGN1cnJlbnRseSBz
Y2hlbWFzIG9mIGNyeXB0by8gQVBJcywgd2UgY2FuJ3QgY2hvb3NlIHRoZQ0KPiA+IHNwZWNpZmlj
IGJhY2tlbmQgZHluYW1pY2FsbHkuIFRoaXMgaXMgYSBsaW1pdGF0aW9uIGZvciB2aXJ0aW8tY3J5
cHRvDQo+ID4gZGV2aWNlIEkgdGhpbmsuDQo+IA0KPiBEbyB3ZSByZWFsbHkgbmVlZCB0byBiZSBh
YmxlIHRvIGNob29zZSB0aGUgYmFja2VuZCBleHBsaWNpdGx5LiBJZiB0aGUgQUZfQUxHDQo+IGJh
Y2tlbmQgaXMgZmFzdGVyLCB3aHkgd291bGQgeW91IHNpbXBseSBub3QgdXNlIHRoYXQgYXV0b21h
dGljYWxseSBpZiBpdCBpcw0KPiBhdmFpbGFibGUuDQoNCkNhbiB3ZSByZWFsaXplIHRoZSBwdXJw
b3NlIGJhc2VkIG9uIHRoZSBjcnlwdG8vIEFQSXM/IElJVUMgdGhlIGNyeXB0bw0Kc3Vic3lzdGVt
IGNob29zZXMgYSBiYWNrZW5kIGR1cmluZyB0aGUgYnVpbGRpbmcgYWNjb3JkaW5nIHRvIHRoZSBz
cGVjaWZpYyBwcmlvcml0eSwNCm5ldHRsZSA+IGdjcnlwdCA+IGNpcGhlci1idWlsdGluLg0KDQpJ
ZiB3ZSBhZGQgYW4gQUZfQUxHIGltcGxlbWVudGF0aW9uIGZvciBjcnlwdG8gc3Vic3lzdGVtLCBz
aGFsbCB3ZSBzZXQgaXQNCmFzIHRoZSBoaWdoZXN0IHByaW9yaXR5PyBJZiBzbywgb3RoZXIgYmFj
a2VuZHMgd29uJ3QgYmUgdXNlZCBzaW5jZSBBRl9BTEcNCmlzIGFsd2F5cyBhdmFpbGFibGUuIElm
IG5vdCwgaG93IGNhbiB3ZSB1c2UgQUZfQUxHIGJhY2tlbmQgZm9yIGNyeXB0by8gQVBJPw0KDQpQ
bGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gbWlzc2luZyBzb21ldGhpbmcuIA0KDQo+IEknbSBub3Qg
c2VlaW5nIGFuIG9idmlvdXMgbmVlZCBmb3IgZHluYW1pY2FsbHkgY2hvb3NpbmcgYmV0d2Vlbg0K
PiBiYWNrZW5kcy4NCj4gDQoNClRoYW5rcywNCi1Hb25nbGVpDQo=
