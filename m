Received: from eggs.gnu.org ([2001:4830:134:3::10]:44424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fUqkj-00063O-HP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fUqki-0006ME-8J
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:47:13 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Mon, 18 Jun 2018 09:46:54 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8387019ED@FRAEML521-MBX.china.huawei.com>
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<20180516152026.2920-7-shameerali.kolothum.thodi@huawei.com>
	<bd67ed40-81d6-58dc-ccaf-efd8a40ca96f@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8386F6E04@FRAEML521-MBX.china.huawei.com>
	<20180615154441.4rr5mtcnran5cf3s@kamzik.brq.redhat.com>
	<CAFEAcA-nG4Xv=PmxzW3tzs-TStziMDHMFxYi6_teSe1GhLH=hw@mail.gmail.com>
	<333cd485-dc75-d295-16fd-98a1108e1e15@redhat.com>
	<CAFEAcA-+Xp6B_g_a89-7wP_DN1ftGrKTON=P6wH_6ESq9GPKKQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-+Xp6B_g_a89-7wP_DN1ftGrKTON=P6wH_6ESq9GPKKQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 6/6] hw/arm: Populate non-contiguous
 memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Auger Eric <eric.auger@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, Linuxarm <linuxarm@huawei.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCBb
bWFpbHRvOnBldGVyLm1heWRlbGxAbGluYXJvLm9yZ10NCj4gU2VudDogMTUgSnVuZSAyMDE4IDE3
OjMzDQo+IFRvOiBBdWdlciBFcmljIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IENjOiBBbmRy
ZXcgSm9uZXMgPGRyam9uZXNAcmVkaGF0LmNvbT47IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkN
Cj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0
aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47DQo+IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29t
PjsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207DQo+IFpoYW9zaGVuZ2xvbmcgPHpoYW9zaGVu
Z2xvbmdAaHVhd2VpLmNvbT47IGltYW1tZWRvQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtR
ZW11LWRldmVsXSBbUkZDIHYyIDYvNl0gaHcvYXJtOiBQb3B1bGF0ZSBub24tY29udGlndW91cw0K
PiBtZW1vcnkgcmVnaW9ucw0KPiANCj4gT24gMTUgSnVuZSAyMDE4IGF0IDE3OjEzLCBBdWdlciBF
cmljIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+IE9uIDA2LzE1LzIwMTggMDU6
NTQgUE0sIFBldGVyIE1heWRlbGwgd3JvdGU6DQo+ID4+IFdoeSBzaG91bGQgdGhlIFZNIGV2ZXIg
Y2FyZSBhYm91dCB3aGVyZSB0aGUgYWRkcmVzcyByZWdpb25zIGluIHRoZQ0KPiA+PiBob3N0IGhh
cHBlbiB0byBiZSB3aGVuIGl0IGNvbWVzIHRvIHdoZXJlIGl0J3MgcHV0dGluZyBpdHMgUkFNDQo+
ID4+IGluIHRoZSBWTSdzIGFkZHJlc3MgbGF5b3V0PyBJIGZlZWwgbGlrZSBJJ20gbWlzc2luZyBz
b21ldGhpbmcgaGVyZS4uLg0KPiANCj4gPiBUaGUgVk0gY2Fubm90IHVzZSBSQU0gR1BBIHRoYXQg
bWF0Y2hlcyBhc3NpZ25lZCBkZXZpY2UgcmVzZXJ2ZWQgSU9WQQ0KPiA+IHJlZ2lvbnMuIFdoZW4g
eW91IGFzc2lnbiBhIGRldmljZSwgdGhlIHdob2xlIFZNIFJBTSBpcyBtYXBwZWQgaW4gdGhlDQo+
ID4gcGh5c2ljYWwgSU9NTVUgYW5kIElPVkEgY29ycmVzcG9uZHMgdG8gR1BBLiBidXQgc29tZXRp
bWVzIHNvbWUgSU9WQQ0KPiA+IGNhbm5vdCBiZSB1c2VkIGR1ZSB0byB0aGUgaG9zdCBzcGVjaWZp
Y2l0aWVzIGFuZCBlc3BlY2lhbGx5IGlvbW11DQo+ID4gcGVjdWxpYXJpdGllcy4gU29tZSBJT1ZB
cyBtYXkgYmUgc2ltcGx5ICJieXBhc3NlZCIgYnkgdGhlIGlvbW11LCBsaWtlIG9uDQo+ID4geDg2
IGFuZCBhbHNvIHdpdGggc29tZSBBUk0gU01NVSBpbnRlZ3JhdGlvbi4gSW4gc3VjaCBhIGNhc2Ug
dGhlIERNQQ0KPiA+IGFjY2Vzc2VzIGhhdmUgbm8gY2hhbmNlIHRvIHJlYWNoIHRoZSBndWVzdCBS
QU0gYXMgZXhwZWN0ZWQuIEhvcGUgaXQNCj4gPiBjbGFyaWZpZXMuDQo+IA0KPiBIbW0uIFdlIGRv
bid0IHdhbnQgdG8gaGF2ZSB0aGUgYWRkcmVzcyBsYXlvdXQgb2YNCj4gdGhlIFZNIGhhdmUgdG8g
Y29wZSB3aXRoIGFsbCB0aGUgdmFyaW91cyBvZGRpdGllcyB0aGF0IGhvc3QNCj4gc3lzdGVtcyBt
aWdodCBoYXZlLiBJcyB0aGlzIGtpbmQgb2YgdGhpbmcgY29tbW9uLCBvciByYXJlPw0KPiBJJ2Qg
bXVjaCByYXRoZXIganVzdCBzYXkgIndlIGRvbid0IHN1cHBvcnQgZGV2aWNlIHBhc3N0aHJvdWdo
DQo+IG9uIHRoYXQgc29ydCBvZiBzeXN0ZW0iLg0KPg0KDQpBcyBmYXIgYXMgSSBrbm93IG9uIEFS
TTY0IHBsYXRmb3JtcyB0aGlzIGlzIG5vdCB2ZXJ5IHJhcmUgbWFpbmx5IGJlY2F1c2Ugb2YNCnRo
ZSBwaHlzIE1TSSBkb29yYmVsbCBhbmQgdGhlIGZhY3QgdGhhdCBtZW1vcnkgbWFwIGlzIG5vdCBz
dGFuZGFyZGl6ZWQuIFRoaXMNCndhcyBkaXNjdXNzZWQgaW4gTFBDIHNvbWV0aW1lIGJhY2tbMV0g
YW5kIGEgc3lzZnMgaW50ZXJmYWNlIHdhcyBwcm92aWRlZCB0bw0KcmVwb3J0IHRoZXNlIHJlc2Vy
dmVkIHJlZ2lvbnMuIEFuZCBsYXRlciBBbGV4IGNvbW1lbnRlZCB0aGF0IHZmaW8gbmVlZHMgYSBt
b3JlDQpyb2J1c3Qgd2F5IG9mIGlkZW50aWZ5aW5nIGFuZCByZXBvcnRpbmcgdGhlc2UgcmVnaW9u
cyBhbmQgdGhhdOKAmXMgaG93IHRoZSB2ZmlvIGtlcm5lbA0KcGF0Y2ggc2VyaWVzWzJdIHdhcyBp
bnRyb2R1Y2VkIG9uIHdoaWNoIHRoaXMgcWVtdSBzZXJpZXMgaXMgYmFzZWQgb24uDQoNClRoYW5r
cywNClNoYW1lZXINCg0KWzFdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE2LzExLzcvOTM1DQoN
ClsyXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC80LzE4LzI5Mw0KDQoNCg==
