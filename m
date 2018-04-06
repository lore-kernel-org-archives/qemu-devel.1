Received: from eggs.gnu.org ([2001:4830:134:3::10]:60987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1f4Uok-0003YM-VR
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1f4Uog-0001lO-4M
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:06:26 -0400
Received: from phx2.ddci.com ([184.183.10.180]:57109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alarson@ddci.com>) id 1f4Uof-0001fN-UP
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:06:22 -0400
In-Reply-To: <CAFEAcA_LknKJeabd74Vp6=3J1cv7yevOYW6+-TvRE9FJtSdKMQ@mail.gmail.com>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
	<OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
	<CAFEAcA8KrrzDacQXsiW-UxKsy4sodCteUWgAHu6ZdyMG4u7riQ@mail.gmail.com>
	<OFDC2B6138.CF2B5F15-ON88258266.00751F63-86258266.0075810C@ddci.com>
	<CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
	<OF82B90B05.E59E0B03-ON88258267.0044BF04-86258267.004A0756@ddci.com>
	<CAFEAcA82xrYHYg3WvCpXwqm2ajv6SEUCL7cJsXFF+rccXxrUpg@mail.gmail.com>
	<CAFEAcA_LknKJeabd74Vp6=3J1cv7yevOYW6+-TvRE9FJtSdKMQ@mail.gmail.com>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OF4BD73ECC.1B5CB55D-ON88258267.005D53FE-86258267.005DF33E@ddci.com>
Date: Fri, 6 Apr 2018 12:06:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] -icount changes physical address assignments in
 QEMU 2.10/2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

IlBldGVyIE1heWRlbGwiIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+IHdyb3RlIG9uIDA0LzA2
LzIwMTggMDk6NTE6NTUgDQpBTToNCg0KPiBJJ3ZlIG5vdyBkb25lIHRoaXMsIGFuZCBjYW4gcmVw
cm9kdWNlIHRoZSBwcm9ibGVtLiBTbyB0aGUNCj4gaXNzdWUgaXMgZ2VuZXJpYyB0byAzMi1iaXQg
aG9zdHMuDQoNClN1cHBvcnRpbmcgZXZpZGVuY2U6IEkgY29tcGlsZWQgQ3lnd2luL01JTkdXIHdp
dGggeDg2XzY0IGFuZCB0aGUNCnJlc3VsdGluZyBiaW5hcmllcyB3b3JrIHByb3Blcmx5DQoNCkZX
SVcsIHRoZSBjb21waWxlIGhhZCBzb21lIGFub21hbG91cyBiZWhhdmlvcjoNCg0KLi4uL3FlbXUt
Mi4xMi4wLXJjMi9zY3JpcHRzL2ZlYXR1cmVfdG9fYy5zaDogbGluZSA3MTogL3Vzci9iaW4vc2Vk
OiANCkludmFsaWQgYXJndW1lbnQNCg0KbGluZSA3MSBpczoNCiAgICBhcnJheW5hbWU9eG1sX2Zl
YXR1cmVfJChlY2hvICRpbnB1dCB8IHNlZCAncywuKi8sLDsgcy9bLS5dL18vZycpDQoNCk5vdCBz
dXJlIHdoYXQgdGhlIHByb2JsZW0gaXMsIGJ1dCBJIGFsd2F5cyB1c2UgIi1lIiBiZWZvcmUgc2Ny
aXB0cy4NCg0KTGF0ZXIgdGhlIG1ha2UgZmFpbGVkIHdpdGggdGhlIGZvbGxvd2luZyBlcnJvcjoN
Cg0KPiBnZGJzdHViLXhtbC5jOjY5NToyODogZXJyb3I6IOKAmHhtbF9mZWF0dXJlX+KAmSB1bmRl
Y2xhcmVkIGhlcmUgKG5vdCBpbiBhIA0KZnVuY3Rpb24pDQo+ICAgeyAiaTM4Ni02NGJpdC1jb3Jl
LnhtbCIsIHhtbF9mZWF0dXJlXyB9LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fg0KPiBnZGJzdHViLXhtbC5jOjYxOjE5OiB3YXJuaW5nOiDigJh4bWxfZmVhdHVyZV9p
Mzg2XzY0Yml0X2NvcmVfeG1s4oCZIGRlZmluZWQgDQpidXQgbm90IHVzZWQgWy1XdW51c2VkLWNv
bnN0LXZhcmlhYmxlPV0NCj4gIHN0YXRpYyBjb25zdCBjaGFyIHhtbF9mZWF0dXJlX2kzODZfNjRi
aXRfY29yZV94bWxbXSA9IHsNCj4gICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4NCj4gbWFrZVsxXTogKioqIA0KWy9jeWdkcml2ZS9jL3NjbS9EZW9zL3By
b2R1Y3RzL3FlbXUvYnJhbmNoZXMvMi4xMi9vdXRwdXQvcWVtdS0yLjEyLjAtcmMyL3J1bGVzLm1h
azo2NjogDQpnZGJzdHViLXhtbC5vXSBFcnJvciAxDQo+IG1ha2U6ICoqKiBbTWFrZWZpbGU6NDc4
OiBzdWJkaXIteDg2XzY0LXNvZnRtbXVdIEVycm9yIDINCg==
