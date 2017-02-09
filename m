Received: from eggs.gnu.org ([2001:4830:134:3::10]:43565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cbrgX-0006MZ-6c
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cbrgT-00071q-AB
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:35:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:34156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juro.bystricky@intel.com>)
	id 1cbrgT-000706-03
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:35:01 -0500
From: "Bystricky, Juro" <juro.bystricky@intel.com>
Date: Thu, 9 Feb 2017 16:34:47 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B6118FBD03@ORSMSX112.amr.corp.intel.com>
References: <1486595166-34097-1-git-send-email-juro.bystricky@intel.com>
	<1486595166-34097-2-git-send-email-juro.bystricky@intel.com>
	<4c51c959-fe9c-b27f-552a-84d8a2fe68c1@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FB1B4@ORSMSX112.amr.corp.intel.com>
	<ad0b171b-ae9d-11f9-15e8-c500cd4ef5c2@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FB84B@ORSMSX112.amr.corp.intel.com>
	<8a5c3932-5ca6-6127-35b4-b8b8f57d923f@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FBCB0@ORSMSX112.amr.corp.intel.com>
	<55a9d36b-c848-fd5f-623d-0456bfcaae40@denx.de>
In-Reply-To: <55a9d36b-c848-fd5f-623d-0456bfcaae40@denx.de>
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

PiBUaGUgY29kZSBydW5uaW5nIG9uIG5pb3MyIGNhbiBpc3N1ZSB1bmFsaWduZWQgYWNjZXNzIHRv
IHRoZSBqdGFnIHVhcnQNCj4gcmVnaXN0ZXJzLCB5ZXMgPyBJZiB0aGF0IGhhcHBlbnMsIHdoYXQg
aGFwcGVucyBvbiByZWFsIEhXIGFuZCBob3cgaXMNCj4gdGhpcyBlbXVsYXRlZCA/DQoNCk1pc2Fs
aWduZWQgYWNjZXNzZXMgdG8gYW55IHJlZ2lzdGVycyB3b3VsZCByYWlzZSBhbiBleGNlcHRpb24u
DQpUaGUgZXhjZXB0aW9uIGlzIGhhbmRsZWQgYnkgaW50ZXJydXB0IGNvbnRyb2xsZXIsIGVpdGhl
ciAicmVhbCINCm9yIGVtdWxhdGVkLiBTdWNoIGFjY2VzcyBzaG91bGQgbmV2ZXIgcmVhY2ggY29k
ZSBmb3IganRhZyB1YXJ0Lg0KDQpBbHNvIG5vdGUgd2Ugb25seSBhbGxvdyBhY2Nlc3Mgc2l6ZSA0
IGluIHRoZSBjb2RlOg0KDQpzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzIGp1YXJ0X29wcyA9
IHsNCiAgICAucmVhZCA9IGFsdGVyYV9qdWFydF9yZWFkLA0KICAgIC53cml0ZSA9IGFsdGVyYV9q
dWFydF93cml0ZSwNCiAgICAuZW5kaWFubmVzcyA9IERFVklDRV9MSVRUTEVfRU5ESUFOLA0KICAg
IC52YWxpZCA9IHsNCiAgICAgICAgLm1pbl9hY2Nlc3Nfc2l6ZSA9IDQsDQogICAgICAgIC5tYXhf
YWNjZXNzX3NpemUgPSA0DQogICAgfQ0KfTsNCg0KVGhhbmtzDQpKdXJvDQo=
