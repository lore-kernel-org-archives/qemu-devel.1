Received: from eggs.gnu.org ([2001:4830:134:3::10]:43438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.shi@intel.com>) id 1evFZn-0000cP-JR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 01:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.shi@intel.com>) id 1evFZj-00069x-Gu
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 01:00:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:17356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.shi@intel.com>)
	id 1evFZj-000696-40
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 01:00:43 -0400
From: "Shi, Steven" <steven.shi@intel.com>
Date: Mon, 12 Mar 2018 05:00:33 +0000
Message-ID: <06C8AB66E78EE34A949939824ABE2B313B6673B3@shsmsx102.ccr.corp.intel.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<06C8AB66E78EE34A949939824ABE2B313B651F39@shsmsx102.ccr.corp.intel.com>
	<CAJ+F1CKuHzO-F3XbjqQyLL49JipsR+Sk8zFy1ZuMssUz_71qvA@mail.gmail.com>
	<06C8AB66E78EE34A949939824ABE2B313B6613A0@shsmsx102.ccr.corp.intel.com>
	<c5b7bc1d-c425-49d9-789c-044372588539@linux.vnet.ibm.com>
In-Reply-To: <c5b7bc1d-c425-49d9-789c-044372588539@linux.vnet.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 0/8] RFC: ovmf: preliminary TPM2
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, "lersek@redhat.com" <lersek@redhat.com>, "pjones@redhat.com" <pjones@redhat.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>

SXQgd29ya3MgaW4gbXkgc2lkZSBhZnRlciBzcGVjaWZ5IHRoZSBmdWxsIHBhdGggdG8gc3d0cG0g
dHBtZW11LnNvY2sgaW4gcWVtdSBjb21tYW5kIG9wdGlvbnMuIFRoYW5rcyENCg0KDQpTdGV2ZW4g
U2hpDQpJbnRlbFxTU0dcU1RPXFVFRkkgRmlybXdhcmUNCg0KVGVsOiArODYgMDIxLTYxMTY2NTIy
DQppTmV0OiA4MjEtNjUyMg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFN0ZWZhbiBCZXJnZXIgW21haWx0bzpzdGVmYW5iQGxpbnV4LnZuZXQuaWJtLmNvbV0NCj4gU2Vu
dDogRnJpZGF5LCBNYXJjaCA5LCAyMDE4IDk6NTQgUE0NCj4gVG86IFNoaSwgU3RldmVuIDxzdGV2
ZW4uc2hpQGludGVsLmNvbT47IE1hcmMtQW5kcsOpIEx1cmVhdQ0KPiA8bWFyY2FuZHJlLmx1cmVh
dUBnbWFpbC5jb20+DQo+IENjOiBlZGsyLWRldmVsQGxpc3RzLjAxLm9yZzsgbGVyc2VrQHJlZGhh
dC5jb207IHBqb25lc0ByZWRoYXQuY29tOyBZYW8sDQo+IEppZXdlbiA8amlld2VuLnlhb0BpbnRl
bC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGphdmllcm1AcmVkaGF0LmNvbQ0KPiBT
dWJqZWN0OiBSZTogW2VkazJdIFtQQVRDSCB2MiAwLzhdIFJGQzogb3ZtZjogcHJlbGltaW5hcnkg
VFBNMiBzdXBwb3J0DQo+IA0KPiBPbiAwMy8wOC8yMDE4IDEwOjAzIFBNLCBTaGksIFN0ZXZlbiB3
cm90ZToNCj4gPiBIaSBNYXJjYW5kcmUsDQo+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1hbmQgc3Rl
cHMgYW5kIEkgdHJpZWQgdGhlbSwgYnV0IG15IHFlbXUgZmFpbGVkIHRvDQo+IGNvbm5lY3QgdGhl
IHNvY2tldCB0cG1lbXUuc29jay4gV2hlbiBJIGFkZGVkIHRoZSBjb250cm9sIGNoYW5uZWwgdG8g
dGhlDQo+IFRQTSwgdGhlIHN3dHBtIHNvY2tldCBjb21tYW5kIHN0dWNrIHRoZXJlIGFuZCBuZXZl
ciBleGl0LiBOb3Qgc3VyZQ0KPiB3aGV0aGVyIGl0IHdhcyBzdWNjZXNzZnVsLg0KPiA+IEJlbG93
IGFyZSB0aGUgY29tbWFuZCBzdGVwcyBydW5uaW5nIG91dHB1dCBpbiBteSBzaWRlDQo+ID4NCj4g
Pj4gVGhlbiB5b3UgY2FuIHJ1bjoNCj4gPj4gbWtkaXIgdHBtc3RhdGVkaXINCj4gPj4gc3d0cG1f
c2V0dXAuc2ggLS10cG0yIC0tdHBtLXN0YXRlIHRwbXN0YXRlZGlyDQo+ID4gJCBzd3RwbV9zZXR1
cC5zaCAtLXRwbTIgLS10cG0tc3RhdGUgdHBtc3RhdGVkaXINCj4gPiBTdGFydGluZyB2VFBNIG1h
bnVmYWN0dXJpbmcgYXMganNoaTE5OmpzaGkxOSBAIDIwMTjlubQwM+aciDA55pelIOaYn+acnw0K
PiDkupQgMTDml7YyOOWIhjM556eSDQo+ID4gVFBNIGlzIGxpc3RlbmluZyBvbiBUQ1AgcG9ydCA0
NzM2NC4NCj4gPiBTdWNjZXNzZnVsbHkgYXV0aG9yZWQgVFBNIHN0YXRlLg0KPiA+IEVuZGluZyB2
VFBNIG1hbnVmYWN0dXJpbmcgQCAyMDE45bm0MDPmnIgwOeaXpSDmmJ/mnJ/kupQgMTDml7YyOOWI
hjM5DQo+IOenkg0KPiA+DQo+ID4+IFJ1biB0aGUgZW11bGF0b3I6DQo+ID4+IHN3dHBtIHNvY2tl
dCAtLXRwbXN0YXRlIGRpcj10cG1zdGF0ZWRpciAtLWN0cmwNCj4gdHlwZT11bml4aW8scGF0aD10
cG1lbXUuc29jayAgLS10cG0yDQo+ID4gJCBzd3RwbSBzb2NrZXQgLS10cG1zdGF0ZSBkaXI9dHBt
c3RhdGVkaXIgLS1jdHJsDQo+IHR5cGU9dW5peGlvLHBhdGg9dHBtZW11LnNvY2sgLS10cG0yDQo+
ID4gKHRoZSBzd3RwbSBzb2NrZXQgY29tbWFuZCBzdHVjayB0aGVyZSBhbmQgbmV2ZXIgZXhpdCkN
Cj4gPg0KPiA+PiBSdW4gcWVtdSAoZnJvbSBnaXQpIHdpdGggb3ZtZiAod2l0aCB0aGlzIHNlcmll
cyk6DQo+ID4+IHFlbXUgLi4uIC1jaGFyZGV2IHNvY2tldCxpZD1jaHJ0cG0scGF0aD10cG1lbXUu
c29jayAtdHBtZGV2DQo+ID4+IGVtdWxhdG9yLGlkPXRwbTAsY2hhcmRldj1jaHJ0cG0gIC1kZXZp
Y2UgdHBtLWNyYix0cG1kZXY9dHBtMA0KPiA+PiAtZHJpdmUgaWY9cGZsYXNoLGZvcm1hdD1yYXcs
ZmlsZT1PVk1GX0NPREUuZmQscmVhZG9ubHkgLWRyaXZlDQo+ID4+IGlmPXBmbGFzaCxmb3JtYXQ9
cmF3LGZpbGU9T1ZNRl9WQVJTLmZkIC4uDQo+ID4gJCBxZW11LXN5c3RlbS14ODZfNjQgIC1zZXJp
YWwgZmlsZTpzZXJpYWwubG9nIC1tIDUxMjAgLWhkYSBmYXQ6LiAtbW9uaXRvcg0KPiBzdGRpbyAt
LWVuYWJsZS1rdm0gLXNtcCA0IC1iaW9zIC4uL092bWYzMjY0L05PT1BUX0dDQzUvRlYvT1ZNRi5m
ZCAtDQo+IGNoYXJkZXYgc29ja2V0LGlkPWNocnRwbSxwYXRoPXRwbWVtdS5zb2NrIC10cG1kZXYN
Cj4gZW11bGF0b3IsaWQ9dHBtMCxjaGFyZGV2PWNocnRwbSAgLWRldmljZSB0cG0tY3JiLHRwbWRl
dj10cG0wDQo+ID4gcWVtdS1zeXN0ZW0teDg2XzY0OiAtY2hhcmRldiBzb2NrZXQsaWQ9Y2hydHBt
LHBhdGg9dHBtZW11LnNvY2s6DQo+IEZhaWxlZCB0byBjb25uZWN0IHNvY2tldCB0cG1lbXUuc29j
azogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KPiANCj4gVHJ5IGdpdmluZyBpdCBib3RoLCBz
d3RwbSBhbmQgcWVtdSwgdGhlIGZ1bGwgcGF0aCB0byB0aGUgc29ja2V0Lg0KPiANCj4gDQo+ID4N
Cj4gPiBJIHVzZSB0aGUgbGF0ZXN0IHZlcnNpb24gcWVtdSBhcyBiZWxvdzoNCj4gPiAkIHFlbXUt
c3lzdGVtLXg4Nl82NCAtLXZlcnNpb24NCj4gPiBRRU1VIGVtdWxhdG9yIHZlcnNpb24gMi4xMS41
MCAodjIuMTAuMC00MTg0LWc5MzBiMDExMzhiLWRpcnR5KQ0KPiA+IENvcHlyaWdodCAoYykgMjAw
My0yMDE3IEZhYnJpY2UgQmVsbGFyZCBhbmQgdGhlIFFFTVUgUHJvamVjdCBkZXZlbG9wZXJzDQo+
ID4NCj4gPiBUaGFua3MNCj4gPiBTdGV2ZW4gU2hpDQo+ID4NCg0K
