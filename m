Received: from eggs.gnu.org ([2001:4830:134:3::10]:34792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epXjL-00020E-4y
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 06:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epXjG-0005IU-03
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 06:11:03 -0500
Received: from smtp65.cstnet.cn ([159.226.251.65]:57353 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epXjF-0004xY-BW
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 06:10:57 -0500
Date: Sat, 24 Feb 2018 19:10:47 +0800 (GMT+08:00)
From: =?UTF-8?B?6IuP6Iiq?= <suhang16@mails.ucas.ac.cn>
In-Reply-To: <12b54434-c992-d882-9ce7-0f658d067a7c@redhat.com>
References: <1519372288-20791-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<c5009934-13c3-6e86-2618-9935837d3b8d@redhat.com>
	<12b54434-c992-d882-9ce7-0f658d067a7c@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1e4f4971.13782.161c782180c.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] util/uri.c: add brackets to `if`
 statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, stefanha@redhat.com, qemu-devel@nongnu.org

VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIDopCkkgd2lsbCBwYXkgbW9yZSBhdHRlbnRpb24gdG8g
d2hhdCB5b3UgcG9pbnQgb3V0LgoKIkVyaWMgQmxha2UiIDxlYmxha2VAcmVkaGF0LmNvbT53cm90
ZToKPiBPbiAwMi8yMy8yMDE4IDAzOjM0IEFNLCBUaG9tYXMgSHV0aCB3cm90ZToNCj4gPiBPbiAy
My4wMi4yMDE4IDA4OjUxLCBTdSBIYW5nIHdyb3RlOg0KPiA+PiBBZGQgYnJhY2tldHMgdGhhdCB3
cmFwIGBpZmAsIGBlbHNlYCwgYHdoaWxlYCB0aGF0IGhvbGQgc2luZ2xlDQo+ID4+IHN0YXRlbWVu
dHMuDQo+ID4+DQo+ID4+IEluIG9yZGVyIHRvIGRvIHRoaXMsIEkgd3JpdGUgYSBzaW1wbGUgcHl0
aG9uIHJlZ2V4IHNjcmlwdC4NCj4gDQo+IFdpdGhvdXQgZG9jdW1lbnRpbmcgdGhlIHNjcmlwdCwg
bm8gb25lIGVsc2UgY2FuIHJlcHJvZHVjZSB0aGlzOyBidXQgaXQncyANCj4gbm8gZGlmZmVyZW50
IHRoYW4gaWYgdGhleSBoYWQgbWFudWFsbHkgbWFkZSBjaGFuZ2VzIGluc3RlYWQgb2YgdHJ5aW5n
IHRvIA0KPiBzY3JpcHQgaXQsIHNvIEknbSBub3Qgc3VyZSB0aGlzIHNlbnRlbmNlIGFkZHMgbXVj
aCBpbiBpdHMgY3VycmVudCBmb3JtLg0KPiANCj4gPj4NCj4gPj4gU2luY2UgdGhlbiwgYWxsIGNv
bXBsYWludHMgcmlzZWQgYnkgY2hlY2twYXRjaC5wbCBoYXMgYmVlbiBzdXBwcmVzc2VkLg0KPiAN
Cj4gcy9yaXNlZC9yYWlzZWQvDQo+IHMvU2luY2UgdGhlbiwvV2l0aCB0aGF0Lw0KPiBzL2hhcy9o
YXZlLw0KPiANCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogU3UgSGFuZyA8c3VoYW5nMTZAbWFp
bHMudWNhcy5hYy5jbj4NCj4gPj4gLS0tDQo+ID4+ICAgdXRpbC91cmkuYyB8IDQ2MiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDI5MSBpbnNlcnRpb25zKCspLCAxNzEgZGVsZXRpb25zKC0p
DQo+ID4+DQo+IA0KPiA+PiAgICAgICBjdXIgPSAqc3RyOw0KPiA+PiAtICAgIGlmICghSVNBX0FM
UEhBKGN1cikpDQo+ID4+ICsgICAgaWYgKCFJU0FfQUxQSEEoY3VyKSkgew0KPiA+PiAgICAgICAg
ICAgcmV0dXJuIDI7DQo+ID4+ICsgICAgfQ0KPiA+PiAgICAgICBjdXIrKzsNCj4gPj4gLSAgICB3
aGlsZSAoSVNBX0FMUEhBKGN1cikgfHwgSVNBX0RJR0lUKGN1cikgfHwNCj4gPj4gLSAgICAgICAg
ICAgKCpjdXIgPT0gJysnKSB8fCAoKmN1ciA9PSAnLScpIHx8ICgqY3VyID09ICcuJykpDQo+ID4+
ICsgICAgd2hpbGUgKElTQV9BTFBIQShjdXIpIHx8IElTQV9ESUdJVChjdXIpIHx8ICgqY3VyID09
ICcrJykgfHwgKCpjdXIgPT0gJy0nKSB8fA0KPiA+PiArICAgICAgICAgICAoKmN1ciA9PSAnLicp
KQ0KPiA+PiAgICAgICAgICAgY3VyKys7DQo+ID4gDQo+ID4gWW91J3ZlIGNoYW5nZWQgdGhlIHdo
aWxlIHN0YXRlbWVudCwgYnV0IGNoZWNrcGF0Y2gucGwgYXBwYXJlbnRseSBkb2VzIG5vdA0KPiA+
IGNvbXBsYWluIGFib3V0IG1pc3NpbmcgY3VybHkgYnJhY2VzIGhlcmUgLi4uIHRoYXQncyBzdHJh
bmdlLCBJIHRob3VnaHQgd2UnZA0KPiA+IGFsc28gd2FudGVkIHRvIGVuZm9yY2UgY3VybHkgYnJh
Y2VzIGZvciB3aGlsZSBsb29wcy4NCj4gDQo+IE1heWJlIGJlY2F1c2UgaXQgZ2V0cyBsb3N0IHNp
bmNlIHRoZSBjb25kaXRpb24gZXhwYW5kZWQgb3ZlciBtb3JlIHRoYW4gDQo+IG9uZSBsaW5lPyAg
QnV0IHllcywgbm93IHRoYXQgd2UndmUgbm90aWNlZCBpdCBtYW51YWxseSwgaXQgc2hvdWxkIGJl
IA0KPiBmaXhlZC4gIFdoaWxlIGF0IGl0LCB5b3UgY2FuIGF2b2lkIHRoZSByZWR1bmRhbnQgKCk6
DQo+IA0KPiB3aGlsZSAoSVNBX0FMUEhBKGN1cikgfHwgSVNBX0RJR0lUKGN1cikgfHwgKmN1ciA9
PSAnKycgfHwgKmN1ciA9PSAnLScgfHwNCj4gICAgICAgICAqY3VyID09ICcuJykgew0KPiANCj4g
DQo+ID4+IC0gICAgICAgIHdoaWxlICgoKnRtcCsrID0gKnNlZ3ArKykgIT0gMCkNCj4gPj4gKyAg
ICAgICAgd2hpbGUgKCgqdG1wKysgPSAqc2VncCsrKSAhPSAwKSB7DQo+ID4+ICAgICAgICAgICAg
ICAgOw0KPiA+PiArICAgICAgICB9DQo+ID4gDQo+ID4gQSBiaWtlc2hlZC1wYWludGluZy1mcmlk
YXkgcXVlc3Rpb24gZm9yIGV2ZXJ5Ym9keSBvbiBxZW11LWRldmVsOg0KPiA+IFNob3VsZCB0aGVy
ZSBiZSBhIHNpbmdsZSBzZW1pY29sb24gaW5zaWRlIGN1cmx5IGJyYWNlcyBpbiB0aGlzIGNhc2Us
IG9yIG5vdD8NCj4gPiANCj4gDQo+IENoZWNrcGF0Y2ggZG9lc24ndCBjb21wbGFpbiwgYnV0IGxv
bmUgJzsnIHN0YXRlbWVudHMgYXJlIHJhcmUuICBJJ2Qgb21pdCANCj4gaXQsIGFuZCB1c2UganVz
dDoNCj4gDQo+IHdoaWxlIChjb25kKSB7DQo+IH0NCj4gDQo+IA0KPiAtLSANCj4gRXJpYyBCbGFr
ZSwgUHJpbmNpcGFsIFNvZnR3YXJlIEVuZ2luZWVyDQo+IFJlZCBIYXQsIEluYy4gICAgICAgICAg
ICsxLTkxOS0zMDEtMzI2Ng0KPiBWaXJ0dWFsaXphdGlvbjogIHFlbXUub3JnIHwgbGlidmlydC5v
cmcNCg==
