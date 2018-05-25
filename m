Received: from eggs.gnu.org ([2001:4830:134:3::10]:42341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fM2RH-00019d-Md
	for qemu-devel@nongnu.org; Thu, 24 May 2018 22:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fM2RD-0005hw-C1
	for qemu-devel@nongnu.org; Thu, 24 May 2018 22:26:43 -0400
Received: from smtp67.cstnet.cn ([159.226.251.67]:34855 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fM2RC-0005fH-Nm
	for qemu-devel@nongnu.org; Thu, 24 May 2018 22:26:39 -0400
Date: Fri, 25 May 2018 10:26:33 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <13868e98-f6ab-40d1-0ebc-27d11985eaad@redhat.com>
References: <1527161340-3200-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1527161340-3200-3-git-send-email-suhang16@mails.ucas.ac.cn>
	<13868e98-f6ab-40d1-0ebc-27d11985eaad@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <278d33d7.10b9.163951e7e74.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PULL 2/2] Add QTest testcase for the Intel
 Hexadecimal
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

U3VyZSwgSSB3aWxsIGxpc3Qgb3RoZXIgaW52b2x2ZWQgZmlsZXMuIFRoYW5rcyBmb3IgeW91IHN1
Z2dlc3Rpb24uCgpTVSBIYW5nCgoiRXJpYyBCbGFrZSIgPGVibGFrZUByZWRoYXQuY29tPndyb3Rl
Ogo+IE9uIDA1LzI0LzIwMTggMDY6MjkgQU0sIFN1IEhhbmcgd3JvdGU6DQo+ID4gJ3Rlc3QuaGV4
JyBmaWxlIGlzIGEgYmFyZSBtZXRhbCBBUk0gc29mdHdhcmUgc3RvcmVkIGluIEhleGFkZWNpbWFs
DQo+ID4gT2JqZWN0IEZvcm1hdC4gV2hlbiBpdCdzIGxvYWRlZCBieSBRRU1VLCBpdCB3aWxsIHBy
aW50ICJIZWxsbyB3b3JsZCFcbiINCj4gPiBvbiBjb25zb2xlLg0KPiA+IA0KPiA+IGBwcmVfc3Rv
cmVgIGFycmF5IGluICdoZXhsb2FkZXItdGVzdC5jJyBmaWxlLCBzdG9yZXMgdGhlIGJpbmFyeSBm
b3JtYXQNCj4gPiBvZiAndGVzdC5oZXgnIGZpbGUsIHdoaWNoIGlzIHVzZWQgdG8gdmVyaWZ5IGNv
cnJlY3RuZXNzLg0KPiA+IA0KPiA+IFJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBTdGVmZmVuIEdvcnR6IDxxZW11Lm1s
QHN0ZWZmZW4tZ29lcnR6LmRlPg0KPiA+IFN1Z2dlc3RlZC1ieTogU3RlZmFuIEhham5vY3ppIDxz
dGVmYW5oYUByZWRoYXQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN1IEhhbmcgPHN1aGFuZzE2
QG1haWxzLnVjYXMuYWMuY24+DQo+ID4gLS0tDQo+ID4gICBNQUlOVEFJTkVSUyAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgNiArKysrDQo+ID4gICBjb25maWd1cmUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgNCArKysNCj4gPiAgIHRlc3RzL01ha2VmaWxlLmluY2x1ZGUgICAgICAg
ICAgICAgICB8ICAyICsrDQo+ID4gICB0ZXN0cy9oZXgtbG9hZGVyLWNoZWNrLWRhdGEvdGVzdC5o
ZXggfCAxMiArKysrKysrKw0KPiA+ICAgdGVzdHMvaGV4bG9hZGVyLXRlc3QuYyAgICAgICAgICAg
ICAgIHwgNTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IA0KPiBUaGUg
cHJldmlvdXMgcGF0Y2ggYWxzbyB0b3VjaGVkOg0KPiANCj4gICBody9hcm0vYm9vdC5jICAgICAg
IHwgICA3ICstDQo+ICAgaHcvY29yZS9sb2FkZXIuYyAgICB8IDI0NiANCj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGluY2x1ZGUvaHcv
bG9hZGVyLmggfCAgMTIgKysrDQo+IA0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAgLTEy
OTEsNiArMTI5MSwxMiBAQCBGOiBody9jb3JlL2dlbmVyaWMtbG9hZGVyLmMNCj4gPiAgIEY6IGlu
Y2x1ZGUvaHcvY29yZS9nZW5lcmljLWxvYWRlci5oDQo+ID4gICBGOiBkb2NzL2dlbmVyaWMtbG9h
ZGVyLnR4dA0KPiA+IA0KPiA+ICtJbnRlbCBIZXhhZGVjaW1hbCBPYmplY3QgRmlsZSBMb2FkZXIN
Cj4gPiArTTogU3UgSGFuZyA8c3VoYW5nMTZAbWFpbHMudWNhcy5hYy5jbj4NCj4gPiArUzogTWFp
bnRhaW5lZA0KPiA+ICtGOiB0ZXN0cy9oZXhsb2FkZXItdGVzdC5jDQo+ID4gK0Y6IHRlc3RzL2hl
eC1sb2FkZXItY2hlY2stZGF0YS90ZXN0LmhleA0KPiA+ICsNCj4gDQo+IEl0IGxvb2tzIG9kZCBo
YXZpbmcgYSBtYWludGFpbmVyIHRoYXQgY2xhaW1zIG9ubHkgdGVzdCBmaWxlczsgZG8geW91IA0K
PiB3YW50IHRvIGFsc28gbGlzdCBzb21lIG9mIHRoZSBvdGhlciBmaWxlcyB0b3VjaGVkIGJ5IHRo
aXMgcGF0Y2ggc28gdGhhdCANCj4geW91IGdldCBub3RpZmljYXRpb24gaWYgb25lIG9mIHRoZSBp
bXBsZW1lbnRhdGlvbiBmaWxlcyBoYXMgc3Vic2VxdWVudCANCj4gcGF0Y2hlcyAocmF0aGVyIHRo
YW4ganVzdCB0aGUgdGVzdCBmaWxlcyk/DQo+IA0KPiAtLSANCj4gRXJpYyBCbGFrZSwgUHJpbmNp
cGFsIFNvZnR3YXJlIEVuZ2luZWVyDQo+IFJlZCBIYXQsIEluYy4gICAgICAgICAgICsxLTkxOS0z
MDEtMzI2Ng0KPiBWaXJ0dWFsaXphdGlvbjogIHFlbXUub3JnIHwgbGlidmlydC5vcmcNCg==
