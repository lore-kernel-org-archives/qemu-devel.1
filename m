Received: from eggs.gnu.org ([2001:4830:134:3::10]:46621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <star.zeng@intel.com>) id 1etjjk-0005db-Hw
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <star.zeng@intel.com>) id 1etjjh-0000QQ-6A
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:48:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:7338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <star.zeng@intel.com>) id 1etjjg-0000Pm-TZ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:48:45 -0500
From: "Zeng, Star" <star.zeng@intel.com>
Date: Thu, 8 Mar 2018 00:48:38 +0000
Message-ID: <0C09AFA07DD0434D9E2A0C6AEB0483103BA47F0F@shsmsx102.ccr.corp.intel.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-2-marcandre.lureau@redhat.com>
	<FF72C7E4248F3C4E9BDF19D4918E90F249662402@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <FF72C7E4248F3C4E9BDF19D4918E90F249662402@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/8] SecurityPkg: also clear
 HashInterfaceHob.SupportedHashMask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>
Cc: "pjones@redhat.com" <pjones@redhat.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>, "lersek@redhat.com" <lersek@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>, "Zhang, Chao B" <chao.b.zhang@intel.com>, "Zeng,
	Star" <star.zeng@intel.com>

UmV2aWV3ZWQtYnk6IFN0YXIgWmVuZyA8c3Rhci56ZW5nQGludGVsLmNvbT4NCg0KVGhhbmtzLA0K
U3Rhcg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFpoYW5nLCBDaGFvIEIgDQpT
ZW50OiBUaHVyc2RheSwgTWFyY2ggOCwgMjAxOCA4OjM1IEFNDQpUbzogbWFyY2FuZHJlLmx1cmVh
dUByZWRoYXQuY29tOyBlZGsyLWRldmVsQGxpc3RzLjAxLm9yZw0KQ2M6IHBqb25lc0ByZWRoYXQu
Y29tOyBZYW8sIEppZXdlbiA8amlld2VuLnlhb0BpbnRlbC5jb20+OyBzdGVmYW5iQGxpbnV4LnZu
ZXQuaWJtLmNvbTsgbGVyc2VrQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgamF2
aWVybUByZWRoYXQuY29tOyBaZW5nLCBTdGFyIDxzdGFyLnplbmdAaW50ZWwuY29tPg0KU3ViamVj
dDogUkU6IFtQQVRDSCB2MiAxLzhdIFNlY3VyaXR5UGtnOiBhbHNvIGNsZWFyIEhhc2hJbnRlcmZh
Y2VIb2IuU3VwcG9ydGVkSGFzaE1hc2sNCg0KUmV2aWV3ZWQtYnk6IENoYW8gWmhhbmc8Y2hhby5i
LnpoYW5nQGludGVsLmNvbT4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IG1h
cmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbSBbbWFpbHRvOm1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0
LmNvbV0gDQpTZW50OiBXZWRuZXNkYXksIE1hcmNoIDcsIDIwMTggMTE6NTggUE0NClRvOiBlZGsy
LWRldmVsQGxpc3RzLjAxLm9yZw0KQ2M6IHBqb25lc0ByZWRoYXQuY29tOyBZYW8sIEppZXdlbiA8
amlld2VuLnlhb0BpbnRlbC5jb20+OyBzdGVmYW5iQGxpbnV4LnZuZXQuaWJtLmNvbTsgbGVyc2Vr
QHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgamF2aWVybUByZWRoYXQuY29tOyBN
YXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT47IFpoYW5nLCBD
aGFvIEIgPGNoYW8uYi56aGFuZ0BpbnRlbC5jb20+OyBaZW5nLCBTdGFyIDxzdGFyLnplbmdAaW50
ZWwuY29tPg0KU3ViamVjdDogW1BBVENIIHYyIDEvOF0gU2VjdXJpdHlQa2c6IGFsc28gY2xlYXIg
SGFzaEludGVyZmFjZUhvYi5TdXBwb3J0ZWRIYXNoTWFzaw0KDQpGcm9tOiBNYXJjLUFuZHLDqSBM
dXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCg0KQ29tbWl0IDRjYzJiNjNiZDgy
OTQyNmIwNWJhZDBkODk1MmYxODU1YTEwZDZlZDcgZml4ZWQgYW4gb3V0IG9mIGJvdW5kcw0KWmVy
b01lbSgpIGNhbGwuIEhvd2V2ZXIsIGFzIExhc3psbyBFcnNlayBwb2ludGVkIG91dCwgdGhlIGlu
dGVudCB3YXMgdG8gY2xlYXIgYWxsIGJ1dCB0aGUgSWRlbnRpZmllciAodG8gcmV2ZXJ0IHRoZSBl
ZmZlY3Qgb2YgUmVnaXN0ZXJIYXNoSW50ZXJmYWNlTGliKCkpLiBGb3IgdGhhdCwgaXQgc2hvdWxk
IGNsZWFyIHRoZSBTdXBwb3J0ZWRIYXNoTWFzayB0b28uDQoNCkNjOiBKaWV3ZW4gWWFvIDxqaWV3
ZW4ueWFvQGludGVsLmNvbT4NCkNjOiBDaGFvIFpoYW5nIDxjaGFvLmIuemhhbmdAaW50ZWwuY29t
Pg0KQ2M6IFN0YXIgWmVuZyA8c3Rhci56ZW5nQGludGVsLmNvbT4NCkNjOiBMYXN6bG8gRXJzZWsg
PGxlcnNla0ByZWRoYXQuY29tPg0KQ29udHJpYnV0ZWQtdW5kZXI6IFRpYW5vQ29yZSBDb250cmli
dXRpb24gQWdyZWVtZW50IDEuMQ0KU2lnbmVkLW9mZi1ieTogTWFyYy1BbmRyw6kgTHVyZWF1IDxt
YXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQotLS0NCiAuLi4vTGlicmFyeS9IYXNoTGliQmFz
ZUNyeXB0b1JvdXRlci9IYXNoTGliQmFzZUNyeXB0b1JvdXRlclBlaS5jIHwgMSArDQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9TZWN1cml0eVBrZy9MaWJy
YXJ5L0hhc2hMaWJCYXNlQ3J5cHRvUm91dGVyL0hhc2hMaWJCYXNlQ3J5cHRvUm91dGVyUGVpLmMg
Yi9TZWN1cml0eVBrZy9MaWJyYXJ5L0hhc2hMaWJCYXNlQ3J5cHRvUm91dGVyL0hhc2hMaWJCYXNl
Q3J5cHRvUm91dGVyUGVpLmMNCmluZGV4IDM2MWE0ZjY1MDhhMC4uYmY2ZTEzMzZlZTc2IDEwMDY0
NA0KLS0tIGEvU2VjdXJpdHlQa2cvTGlicmFyeS9IYXNoTGliQmFzZUNyeXB0b1JvdXRlci9IYXNo
TGliQmFzZUNyeXB0b1JvdXRlclBlaS5jDQorKysgYi9TZWN1cml0eVBrZy9MaWJyYXJ5L0hhc2hM
aWJCYXNlQ3J5cHRvUm91dGVyL0hhc2hMaWJCYXNlQ3J5cHRvUm91dGUNCisrKyByUGVpLmMNCkBA
IC00MjYsNiArNDI2LDcgQEAgSGFzaExpYkJhc2VDcnlwdG9Sb3V0ZXJQZWlDb25zdHJ1Y3RvciAo
DQogICAgIC8vDQogICAgIFplcm9NZW0gKCZIYXNoSW50ZXJmYWNlSG9iLT5IYXNoSW50ZXJmYWNl
LCBzaXplb2YgKEhhc2hJbnRlcmZhY2VIb2ItPkhhc2hJbnRlcmZhY2UpKTsNCiAgICAgSGFzaElu
dGVyZmFjZUhvYi0+SGFzaEludGVyZmFjZUNvdW50ID0gMDsNCisgICAgSGFzaEludGVyZmFjZUhv
Yi0+U3VwcG9ydGVkSGFzaE1hc2sgPSAwOw0KICAgfQ0KIA0KICAgLy8NCi0tDQoyLjE2LjIuMzQ2
Lmc5Nzc5MzU1ZTM0DQoNCg==
