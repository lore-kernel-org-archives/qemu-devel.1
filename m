Received: from eggs.gnu.org ([2001:4830:134:3::10]:47664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiewen.yao@intel.com>) id 1etc70-0006vZ-IM
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiewen.yao@intel.com>) id 1etc6w-0002zS-C3
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:40:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:44943)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiewen.yao@intel.com>)
	id 1etc6w-0002ye-2R
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:40:14 -0500
From: "Yao, Jiewen" <jiewen.yao@intel.com>
Date: Wed, 7 Mar 2018 16:04:57 +0000
Message-ID: <74D8A39837DF1E4DA445A8C0B3885C503AAE197C@shsmsx102.ccr.corp.intel.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180307155746.18526-3-marcandre.lureau@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/8] SecurityPkg/Tcg2Pei: drop
 PeiReadOnlyVariable from Depex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>
Cc: "pjones@redhat.com" <pjones@redhat.com>, "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>, "lersek@redhat.com" <lersek@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>

UmV2aWV3ZWQtYnk6IGppZXdlbi55YW9AaW50ZWwuY29tDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tIFttYWlsdG86bWFy
Y2FuZHJlLmx1cmVhdUByZWRoYXQuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDcsIDIw
MTggMTE6NTggUE0NCj4gVG86IGVkazItZGV2ZWxAbGlzdHMuMDEub3JnDQo+IENjOiBwam9uZXNA
cmVkaGF0LmNvbTsgWWFvLCBKaWV3ZW4gPGppZXdlbi55YW9AaW50ZWwuY29tPjsNCj4gc3RlZmFu
YkBsaW51eC52bmV0LmlibS5jb207IGxlcnNla0ByZWRoYXQuY29tOyBxZW11LWRldmVsQG5vbmdu
dS5vcmc7DQo+IGphdmllcm1AcmVkaGF0LmNvbTsgTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5k
cmUubHVyZWF1QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAyLzhdIFNlY3VyaXR5
UGtnL1RjZzJQZWk6IGRyb3AgUGVpUmVhZE9ubHlWYXJpYWJsZSBmcm9tDQo+IERlcGV4DQo+IA0K
PiBGcm9tOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4N
Cj4gDQo+IFRoZSBtb2R1bGUgZG9lc24ndCB1c2UgcmVhZC1vbmx5IHZhcmlhYmxlLg0KPiANCj4g
Q2M6IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5jb20+DQo+IENvbnRyaWJ1dGVkLXVuZGVy
OiBUaWFub0NvcmUgQ29udHJpYnV0aW9uIEFncmVlbWVudCAxLjENCj4gU2lnbmVkLW9mZi1ieTog
TWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+IC0tLQ0K
PiAgU2VjdXJpdHlQa2cvVGNnL1RjZzJQZWkvVGNnMlBlaS5pbmYgfCAxIC0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvU2VjdXJpdHlQa2cvVGNn
L1RjZzJQZWkvVGNnMlBlaS5pbmYNCj4gYi9TZWN1cml0eVBrZy9UY2cvVGNnMlBlaS9UY2cyUGVp
LmluZg0KPiBpbmRleCBiYzkxMGMzYmFmOTcuLmE0YWFlMTQ4OGZmOCAxMDA2NDQNCj4gLS0tIGEv
U2VjdXJpdHlQa2cvVGNnL1RjZzJQZWkvVGNnMlBlaS5pbmYNCj4gKysrIGIvU2VjdXJpdHlQa2cv
VGNnL1RjZzJQZWkvVGNnMlBlaS5pbmYNCj4gQEAgLTkxLDcgKzkxLDYgQEAgW1BjZF0NCj4gDQo+
ICBbRGVwZXhdDQo+ICAgIGdFZmlQZWlNYXN0ZXJCb290TW9kZVBwaUd1aWQgQU5EDQo+IC0gIGdF
ZmlQZWlSZWFkT25seVZhcmlhYmxlMlBwaUd1aWQgQU5EDQo+ICAgIGdFZmlUcG1EZXZpY2VTZWxl
Y3RlZEd1aWQNCj4gDQo+ICBbVXNlckV4dGVuc2lvbnMuVGlhbm9Db3JlLiJFeHRyYUZpbGVzIl0N
Cj4gLS0NCj4gMi4xNi4yLjM0Ni5nOTc3OTM1NWUzNA0KDQo=
