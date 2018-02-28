Received: from eggs.gnu.org ([2001:4830:134:3::10]:34889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wanpeng.li@hotmail.com>) id 1er0mZ-0005Xn-Qp
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wanpeng.li@hotmail.com>) id 1er0mU-0005UK-Tw
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:24:27 -0500
Received: from mail-oln040092255055.outbound.protection.outlook.com
	([40.92.255.55]:6033
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wanpeng.li@hotmail.com>)
	id 1er0mU-0005Te-EM
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:24:22 -0500
From: Wanpeng Li <wanpeng.li@hotmail.com>
Date: Wed, 28 Feb 2018 12:24:16 +0000
Message-ID: <SG2PR02MB13123F626D823E3CED98E84C80C70@SG2PR02MB1312.apcprd02.prod.outlook.com>
References: <1490624810-44752-1-git-send-email-agraf@suse.de>
	<33183CC9F5247A488A2544077AF19020DA56A1AE@DGGEMA505-MBX.china.huawei.com>
	<b5b23b57-8f66-3774-3a45-e42fd7edae96@suse.de>
	<aa78a250-5a88-300d-e935-aaeb8a69748b@redhat.com>
In-Reply-To: <aa78a250-5a88-300d-e935-aaeb8a69748b@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF2E7B412B20B0468F2D3C7627447F46@apcprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386: Allow monitor / mwait cpuid override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Zhuangyanying <ann.zhuangyanying@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

T24gMi8yOC8xOCA3OjUwIFBNLCBQYW9sbyBCb256aW5pIHdyb3RlOg0KDQo+IE9uIDI4LzAyLzIw
MTggMDA6NTUsIEFsZXhhbmRlciBHcmFmIHdyb3RlOg0KPj4NCj4+IE9uIDI3LjAyLjE4IDEwOjUy
LCBHb25nbGVpIChBcmVpKSB3cm90ZToNCj4+PiBIaSBhbGwsDQo+Pj4NCj4+PiBHdWVzdHMgY291
bGQgYWNoaXZlIGdvb2QgcGVyZm9ybWFuY2UgaW4gJ01lc3NhZ2UgUGFzc2luZyBXb3JrbG9hZHMn
DQo+Pj4gc2NlbmFyaW9zIHdoZW4ga25vd2luZyB0aGUgWDg2X0ZFQVRVUkVfTVdBSVQgZmVhdHVy
ZSB3aGljaCBpcyBwcmVzZW50ZWQgYnkgcWVtdS4NCj4+PiB0aGUgcmVhc29uIGlzIHRoYXQgYWZ0
ZXIga25vd2luZyB0aGF0IGZlYXR1cmUsDQo+Pj4gdGhlIGd1ZXN0IGNvdWxkIHVzZSBtd2FpdCBt
ZXRob2QsIHdoaWNoIHNhdmVzIFZNRVhJVCwNCj4+PiB0byBkbyBpZGxlLCBhbmQgYWNoaXZlcyBo
aWdoIHBlcmZvcm1hY2UgaW4gbGF0ZW5jeS1zZW5zaXRpdmUgc2NlbmFyaW8uDQo+Pj4NCj4+PiBJ
cyB0aGVyZSBhbnkgcGxhbiBmb3IgdGhpcyBwYXRjaD8NCj4+Pg0KPj4+IE9yIE1heSBJIHNlbmQg
YSB1cGRhdGVkIHZlcnNpb24gYmFzZWQgb24geW91cnM/IEBBbGV4Pw0KPj4gT2gsIGRpZCBJIGRy
b3AgdGhlIGJhbGwgb24gdGhpcyBvbmU/IElmIHRoYXQncyB0aGUgY2FzZSwgc3VyZSwgZ28gYWhl
YWQuDQo+IEhpLCBpdCBpcyBwcm9iYWJseSBiZXN0IHRvIGltcGxlbWVudCB0aGlzIGZlYXR1cmUg
YmFzZWQgb24gdGhlDQo+IEhJTlRfREVESUNBVEVEIGNwdWlkIGJpdCB0aGF0IFdhbnBlbmcgTGkg
aXMgYWRkaW5nLg0KDQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC8yLzEzLzYyNCBBcyB5b3Ug
cG9pbnRlZCBvdXQsIE1XQUlUL0hMVC9QQVVTRSANCm5vbi1leGl0aW5nIHNob3VsZCBiZSBpbXBs
ZW1lbnRlZCBhdCB0aGUgc2FtZSB0aW1lIGFuZCBJJ20gc3RpbGwgd29ya2luZyANCm9uIGl0LiBJ
IHdpbGwgcHJlcGFyZSBwYXRjaGVzIGZvciBib3RoIHRoZSBxZW11IGFuZCBrdm0gc3R1ZmZzLiA6
KQ0KDQpSZWdhcmRzLA0KV2FucGVuZyBMaQ0KDQo=
