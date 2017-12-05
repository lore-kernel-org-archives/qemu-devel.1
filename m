Received: from eggs.gnu.org ([2001:4830:134:3::10]:53808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <avi.cohen@huawei.com>) id 1eM8vJ-0001BW-5z
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <avi.cohen@huawei.com>) id 1eM8vG-0004S2-24
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:49:53 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:33007 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <avi.cohen@huawei.com>)
	id 1eM8vF-0004Rc-PT
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:49:49 -0500
From: "Avi Cohen (A)" <avi.cohen@huawei.com>
Date: Tue, 5 Dec 2017 08:49:40 +0000
Message-ID: <B84047ECBD981D4B93EAE5A6245AA3610159300B@FRAEML521-MBX.china.huawei.com>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<3be9aa23-ca3b-2b16-ecf1-83388365c6b0@redhat.com>
	<5A264780.2030808@intel.com>
	<668fc7b0-4a3a-7a3b-e939-7a0d80c03166@redhat.com>
In-Reply-To: <668fc7b0-4a3a-7a3b-e939-7a0d80c03166@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "zhiyong.yang@intel.com" <zhiyong.yang@intel.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyBbbWFp
bHRvOmphc293YW5nQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIDA1IERlY2VtYmVyLCAy
MDE3IDk6MTkgQU0NCj4gVG86IFdlaSBXYW5nOyB2aXJ0aW8tZGV2QGxpc3RzLm9hc2lzLW9wZW4u
b3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IG1zdEByZWRoYXQuY29tOyBtYXJjYW5kcmUu
bHVyZWF1QHJlZGhhdC5jb207IHN0ZWZhbmhhQHJlZGhhdC5jb207DQo+IHBib256aW5pQHJlZGhh
dC5jb20NCj4gQ2M6IGphbi5raXN6a2FAc2llbWVucy5jb207IEF2aSBDb2hlbiAoQSk7IHpoaXlv
bmcueWFuZ0BpbnRlbC5jb20NCj4gU3ViamVjdDogUmU6IFt2aXJ0aW8tZGV2XSBbUEFUQ0ggdjMg
MC83XSBWaG9zdC1wY2kgZm9yIGludGVyLVZNIGNvbW11bmljYXRpb24NCj4gDQo+IA0KPiANCj4g
T24gMjAxN+W5tDEy5pyIMDXml6UgMTU6MTUsIFdlaSBXYW5nIHdyb3RlOg0KPiA+IE9uIDEyLzA1
LzIwMTcgMDM6MDEgUE0sIEphc29uIFdhbmcgd3JvdGU6DQo+ID4+DQo+ID4+DQo+ID4+IE9uIDIw
MTflubQxMuaciDA15pelIDExOjMzLCBXZWkgV2FuZyB3cm90ZToNCj4gPj4+IFZob3N0LXBjaSBp
cyBhIHBvaW50LXRvLXBvaW50IGJhc2VkIGludGVyLVZNIGNvbW11bmljYXRpb24gc29sdXRpb24u
DQo+ID4+PiBUaGlzDQo+ID4+PiBwYXRjaCBzZXJpZXMgaW1wbGVtZW50cyB0aGUgdmhvc3QtcGNp
LW5ldCBkZXZpY2Ugc2V0dXAgYW5kDQo+ID4+PiBlbXVsYXRpb24uIFRoZSBkZXZpY2UgaXMgaW1w
bGVtZW50ZWQgYXMgYSB2aXJ0aW8gZGV2aWNlLCBhbmQgaXQgaXMNCj4gPj4+IHNldCB1cCB2aWEg
dGhlIHZob3N0LXVzZXIgcHJvdG9jb2wgdG8gZ2V0IHRoZSBuZWVzc2FyeSBpbmZvIChlLmcgdGhl
DQo+ID4+PiBtZW1vcnkgaW5mbyBvZiB0aGUgcmVtb3RlIFZNLCB2cmluZyBpbmZvKS4NCj4gPj4+
DQo+ID4+PiBDdXJyZW50bHksIG9ubHkgdGhlIGZ1bmRhbWVudGFsIGZ1bmN0aW9ucyBhcmUgaW1w
bGVtZW50ZWQuIE1vcmUNCj4gPj4+IGZlYXR1cmVzLCBzdWNoIGFzIE1RIGFuZCBsaXZlIG1pZ3Jh
dGlvbiwgd2lsbCBiZSB1cGRhdGVkIGluIHRoZQ0KPiA+Pj4gZnV0dXJlLg0KPiA+Pj4NCj4gPj4+
IFRoZSBEUERLIFBNRCBvZiB2aG9zdC1wY2kgaGFzIGJlZW4gcG9zdGVkIHRvIHRoZSBkcGRrIG1h
aWxpbmdsaXN0IGhlcmU6DQo+ID4+PiBodHRwOi8vZHBkay5vcmcvbWwvYXJjaGl2ZXMvZGV2LzIw
MTctTm92ZW1iZXIvMDgyNjE1Lmh0bWwNCj4gPj4+DQo+ID4+PiB2Mi0+djMgY2hhbmdlczoNCj4g
Pj4+IDEpIHN0YXRpYyBkZXZpY2UgY3JlYXRpb246IGluc3RlYWQgb2YgY3JlYXRpbmcgYW5kIGhv
dC1wbHVnZ2luZyB0aGUNCj4gPj4+IMKgwqDCoCBkZXZpY2Ugd2hlbiByZWNlaXZpbmcgYSB2aG9z
dC11c2VyIG1zZywgdGhlIGRldmljZSBpcyBub3QNCj4gPj4+IGNyZWF0ZWQNCj4gPj4+IMKgwqDC
oCB2aWEgdGhlIHFlbXUgYm9vdGluZyBjb21tYW5kIGxpbmUuDQo+ID4+PiAyKSByZW1vdmUgdnFz
OiBycSBhbmQgY3RybHEgYXJlIHJlbW92ZWQgaW4gdGhpcyB2ZXJzaW9uLg0KPiA+Pj4gwqDCoMKg
wqAgLSByZWNlaXZlIHZxOiB0aGUgcmVjZWl2ZSB2cSBpcyBub3QgbmVlZGVkIGFueW1vcmUuIFRo
ZSBQTUQNCj4gPj4+IGRpcmVjdGx5DQo+ID4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2hhcmVzIHRoZSByZW1vdGUgdHhxIGFuZCByeHEgLSBncmFiIGZyb20gcmVtb3Rl
DQo+ID4+PiB0eHEgdG8NCj4gPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZWNlaXZlIHBhY2tldHMsIGFuZCBwdXQgdG8gcnhxIHRvIHNlbmQgcGFja2V0cy4NCj4gPj4+
IMKgwqDCoMKgIC0gY3RybHE6IHRoZSBjdHJscSBpcyByZXBsYWNlZCBieSB0aGUgZmlyc3QgNEtC
IG1ldGFkYXRhIGFyZWENCj4gPj4+IG9mIHRoZQ0KPiA+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZGV2aWNlIEJhci0yLg0KPiA+Pj4gMykgc2ltcGxlciBpbXBsZW1lbnRhdGlvbjogdGhl
IGVudGlyZSBpbXBsZW1lbnRhdGlvbiBoYXMgYmVlbg0KPiA+Pj4gdGFpbG9yZWQNCj4gPj4+IMKg
wqDCoCBmcm9tIH4xODAwIExPQyB0byB+ODUwIExPQy4NCj4gPj4NCj4gPj4gSGk6DQo+ID4+DQo+
ID4+IEFueSBwZXJmb3JtYW5jZSBudW1iZXJzIHlvdSBjYW4gc2hhcmU/DQo+ID4+DQo+ID4NCj4g
PiBIaSBKYXNvbiwNCj4gPg0KPiA+IFBlcmZvcm1hbmNlIHRlc3RpbmcgYW5kIHR1bmluZyBvbiB0
aGUgZGF0YSBwbGFuZSBpcyBpbiBwcm9ncmVzcyAoYnR3LA0KPiA+IHRoYXQgd291bGRuJ3QgYWZm
ZWN0IHRoZSBkZXZpY2UgcGFydCBwYXRjaGVzKS4NCj4gPiBJZiBwb3NzaWJsZSwgY291bGQgd2Ug
c3RhcnQgdGhlIGRldmljZSBwYXJ0IHBhdGNoIHJldmlldyBpbiB0aGUgbWVhbnRpbWU/DQo+ID4N
Cj4gPiBCZXN0LA0KPiA+IFdlaQ0KPiA+DQo+IA0KPiBIaSBXZWk6DQo+IA0KPiBXaWxsIGRvLCBi
dXQgYmFzaWNhbGx5LCB0aGUgY292ZXIgbGFja3Mgb2YgdGhlIG1vdGl2YXRpb24gZm9yIHZob3N0
LXBjaSBhbmQgSSB3YW50DQo+IHRvIHNlZSBzb21lIG51bWJlcnMgZmlyc3Qgc2luY2UgSSBzdXNw
ZWN0IGl0IGNhbiBvdmVyLXBlcmZvcm0gZXhpc3QgZGF0YS1wYXRoLg0KPiANCj4gVGhhbmtzDQpb
QXZpIENvaGVuIChBKV0gDQpIaSBXZWkNCkkgY2FuIHRyeSB0ZXN0aW5nIHRvIGdldCAqKm51bWJl
cnMqKiAgLSBJIGNhbiBkbyBpdCBub3cgLCBuZWVkIGEgbGl0dGxlIGhlbHAgZnJvbSB5b3UNCkkn
dmUgc3RhcnRlZCB3aXRoIGRvd25sb2FkaW5nL2J1aWxkaW5nIGFuZCBpbnN0YWxsaW5nICBvZiA+
IGRyaXZlcjogaHR0cHM6Ly9naXRodWIuY29tL3dlaS13LXdhbmcvdmhvc3QtcGNpLWRyaXZlciAg
dG8gdGhlIGtlcm5lbCBndWVzdCwNCiAqKndpdGhvdXQqKiAgZG93bmxvYWRpbmcgdGhlIDJuZCBw
YXRjaCA+IGRldmljZTogaHR0cHM6Ly9naXRodWIuY29tL3dlaS13LXdhbmcvdmhvc3QtcGNpLWRl
dmljZQ0KQnV0IG15IGd1ZXN0IGtlcm5lbCB3YXMgY29ycnVwdGVkIGFmdGVyIHJlYm9vdCAoa2Vy
bmVsIHBhbmljL291dCBvZiBtZW0gLi4pIC0gIGNhbiB5b3UgdGVsbCBtZSB0aGUgc3RlcHMgdG8g
YXBwbHkgdGhlc2UgcGF0Y2hlcyA/DQpCZXN0IFJlZ2FyZHMNCkF2aQ0K
