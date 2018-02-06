Received: from eggs.gnu.org ([2001:4830:134:3::10]:49866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eirNI-0003No-Q5
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 19:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eirNE-00084y-NT
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 19:44:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:6462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eirNE-00080a-F5
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 19:44:36 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 6 Feb 2018 00:44:28 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B60CBB2@SHSMSX103.ccr.corp.intel.com>
References: <5A7867F5.6080500@redhat.com>
In-Reply-To: <5A7867F5.6080500@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] virtio-blk discard support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cathy Avery <cavery@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

SGkgQ2F0aHksDQoNCkFjdHVhbGx5IHRoZSBjb2RlIGRldmVsb3BtZW50IGZyb20gbXkgc2lkZSBo
YXMgYmVlbiBkb25lIGZvciBhIHdoaWxlLCBpbmNsdWRlDQpESVNDQVJEL1dSSVRFIFpFUk9FUy9X
UklURSBaRVJPRVMgd2l0aCBEaXNjYXJkIEJpdCwgY3VycmVudGx5DQpJJ20gd3JpdGluZyB0aGUg
c3BlY2lmaWNhdGlvbiByZWxhdGVkIGNoYW5nZXMsIEknbGwgc2VuZCB0aGUgc3BlY2lmaWNhdGlv
bg0KY2hhbmdlIGZvciByZXZpZXcgZmlyc3RseS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBDYXRoeSBBdmVyeSBbbWFpbHRvOmNhdmVyeUByZWRoYXQuY29tXQ0KPiBT
ZW50OiBNb25kYXksIEZlYnJ1YXJ5IDUsIDIwMTggMTA6MjAgUE0NCj4gVG86IExpdSwgQ2hhbmdw
ZW5nIDxjaGFuZ3BlbmcubGl1QGludGVsLmNvbT4NCj4gQ2M6IFN0ZWZhbiBIYWpub2N6aSA8c3Rl
ZmFuaGFAcmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkNCj4gPHBib256aW5pQHJlZGhhdC5jb20+
OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogdmlydGlvLWJsayBkaXNjYXJkIHN1
cHBvcnQNCj4gDQo+IEhpLA0KPiANCj4gSSBhbSBsb29raW5nIGF0IGV4dGVuZGluZyB2aXJ0aW8t
YmxrIGJ5IGFkZGluZyBzdXBwb3J0IGZvciB0aGUgZGlzY2FyZA0KPiByZXF1ZXN0Lg0KPiANCj4g
aHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTgtMDEv
bXNnMDM4ODkuaHRtbA0KPiANCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHlvdSBoYXZlIGFs
cmVhZHkgYmVndW4gdGhpcyB3b3JrIHdpdGggW1BBVENIXQ0KPiB2aXJ0aW8tYmxrOiBhZGQgRElT
Q0FSRCBzdXBwb3J0IHRvIHZpcnRpby1ibGsgZHJpdmUNCj4gDQo+IGh0dHBzOi8vbGlzdHMuZ251
Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE3LTAzL21zZzA1MTQ2Lmh0bWwNCj4gDQo+
IEFyZSB5b3UgaW50ZW5kaW5nIHRvIGZpbmlzaCB0aGUgaW1wbGVtZW50YXRpb24/IEkgZG9uJ3Qg
d2FudCB0byBzdGFydCBhDQo+IGRldmVsb3BtZW50IGVmZm9ydCBpZiB5b3UgYXJlIGFscmVhZHkg
d29ya2luZyBvbiBpdC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IENhdGh5IEF2ZXJ5DQo+IA0KPiAN
Cj4gDQo+IA0KPiANCg0K
