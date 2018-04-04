Received: from eggs.gnu.org ([2001:4830:134:3::10]:52500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3kst-0000tx-Vf
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3ksp-0001Xg-U5
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:03:39 -0400
Received: from smtp66.cstnet.cn ([159.226.251.66]:40491 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3ksp-0001WX-7t
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:03:35 -0400
Date: Thu, 5 Apr 2018 00:03:30 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <799e1ff8-78de-6bac-a5f5-65d747adfc23@redhat.com>
References: <1522855165-9959-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<799e1ff8-78de-6bac-a5f5-65d747adfc23@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <54b5df33.3008.162916619a6.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v2 RFC 0/2] Implement Hex file loader and
 add test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org

VGhhbmtzIGZvciB5b3VyIHJlcGx5ISBPd25pbmcgdG8gY3VsdHVyYWwgZGlmZmVyZW5jZe+8jCBJ
IHVzZWQgdG8gcmVnYXJkIOKAnFJGQ+KAnSBhcyBhIHdheSBvZiBzaG93IG1vZGVzdC4uLgpJIHdp
bGwgYXBwbHkgeW91ciBzdWdnZXN0aW9uIGluIHYzLgoKQmVzdCwKU3UgSGFuZwoKIkVyaWMgQmxh
a2UiIDxlYmxha2VAcmVkaGF0LmNvbT53cm90ZToKPiBPbiAwNC8wNC8yMDE4IDEwOjE5IEFNLCBT
dSBIYW5nIHdyb3RlOg0KPiA+IFRoZXNlIHNlcmllcyBvZiBwYXRjaHMgaW1wbGVtZW50IEludGVs
IEhleGFkZWNpbWFsIEZpbGUgbG9hZGVyIGFuZA0KPiA+IGFkZCBRVGVzdCB0ZXN0Y2FzZSB0byB2
ZXJpZnkgdGhlIGNvcnJlY3RuZXNzIG9mIExvYWRlci4NCj4gPiANCj4gPiB2MTogQmFzaWMgdmVy
c2lvbi4NCj4gPiB2MjogUmVwbGFjZSBgZG97fXdoaWxlKGNvbmQpO2AgYmxvY2sgd2l0aCBgZm9y
KDs7KWAgYmxvY2sgdG8NCj4gPiBzdXBwcmVzcyBjb2RlIHN0eWxlIGNvbXBsYWluLg0KPiANCj4g
QmV0dGVyIHRoYW4gcmV3cml0aW5nIGNvZGUgdG8gd29yayBhcm91bmQgYSBmYWxzZSBwb3NpdGl2
ZSBpcyB0byBmaXggdGhlDQo+IGZhbHNlIHBvc2l0aXZlIGluIHRoZSBmaXJzdCBwbGFjZS4gIEFu
ZCBJIHNlZSB5b3UgaGF2ZSBhIHBhdGNoIHByb3Bvc2VkDQo+IGZvciB0aGF0LCBidXQgaXQgd2Fz
IHN0aWxsIG1hcmtlZCBSRkM7IHVuZm9ydHVuYXRlbHksIGR1cmluZyBmcmVlemUsDQo+IHBhdGNo
ZXMgdGhhdCBhcmUgbWFya2VkIFJGQyB0ZW5kIHRvIGJlIGRlZmVycmVkIGluIGZhdm9yIG9mIHBh
dGNoZXMNCj4gbWFya2VkICdmb3ItMi4xMicgKFJGQyBtZWFucyB0aGUgcGF0Y2ggbWF5IGJlIGlu
Y29tcGxldGUsIGFuZCB0aGVyZSdzIG5vDQo+IHJ1c2ggdG8gZ2V0IGFuIGluY29tcGxldGUgcGF0
Y2ggaW4gYmVmb3JlIHRoZSByZWxlYXNlLCBhZnRlciBhbGwpLiAgSSdsbA0KPiByZXBseSBvbiB0
aGF0IHBhdGNoLCBub3cgdGhhdCBpdCdzIGdvdCBteSBhdHRlbnRpb247IGJ1dCBmb3IgdGhpcw0K
PiBwYXJ0aWN1bGFyIHNlcmllcywgSSdtIG1vcmUgY29tZm9ydGFibGUgbGVhdmluZyB0aGUgcmV2
aWV3IHRvIHRoZQ0KPiBtYWludGFpbmVyLCBtb2R1bG8gb25lIGNvbW1lbnQ6DQo+IA0KPiA+IA0K
PiA+IFN1IEhhbmcgKDIpOg0KPiA+ICAgSW1wbGVtZW50IC5oZXggZmlsZSBsb2FkZXINCj4gPiAg
IEFkZCBRVGVzdCB0ZXN0Y2FzZSBmb3IgdGhlIEludGVsIEhleGFkZWNpbWFsIE9iamVjdCBGaWxl
IExvYWRlci4NCj4gPiANCj4gPiAgaHcvYXJtL2Jvb3QuYyAgICAgICAgICB8ICAgOSArLQ0KPiA+
ICBody9jb3JlL2xvYWRlci5jICAgICAgIHwgMjgwICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9ody9sb2FkZXIuaCAgICB8ICAx
NyArKysNCj4gPiAgdGVzdHMvTWFrZWZpbGUuaW5jbHVkZSB8ICAgMiArDQo+ID4gIHRlc3RzL2hl
eGxvYWRlci10ZXN0LmMgfCAgNTYgKysrKysrKysrKw0KPiA+ICB0ZXN0cy90ZXN0LmhleCAgICAg
ICAgIHwgIDExICsrDQo+ID4gIDYgZmlsZXMgY2hhbmdlZCwgMzc0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2hleGxvYWRlci10ZXN0
LmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3Rlc3QuaGV4DQo+IA0KPiBUaGlzIGNy
ZWF0ZXMgbmV3IGZpbGVzIHRoYXQgYXJlIG5vdCBjb3ZlcmVkIGJ5IE1BSU5UQUlORVJTLiAgUGxl
YXNlIGJlDQo+IHN1cmUgdG8gcGF0Y2ggTUFJTlRBSU5FUlMgYXMgd2VsbCBpbiB5b3VyIHYzLg0K
PiANCj4gLS0gDQo+IEVyaWMgQmxha2UsIFByaW5jaXBhbCBTb2Z0d2FyZSBFbmdpbmVlcg0KPiBS
ZWQgSGF0LCBJbmMuICAgICAgICAgICArMS05MTktMzAxLTMyNjYNCj4gVmlydHVhbGl6YXRpb246
ICBxZW11Lm9yZyB8IGxpYnZpcnQub3JnDQo+IA0K
