Received: from eggs.gnu.org ([2001:4830:134:3::10]:35292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dzeMf-00061t-IO
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 03:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dzeMc-0008T5-GC
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 03:45:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:11565)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dzeMc-0008SB-7T
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 03:45:06 -0400
From: "Valluri, Amarnath" <amarnath.valluri@intel.com>
Date: Wed, 4 Oct 2017 07:45:01 +0000
Message-ID: <1507103131.2282.5.camel@intel.com>
References: <1506683421-27004-1-git-send-email-amarnath.valluri@intel.com>
	<1506683421-27004-9-git-send-email-amarnath.valluri@intel.com>
	<306334f5-358e-a7df-b663-b1b77e78c934@linux.vnet.ibm.com>
In-Reply-To: <306334f5-358e-a7df-b663-b1b77e78c934@linux.vnet.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A3115B23C647444A99D2D7705384D5A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 8/9] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>

T24gVHVlLCAyMDE3LTEwLTAzIGF0IDE3OjIxIC0wNDAwLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOg0K
PiBPbiAwOS8yOS8yMDE3IDA3OjEwIEFNLCBBbWFybmF0aCBWYWxsdXJpIHdyb3RlOg0KPiA+IA0K
PiA+IFRoaXMgY2hhbmdlIGludHJvZHVjZXMgYSBuZXcgVFBNIGJhY2tlbmQgZHJpdmVyIHRoYXQg
Y2FuDQo+ID4gY29tbXVuaWNhdGUgd2l0aA0KPiA+IHN3dHBtKHNvZnR3YXJlIFRQTSBlbXVsYXRv
cikgdXNpbmcgdW5peCBkb21haW4gc29ja2V0IGludGVyZmFjZS4NCj4gPiBRRU1VIHRhbGtzIHRv
DQo+ID4gVFBNIGVtdWxhdG9yIHVzaW5nIFFFTVUncyBzb2NrZXQtYmFzZWQgY2hhcmRldiBiYWNr
ZW5kIGRldmljZS4NCj4gPiANCj4gPiBTd3RwbSB1c2VzIHR3byBVbml4IHNvY2tldHMgZm9yIGNv
bW11bmljYXRpb25zLCBvbmUgZm9yIHBsYWluIFRQTQ0KPiA+IGNvbW1hbmRzIGFuZA0KPiA+IHJl
c3BvbnNlcywgYW5kIG9uZSBmb3Igb3V0LW9mLWJhbmQgY29udHJvbCBtZXNzYWdlcy4gUUVNVSBw
YXNzZXMNCj4gPiBkYXRhIHNvY2tldCB0bw0KPiA+IGJlIHVzZWQgb3ZlciB0aGUgY29udHJvbCBj
aGFubmVsLg0KPiA+IA0KPiA+IFRoZSBzd3RwbSBhbmQgYXNzb2NpYXRlZCB0b29scyBjYW4gYmUg
Zm91bmQgaGVyZToNCj4gPiDCoMKgwqDCoMKgaHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmJlcmdl
ci9zd3RwbQ0KPiA+IA0KPiA+IFRoZSBzd3RwbSdzIGNvbnRyb2wgY2hhbm5lbCBwcm90b2NvbCBz
cGVjaWZpY2F0aW9uIGNhbiBiZSBmb3VuZA0KPiA+IGhlcmU6DQo+ID4gwqDCoMKgwqDCoGh0dHBz
Oi8vZ2l0aHViLmNvbS9zdGVmYW5iZXJnZXIvc3d0cG0vd2lraS9Db250cm9sLUNoYW5uZWwtU3Bl
DQo+ID4gY2lmaWNhdGlvbg0KPiA+IA0KPiA+IFVzYWdlOg0KPiA+IMKgwqDCoMKgwqAjIHNldHVw
IFRQTSBzdGF0ZSBkaXJlY3RvcnkNCj4gPiDCoMKgwqDCoMKgbWtkaXIgL3RtcC9teXRwbQ0KPiA+
IMKgwqDCoMKgwqBjaG93biAtUiB0c3M6cm9vdCAvdG1wL215dHBtDQo+ID4gwqDCoMKgwqDCoC91
c3IvYmluL3N3dHBtX3NldHVwIC0tdHBtLXN0YXRlIC90bXAvbXl0cG0gLS1jcmVhdGVlaw0KPiBU
byBydW4gdGhpcywgb25lIG5lZWRzIHRoZSBsYXRlc3QgdmVyc2lvbiBvZiBzd3RwbSB0aGF0IHN1
cHBvcnRzIHRoZcKgDQo+IGZpbGUgZGVzY3JpcHRvciBwYXNzaW5nLg0KPiBUaGVuIG9uZSBjYW4g
c3RhcnQgdGhlIHN3dHBtIGxpa2UgdGhpczoNCj4gDQo+IHN3dHBtIHNvY2tldCAtLXRwbXN0YXRl
IGRpcj0vdG1wL215dHBtIC0tY3RybMKgDQo+IHR5cGU9dW5peGlvLHBhdGg9L3RtcC9zd3RwbS1z
b2NrIC0tbG9nIGxldmVsPTIwDQo+IA0KPiBJIHRlc3RlZCB0aGUgU2VhQklPUyBtZW51IGl0ZW1z
IHNvIGZhciBhbmQgdGhhdCB3b3JrcyBmaW5lLCBhbHNvIGZvcsKgDQo+IFRQTTIgKC0tdHBtMiku
DQoNCkdyZWF0ZSwgVGhhbmtzIGZvciB5b3UgZmVlZGJhY2suDQoNCi0gQW1hcm5hdGg=
