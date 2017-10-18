Received: from eggs.gnu.org ([2001:4830:134:3::10]:40690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1e4lDh-0006ZC-CL
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1e4lDc-0006Fa-Dk
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:05:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:40542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1e4lDc-0006DN-4y
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:04:56 -0400
From: "Valluri, Amarnath" <amarnath.valluri@intel.com>
Date: Wed, 18 Oct 2017 10:04:26 +0000
Message-ID: <1508321124.4061.38.camel@intel.com>
References: <20171018083305.5246-1-quintela@redhat.com>
	<cfb8e3d0-7c4e-f83f-3887-18e6af8b0418@redhat.com>
	<874lqwolg2.fsf@secure.laptop>
In-Reply-To: <874lqwolg2.fsf@secure.laptop>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <36D9612C0B9AF34BAF6B89A54984676A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] tpm: Fix compilation with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "quintela@redhat.com" <quintela@redhat.com>, "lvivier@redhat.com" <lvivier@redhat.com>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>

U29ycnkgZm9yIGNhdXNpbmcgYnVpbGQgYnJlYWsgOigNCg0KSSB3b3VsZCBwcmVmZXIgdGhlIHdh
eSB0cG1faW5pdCgpIHdhcyBoYW5kbGVkIGluIHZsLmMsIGV2ZW4NCnRwbV9jbGVhbnVwKCkgc2h1
b3VsZCBiZSBndWFyZGVkIGJlaGluZCAjaWZkZWYgQ09ORklHX1RQTS4NCg0KLSBBbWFybmF0aA0K
T24gV2VkLCAyMDE3LTEwLTE4IGF0IDExOjI3ICswMjAwLCBKdWFuIFF1aW50ZWxhIHdyb3RlOg0K
PiBMYXVyZW50IFZpdmllciA8bHZpdmllckByZWRoYXQuY29tPiB3cm90ZToNCj4gPiANCj4gPiBP
biAxOC8xMC8yMDE3IDEwOjMzLCBKdWFuIFF1aW50ZWxhIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBD
b21taXQNCj4gPiA+IMKgwqDCoGMzN2NhY2FiZjIyODViMDczMWI0NGMxZjY2Nzc4MWZkZDRmMmI2
NTgNCj4gPiA+IA0KPiA+ID4gYnJva2UgY29tcGlsYXRpb24gd2l0aG91dCB0cG0uwqDCoEp1c3Qg
YWRkIGFuIGVtcHR5IHRwbV9jbGVhbnVwKCkNCj4gPiA+IHN0dWIuDQo+ID4gdHBtX2luaXQoKSBh
bmQgdHBtX2NvbmZpZ19wYXJzZSgpIGFyZSBtYW5hZ2VkIGluIGEgZGlmZmVyZW50IHdheToNCj4g
PiB0aGV5DQo+ID4gYXJlIGluY2x1ZGVkIGluIGEgIiNpZmRlZiBDT05GSUdfVFBNIC4uICNlbmRp
ZiIgaW4gdmwuYw0KPiA+IA0KPiA+IEkgdGhpbmsgeW91IHNob3VsZCBmb2xsb3cgdGhlIHNhbWUg
d2F5Lg0KPiB0cG0gaXMgd2VpcmQgKFRNKToNCj4gDQo+IGluIGluY2x1ZGUvc3lzZW11L3RwbS5o
IHdlIGRvIHRoYXQgaW4gYW4gaW5jbGluZSBmdW5jdGlvbg0KPiANCj4gc3RhdGljIGlubGluZSBU
UE1WZXJzaW9uIHRwbV9nZXRfdmVyc2lvbih2b2lkKQ0KPiB7DQo+ICNpZmRlZiBDT05GSUdfVFBN
DQo+IMKgwqDCoMKgT2JqZWN0ICpvYmogPSBvYmplY3RfcmVzb2x2ZV9wYXRoX3R5cGUoIiIsIFRZ
UEVfVFBNX1RJUywgTlVMTCk7DQo+IA0KPiDCoMKgwqDCoGlmIChvYmopIHsNCj4gwqDCoMKgwqDC
oMKgwqDCoHJldHVybiB0cG1fdGlzX2dldF90cG1fdmVyc2lvbihvYmopOw0KPiDCoMKgwqDCoH0N
Cj4gI2VuZGlmDQo+IMKgwqDCoMKgcmV0dXJuIFRQTV9WRVJTSU9OX1VOU1BFQzsNCj4gfQ0KPiAN
Cj4gDQo+IHRwbS5jLCB3ZSBoYXZlIGFuIGlmZGVmIGluIHRoZSBtaWRkbGUgb2YgdGhlIGZpbGUN
Cj4gDQo+ICNpZmRlZiBDT05GSUdfVFBNDQo+IA0KPiAjZW5kaWYNCj4gDQo+IA0KPiB2bC5jLCB3
ZSBwcm90ZWN0IHRwbV8qIGNhbGxzIHdpdGggQ09ORklHX1RQTQ0KPiANCj4gI2lmZGVmIENPTkZJ
R19UUE0NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2FzZSBRRU1VX09QVElPTl90cG1kZXY6
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHRwbV9jb25maWdfcGFyc2Uo
cWVtdV9maW5kX29wdHMoInRwbWRldiIpLA0KPiBvcHRhcmcpIDwgMCkgew0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgxKTsNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJl
YWs7DQo+ICNlbmRpZg0KPiANCj4gDQo+IGJ1dCB3ZSBhbG1vc3QgbmV2ZXIgZG86DQo+IA0KPiAj
aWZkZWYgQ09ORklHX1RQTQ0KPiDCoMKgwqB0cG1fY2xlYW51cCgpDQo+ICNlbmRpZg0KPiANCj4g
V2Ugbm9ybWFsbHkgY3JlYXRlIGFuIHN0dWIgZnVuY3Rpb24uDQo+IA0KPiBTbyAuLi4uLi4NCj4g
DQo+IFdlIGFyZSBnb2luZyB0byBiZSBpbmNvbnNpc3RlbnQgd2hhdGV2ZXIgd2UgZGlkLg0KPiAN
Cj4gSSB3b3VsZCBoYXZlIHZvdGUgZm9yDQo+IA0KPiAjaWZkZWYgQ09ORklHX1RQTQ0KPiB2b2lk
IHRwbV9jbGVhbnVwKHZvaWQpOw0KPiAjZWxzZQ0KPiBzdGF0aWMgaW5saW5lIHZvaWQgdHBtX2Ns
ZWFudXAodm9pZCkge30NCj4gI2VuZGlmDQo+IA0KPiBPbiB0aGUgaGVhZGVyIGZpbGUgKGl0IHdh
cyBteSBmaXJzdCBzb2x1dGlvbiksIGJ1dCBoYXZpbmcgQ09ORklHX1RQTQ0KPiBvbg0KPiB0cG0u
YyBzb3VuZGVkIGdyb3NzLg0KPiANCj4gU28gLi4uLg0KPiANCj4gSSB0aGluayB0aGF0IG5vdyB0
aGF0IHRoZSBwcm9ibGVtIGlzIHNwb3R0ZWQsIEkgd2lsbCBsZWZ0IHRoZSBjaG9vc2UNCj4gb2YN
Cj4gdGhlIHNvbHV0aW9uIHRvIHRoZSBtYWludGFuZXIgTzotKQ0KPiANCj4gTGF0ZXIsIEp1YW4u
