Received: from eggs.gnu.org ([2001:4830:134:3::10]:42159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRFV-0001qA-T0
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRFS-0006QZ-Qe
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:46:45 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:46030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRFS-0006Pv-KM
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:46:42 -0400
Received: by mail-vk0-x242.google.com with SMTP id b78-v6so699038vka.12
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:46:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180717022924.25428-1-f4bug@amsat.org>
	<20180717161214.42bb4c26.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <74b0f29c-523f-52ac-c6c8-554f3da66789@amsat.org>
Date: Tue, 17 Jul 2018 11:46:36 -0300
MIME-Version: 1.0
In-Reply-To: <20180717161214.42bb4c26.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH 0/4] docker: Improve 'host-cross' image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <huth@tuxfamily.org>

SGkgQ29ybmVsaWEsDQoNCk9uIDA3LzE3LzIwMTggMTE6MTIgQU0sIENvcm5lbGlhIEh1Y2sg
d3JvdGU6DQo+IE9uIE1vbiwgMTYgSnVsIDIwMTggMjM6Mjk6MjAgLTAzMDANCj4gUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kgPGY0YnVnQGFtc2F0Lm9yZz4gd3JvdGU6DQo+IA0KPj4gU29y
cnkgSSBkb24ndCBoYXZlIGEgYmV0dGVyIG5hbWUgZm9yIHRoaXMgaW1hZ2UsDQo+PiBpdCBp
cyBtZWFudCB0byBjcm9zcy1idWlsZCBmb3IgdGhlIHNhbWUgYXJjaGl0ZWN0dXJlDQo+PiB0
aGFuIHRoZSBob3N0Lg0KPj4NCj4+IER1ZSB0byB0aGUgYmFkIG5hbWUsIGV4cGxpY2l0ZWx5
IHRhZ2dlZCB0aGUgbGFzdCAyDQo+PiBwYXRjaGVzIGFzICdSRkMnLg0KPj4NCj4+IFRlc3Rl
ZCBvbiB4ODZfNjQgYW5kIGFhcmNoNjQsIHNob3VsZCBhbHNvIHdvcmsgb24NCj4+IHMzOTB4
IGFuZCBwcGM2NGxlIChwZXIgdGhlIERvY2tlciBkb2MpLg0KPj4NCj4+IElmIHRoZXkgYXJl
IHZvbHVudGVlcnMgZm9yIHRlc3QsIHRoZSBjb21tYW5kIGlzIGFzIHNpbXBsZSBhczoNCj4+
DQo+PiAgICQgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BkZWJpYW4taG9zdC1jcm9zcyBbVj0x
XQ0KPiANCj4gT24gczM5MHgsIGFsbCBsb29rcyByZWFzb25hYmxlIHVudGlsIGl0IHRyaWVz
IHRvIGluc3RhbGwgbGlieGVuLWRldjoNCg0KaHR0cHM6Ly9wYWNrYWdlcy5kZWJpYW4ub3Jn
L3N0cmV0Y2gvbGlieGVuLWRldiNwZG93bmxvYWQNCk9oLCBubyBYZW4gZm9yIHMzOTB4IG5v
ciBwcGM2NGVsLi4uIE9LLg0KDQo+IFN0ZXAgNC8xNCA6IFJVTiBERUJJQU5fRlJPTlRFTkQ9
bm9uaW50ZXJhY3RpdmUgZWF0bXlkYXRhICAgICBhcHQtZ2V0IGluc3RhbGwgLXkgLS1uby1p
bnN0YWxsLXJlY29tbWVuZHMgICAgICAgICBsaWJhaW8tZGV2ICAgICAgICAgbGliYXNvdW5k
Mi1kZXYgICAgICAgICBsaWJhdHRyMS1kZXYgICAgICAgICBsaWJibHVldG9vdGgtZGV2ICAg
ICAgICAgbGliYnJsYXBpLWRldiAgICAgICAgIGxpYmJ6Mi1kZXYgICAgICAgICBsaWJjYWNh
cmQtZGV2ICAgICAgICAgbGliY2FwLWRldiAgICAgICAgIGxpYmNhcC1uZy1kZXYgICAgICAg
ICBsaWJjYXBzdG9uZS1kZXYgICAgICAgICBsaWJjdXJsNC1nbnV0bHMtZGV2ICAgICAgICAg
bGliZXBveHktZGV2ICAgICAgICAgbGliZmR0LWRldiAgICAgICAgIGxpYmlidmVyYnMtZGV2
ICAgICAgICAgbGliaXNjc2ktZGV2ICAgICAgICAgbGliamVtYWxsb2MtZGV2ICAgICAgICAg
bGlianBlZy1kZXYgICAgICAgICBsaWJsdHRuZy11c3QtZGV2ICAgICAgICAgbGlibHpvMi1k
ZXYgICAgICAgICBsaWJuY3Vyc2VzdzUtZGV2ICAgICAgICAgbGlibmZzLWRldiAgICAgICAg
IGxpYm5zczMtZGV2ICAgICAgICAgbGlicGl4bWFuLTEtZGV2ICAgICAgICAgbGlicHVsc2Ut
ZGV2ICAgICAgICAgbGlicmFkb3MtZGV2ICAgICAgICAgbGlicmJkLWRldiAgICAgICAgIGxp
YnJkbWFjbS1kZXYgICAgICAgICBsaWJzZWNjb21wLWRldiAgICAgICAgIGxpYnNuYXBweS1k
ZXYgICAgICAgICBsaWJzcGljZS1wcm90b2NvbC1kZXYgICAgICAgICBsaWJzc2gyLTEtZGV2
ICAgICAgICAgbGlidXJjdS1kZXYgICAgICAgICBsaWJ1c2ItMS4wLTAtZGV2ICAgICAgICAg
bGlidXNicmVkaXJob3N0LWRldiAgICAgICAgIGxpYnVzYnJlZGlycGFyc2VyLWRldiAgICAg
ICAgIGxpYnZkZXBsdWctZGV2ICAgICAgICAgbGlidnRlLWRldiAgICAgICAgIGxpYnhlbi1k
ZXYgICAgICAgICB1dWlkLWRldiAgICAgICAgIHhmc2xpYnMtZGV2DQo+ICAtLS0+IFJ1bm5p
bmcgaW4gYTdmNmFlODkyYTA1DQo+IFJlYWRpbmcgcGFja2FnZSBsaXN0cy4uLg0KPiBCdWls
ZGluZyBkZXBlbmRlbmN5IHRyZWUuLi4NCj4gUmVhZGluZyBzdGF0ZSBpbmZvcm1hdGlvbi4u
Lg0KPiBFOiBVbmFibGUgdG8gbG9jYXRlIHBhY2thZ2UgbGlieGVuLWRldg0KDQpUaGFua3Mg
Zm9yIHRlc3RpbmcgdGhpcywgc2luY2UgdGhlIGZpcnN0IHN0ZXBzIHBhc3NlZCwgdGhlIGZv
bGxvd2luZw0Kc2hvdWxkbid0IGJlIGEgcHJvYmxlbSBub3cuDQoNClJlZ2FyZHMsDQoNClBo
aWwuDQo=
