Received: from eggs.gnu.org ([2001:4830:134:3::10]:33160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cbrGW-0002at-35
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cbrGQ-0006kt-58
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:08:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:26428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juro.bystricky@intel.com>)
	id 1cbrGP-0006iT-Qz
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:08:06 -0500
From: "Bystricky, Juro" <juro.bystricky@intel.com>
Date: Thu, 9 Feb 2017 16:07:53 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B6118FBCB0@ORSMSX112.amr.corp.intel.com>
References: <1486595166-34097-1-git-send-email-juro.bystricky@intel.com>
	<1486595166-34097-2-git-send-email-juro.bystricky@intel.com>
	<4c51c959-fe9c-b27f-552a-84d8a2fe68c1@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FB1B4@ORSMSX112.amr.corp.intel.com>
	<ad0b171b-ae9d-11f9-15e8-c500cd4ef5c2@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FB84B@ORSMSX112.amr.corp.intel.com>
	<8a5c3932-5ca6-6127-35b4-b8b8f57d923f@denx.de>
In-Reply-To: <8a5c3932-5ca6-6127-35b4-b8b8f57d923f@denx.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/1] nios2: Add Altera JTAG UART
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "crwulff@gmail.com" <crwulff@gmail.com>, "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>

PiA+PiBbLi4uXQ0KPiA+Pg0KPiA+Pj4+PiArc3RhdGljIHVpbnQ2NF90IGFsdGVyYV9qdWFydF9y
ZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsDQo+IHVuc2lnbmVkDQo+ID4+Pj4gaW50IHNp
emUpDQo+ID4+Pj4+ICt7DQo+ID4+Pj4+ICsgICAgQWx0ZXJhSlVBUlRTdGF0ZSAqcyA9IG9wYXF1
ZTsNCj4gPj4+Pj4gKyAgICB1aW50MzJfdCByOw0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsgICAgYWRk
ciA+Pj0gMjsNCj4gPj4+Pg0KPiA+Pj4+IEhtbW1tbSwgaG93IHdpbGwgdW5hbGlnbmVkIHJlYWQg
ZnJvbSBvbmUgb2YgdGhlc2UgcmVnaXN0ZXJzIGJlIGhhbmRsZWQNCj4gPj4+PiBvbiByZWFsIEhX
ID8gaWUuIHJlYWQgZnJvbSBhZGRyZXNzIDB4MyA/IFdoYXQgYWJvdXQgd3JpdGVzID8NCj4gPj4+
Pg0KPiA+Pj4NCj4gPj4+IHRoZXJlIGlzIG5vIHJlYWRpbmcvd3JpdGluZyBnb2luZyBvbiB2aWEg
ImFkZHIiLg0KPiA+Pj4gVGhpcyBqdXN0IG1hcHMgdGhlIGh3IGFkZHJlc3MgaW50byByZWdpc3Rl
ciBudW1iZXIsIHdoZXJlIHJlZ2lzdGVycyBhcmUNCj4gPj4gYXQNCj4gPj4+IDQgYnl0ZXMgYm91
bmRhcmllcyAoc28gdGhleSBhcmUgYWxpZ25lZCBhcyBuZWVkZWQpIGJ1dCBpbmRleGVkIGFzDQo+
ID4+IDEsMiwzLi4uLg0KPiA+Pj4gKFByZXR0eSBjb21tb24gY29kZSBpbiBvdGhlciBkcml2ZXJz
LikNCj4gPj4+IEJ1dCB3aWxsIHJlZG8gdGhlIGNvZGUgYW55d2F5IHNvIHRoZXJlIGFyZSBubyBz
aGlmdHMuDQo+ID4+DQo+ID4+IFRoaXMgZG9lc24ndCBhbnN3ZXIgbXkgcXVlc3Rpb24gYXQgYWxs
LiBIb3cgZG9lcyByZWFsIGhhcmR3YXJlIGJlaGF2ZSBpZg0KPiA+PiB5b3UgcmVhZCBmcm9tIHVu
YWxpZ25lZCBhZGRyZXNzIGluIHRoZSByZWdpc3RlciBzcGFjZSAsIGllLiBvZmZzZXQgMHgzID8N
Cj4gPj4NCj4gPg0KPiA+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgcXVlc3Rpb24gaGVyZS4g
V2hpY2ggInJlYWwgaGFyZHdhcmUiIGFyZSB3ZQ0KPiB0YWxraW5nIGFib3V0Pw0KPiANCj4gQnkg
cmVhbCBoYXJkd2FyZSBJIG1lYW4gcmVhbCBOaW9zMiBzeXN0ZW0gLi4uDQo+IA0KPiA+IElmICJy
ZWFsIGhhcmR3YXJlIiBjb250YWlucyBNTVUgb3IgTVBVIHRoZW4gYW4gZXhjZXB0aW9uIGlzIGdl
bmVyYXRlZCBvbg0KPiBtaXNhbGlnbiBhY2Nlc3MuDQo+IA0KPiBJcyB0aGlzIGhhbmRsZWQgaGVy
ZSBvciBub3QgPw0KPiANCg0KU29ycnksIEkgYW0gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBx
dWVzdGlvbi4NCkV4Y2VwdGlvbnMgYXJlIGhhbmRsZWQgYnkgaW50ZXJydXB0IGNvbnRyb2xsZXIu
DQpUaGlzIGNvZGUgZm9yIEpUQUcgVUFSVCBkb2VzIG5vdCBoYXZlIGFueSBtaXNhbGlnbmVkIGFj
Y2Vzc2VzLg0KDQoNCg==
