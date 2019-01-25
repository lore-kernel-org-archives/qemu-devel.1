Received: from eggs.gnu.org ([209.51.188.92]:60336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gn8aj-0000fQ-Ro
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gn8ai-00024q-KI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:00:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58566
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gn8ag-0001t3-Ef
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:00:44 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0PKrVhV026217
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:00:30 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q85bnmm8c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:00:29 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Fri, 25 Jan 2019 21:00:27 -0000
From: Eric Farman <farman@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-4-cohuck@redhat.com>
	<74c910bf-d34b-b798-db9d-da29787f0a9e@linux.ibm.com>
Date: Fri, 25 Jan 2019 16:00:18 -0500
MIME-Version: 1.0
In-Reply-To: <74c910bf-d34b-b798-db9d-da29787f0a9e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <9742e9c6-627d-2c00-b666-f669b264bbb4@linux.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH v2 3/5] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

DQoNCk9uIDAxLzI1LzIwMTkgMTE6MTkgQU0sIEVyaWMgRmFybWFuIHdyb3RlOg0KPiANCj4g
DQo+IE9uIDAxLzIxLzIwMTkgMDY6MDMgQU0sIENvcm5lbGlhIEh1Y2sgd3JvdGU6DQo+PiBB
bGxvdyB0byBleHRlbmQgdGhlIHJlZ2lvbnMgdXNlZCBieSB2ZmlvLWNjdy4gVGhlIGZpcnN0
IHVzZXIgd2lsbCBiZQ0KPj4gaGFuZGxpbmcgb2YgaGFsdCBhbmQgY2xlYXIgc3ViY2hhbm5l
bC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb3JuZWxpYSBIdWNrIDxjb2h1Y2tAcmVkaGF0
LmNvbT4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy9zMzkwL2Npby92ZmlvX2Njd19vcHMuY8Kg
wqDCoMKgIHwgMTgxICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4+IMKgIGRyaXZl
cnMvczM5MC9jaW8vdmZpb19jY3dfcHJpdmF0ZS5oIHzCoCAzOCArKysrKysNCi4uLnNuaXAu
Li4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3X3ByaXZhdGUu
aCANCj4+IGIvZHJpdmVycy9zMzkwL2Npby92ZmlvX2Njd19wcml2YXRlLmgNCj4+IGluZGV4
IGU4ODIzNzY5N2Y4My4uMjBlNzVmNGYzNjk1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9z
MzkwL2Npby92ZmlvX2Njd19wcml2YXRlLmgNCj4+ICsrKyBiL2RyaXZlcnMvczM5MC9jaW8v
dmZpb19jY3dfcHJpdmF0ZS5oDQo+PiBAQCAtMyw5ICszLDExIEBADQo+PiDCoMKgICogUHJp
dmF0ZSBzdHVmZiBmb3IgdmZpb19jY3cgZHJpdmVyDQo+PiDCoMKgICoNCj4+IMKgwqAgKiBD
b3B5cmlnaHQgSUJNIENvcnAuIDIwMTcNCj4+ICsgKiBDb3B5cmlnaHQgUmVkIEhhdCwgSW5j
LiAyMDE5DQo+PiDCoMKgICoNCj4+IMKgwqAgKiBBdXRob3Iocyk6IERvbmcgSmlhIFNoaSA8
YmpzZGpzaGlAbGludXgudm5ldC5pYm0uY29tPg0KPj4gwqDCoCAqwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBYaWFvIEZlbmcgUmVuIDxyZW54aWFvZkBsaW51eC52bmV0LmlibS5jb20+DQo+
PiArICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIENvcm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRo
YXQuY29tPg0KPj4gwqDCoCAqLw0KPj4gwqAgI2lmbmRlZiBfVkZJT19DQ1dfUFJJVkFURV9I
Xw0KPj4gQEAgLTE5LDYgKzIxLDM4IEBADQo+PiDCoCAjaW5jbHVkZSAiY3NzLmgiDQo+PiDC
oCAjaW5jbHVkZSAidmZpb19jY3dfY3AuaCINCj4+ICsjZGVmaW5lIFZGSU9fQ0NXX09GRlNF
VF9TSElGVMKgwqAgNDANCj4+ICsjZGVmaW5lIFZGSU9fQ0NXX09GRlNFVF9UT19JTkRFWChv
ZmYpwqDCoMKgIChvZmYgPj4gVkZJT19DQ1dfT0ZGU0VUX1NISUZUKQ0KPj4gKyNkZWZpbmUg
VkZJT19DQ1dfSU5ERVhfVE9fT0ZGU0VUKGluZGV4KcKgwqDCoCAoKHU2NCkoaW5kZXgpIDw8
IA0KPj4gVkZJT19DQ1dfT0ZGU0VUX1NISUZUKQ0KPj4gKyNkZWZpbmUgVkZJT19DQ1dfT0ZG
U0VUX01BU0vCoMKgwqAgKCgodTY0KSgxKSA8PCBWRklPX0NDV19PRkZTRVRfU0hJRlQpIA0K
Pj4gLSAxKQ0KPj4gKw0KPj4gKy8qIGNhcGFiaWxpdHkgY2hhaW4gaGFuZGxpbmcgc2ltaWxh
ciB0byB2ZmlvLXBjaSAqLw0KPj4gK3N0cnVjdCB2ZmlvX2Njd19wcml2YXRlOw0KPj4gK3N0
cnVjdCB2ZmlvX2Njd19yZWdpb247DQo+PiArDQo+PiArc3RydWN0IHZmaW9fY2N3X3JlZ29w
cyB7DQo+PiArwqDCoMKgIHNpemVfdMKgwqDCoCAoKnJlYWQpKHN0cnVjdCB2ZmlvX2Njd19w
cml2YXRlICpwcml2YXRlLCBjaGFyIF9fdXNlciANCj4+ICpidWYsDQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzaXplX3QgY291bnQsIGxvZmZfdCAqcHBvcyk7DQo+PiArwqDCoMKg
IHNpemVfdMKgwqDCoCAoKndyaXRlKShzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZSAqcHJpdmF0
ZSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciBfX3VzZXIgKmJ1
Ziwgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpOw0KDQpPb3BzLiAgUGVyIG15IHJlY29t
bWVuZGF0aW9uIG9uIHYxLCB5b3UgY2hhbmdlIHRoZXNlIHRvICJzc2l6ZV90IiBpbiANCnBh
dGNoIDUuICBNaWdodCBhcyB3ZWxsIGp1c3QgZG8gdGhhdCBoZXJlLg0KDQo+PiArwqDCoMKg
IHZvaWTCoMKgwqAgKCpyZWxlYXNlKShzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZSAqcHJpdmF0
ZSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2ZmlvX2Njd19y
ZWdpb24gKnJlZ2lvbik7DQo+PiArfTsNCj4+ICsNCj4+ICtzdHJ1Y3QgdmZpb19jY3dfcmVn
aW9uIHsNCj4+ICvCoMKgwqAgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR5
cGU7DQo+PiArwqDCoMKgIHUzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdWJ0
eXBlOw0KPj4gK8KgwqDCoCBjb25zdCBzdHJ1Y3QgdmZpb19jY3dfcmVnb3BzwqDCoMKgICpv
cHM7DQo+PiArwqDCoMKgIHZvaWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmRh
dGE7DQo+PiArwqDCoMKgIHNpemVfdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
aXplOw0KPj4gK8KgwqDCoCB1MzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxh
Z3M7DQo+PiArfTsNCj4+ICsNCj4+ICtpbnQgdmZpb19jY3dfcmVnaXN0ZXJfZGV2X3JlZ2lv
bihzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZSAqcHJpdmF0ZSwNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgc3VidHlwZSwNCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdmZpb19jY3dfcmVnb3Bz
ICpvcHMsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZV90IHNp
emUsIHUzMiBmbGFncywgdm9pZCAqZGF0YSk7DQo+PiArDQo+PiDCoCAvKioNCj4+IMKgwqAg
KiBzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZQ0KPj4gwqDCoCAqIEBzY2g6IHBvaW50ZXIgdG8g
dGhlIHN1YmNoYW5uZWwNCi4uLnNuaXAuLi4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Vh
cGkvbGludXgvdmZpby5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZmaW8uaA0KPj4gaW5kZXgg
MDJiYjdhZDZlOTg2Li41NmUyNDEzZDNlMDAgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgvdmZpby5oDQo+PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmZpby5oDQo+
PiBAQCAtMzUzLDYgKzM1Myw4IEBAIHN0cnVjdCB2ZmlvX3JlZ2lvbl9nZnhfZWRpZCB7DQo+
PiDCoCAjZGVmaW5lIFZGSU9fREVWSUNFX0dGWF9MSU5LX1NUQVRFX0RPV07CoCAyDQo+PiDC
oCB9Ow0KPj4gKyNkZWZpbmUgVkZJT19SRUdJT05fVFlQRV9DQ1fCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICgyKQ0KPj4gKw0KPiANCj4gQ29vbC7CoCA6KQ0KPiANCj4+IMKgIC8qDQo+PiDC
oMKgICogMTBkZSB2ZW5kb3Igc3ViLXR5cGUNCj4+IMKgwqAgKg0KPj4NCj4gDQo+IExvb2tz
IGZpbmUgdG8gbWUuwqAgSSdkIGxvdmUgdG8gdGhpbmsgdGhlcmUgd2FzIGEgd2F5IHRvIGdl
bmVyYWxpemUgdGhpcyANCj4gZm9yIG90aGVyIHZmaW8gZHJpdmVycywgYnV0IG1hbiB0aGF0
J3MgYSB0YWxsIHRhc2suwqAgU28uLi4NCg0KV2l0aCB0aGUgc3NpemVfdCBmaXh1cCBmcm9t
IHBhdGNoIDUuLi4NCg0KPiANCj4gUmV2aWV3ZWQtYnk6IEVyaWMgRmFybWFuIDxmYXJtYW5A
bGludXguaWJtLmNvbT4NCg0K
