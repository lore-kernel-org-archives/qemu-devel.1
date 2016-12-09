Received: from eggs.gnu.org ([2001:4830:134:3::10]:60866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFE3U-0008Ng-7Y
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFE3P-0006u0-UJ
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:49:12 -0500
Received: from [45.249.212.189] (port=2371 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFE3P-0006t1-46
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:49:07 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 9 Dec 2016 05:48:30 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA15826E@DGGEMA505-MBX.china.huawei.com>
References: <1481074285-178976-1-git-send-email-longpeng2@huawei.com>
	<20161207090702.GA21167@redhat.com>
In-Reply-To: <20161207090702.GA21167@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9] cryptodev: remove single-DES
 support in cryptodev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, longpeng <longpeng2@huawei.com>
Cc: "eblake@redhat.com" <eblake@redhat.com>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Pg0KPiBGcm9tOiBEYW5pZWwgUC4gQmVycmFuZ2UgW21haWx0bzpiZXJyYW5nZUByZWRoYXQuY29t
XQ0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDA3LCAyMDE2IDU6MDcgUE0NCj4gVG86IGxv
bmdwZW5nDQo+IENjOiBHb25nbGVpIChBcmVpKTsgZWJsYWtlQHJlZGhhdC5jb207IFd1YmluIChI
KTsgWmhvdWppYW4gKGpheSwgRXVsZXIpOw0KPiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBmb3ItMi45XSBjcnlwdG9kZXY6IHJlbW92ZSBzaW5nbGUtREVTIHN1
cHBvcnQgaW4gY3J5cHRvZGV2DQo+IA0KPiBPbiBXZWQsIERlYyAwNywgMjAxNiBhdCAwOTozMToy
NUFNICswODAwLCBMb25ncGVuZyhNaWtlKSB3cm90ZToNCj4gPiBTaW5nbGUtREVTIGlzIG9ic29s
ZXRlIGFuZCBpdCdzIGJyb2tlbi91c2VsZXNzIGZvciBkZWNhZGVzLCB3ZSBzaG91bGQNCj4gPiBy
ZW1vdmUgaXQgaW4gY3J5cHRvZGV2LCBhcyBzdWdnZXN0ZWQgYnkgRGFuaWVsLg0KPiA+IEd1ZXN0
IHdobyB3YW50cyB0byB1c2UgdGhpcyBvYnNvbGV0ZSBjaXBoZXIgYWxnIHdpbGwgdXNlIGl0cyBi
dWlsdC1pbg0KPiA+IGltcGxlbWVudGF0aW9uIGluc3RlYWQuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMb25ncGVuZyhNaWtlKSA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4g
IGJhY2tlbmRzL2NyeXB0b2Rldi1idWlsdGluLmMgfCA0IC0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvY3J5cHRv
ZGV2LWJ1aWx0aW4uYyBiL2JhY2tlbmRzL2NyeXB0b2Rldi1idWlsdGluLmMNCj4gPiBpbmRleCBh
NDIyNGY0Li41ZmIyODM2IDEwMDY0NA0KPiA+IC0tLSBhL2JhY2tlbmRzL2NyeXB0b2Rldi1idWls
dGluLmMNCj4gPiArKysgYi9iYWNrZW5kcy9jcnlwdG9kZXYtYnVpbHRpbi5jDQo+ID4gQEAgLTIw
NSwxMCArMjA1LDYgQEAgc3RhdGljIGludCBjcnlwdG9kZXZfYnVpbHRpbl9jcmVhdGVfY2lwaGVy
X3Nlc3Npb24oDQo+ID4gICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gPiAgICAgICAgICB9DQo+
ID4gICAgICAgICAgYnJlYWs7DQo+ID4gLSAgICBjYXNlIFZJUlRJT19DUllQVE9fQ0lQSEVSX0RF
U19FQ0I6DQo+ID4gLSAgICAgICAgbW9kZSA9IFFDUllQVE9fQ0lQSEVSX01PREVfRUNCOw0KPiA+
IC0gICAgICAgIGFsZ28gPSBRQ1JZUFRPX0NJUEhFUl9BTEdfREVTX1JGQjsNCj4gPiAtICAgICAg
ICBicmVhazsNCj4gPiAgICAgIGRlZmF1bHQ6DQo+ID4gICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiVW5zdXBwb3J0ZWQgY2lwaGVyIGFsZyA6JXUiLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
c2Vzc19pbmZvLT5jaXBoZXJfYWxnKTsNCj4gDQo+IFJldmlld2VkLWJ5OiBEYW5pZWwgUC4gQmVy
cmFuZ2UgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IA0KDQpRdWV1ZWQsIHRoYW5rcy4NCg0KUmVn
YXJkcywNCi1Hb25nbGVpDQo=
