Received: from eggs.gnu.org ([2001:4830:134:3::10]:34869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <james.r.harris@intel.com>) id 1egBYG-0002rD-JS
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <james.r.harris@intel.com>) id 1egBYB-0004D2-Rd
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:40:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:14842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <james.r.harris@intel.com>)
	id 1egBYB-0004Bk-JE
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:40:51 -0500
From: "Harris, James R" <james.r.harris@intel.com>
Date: Mon, 29 Jan 2018 15:40:47 +0000
Message-ID: <1443E331-E975-482A-830E-FFF0C4C7DD00@intel.com>
References: <1516003315-17878-1-git-send-email-changpeng.liu@intel.com>
	<1516003315-17878-2-git-send-email-changpeng.liu@intel.com>
	<20180129152912.GL20446@stefanha-x1.localdomain>
In-Reply-To: <20180129152912.GL20446@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7656F7E3B4CE8741A43E7921A38282B5@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1] block/NVMe: introduce a new vhost NVMe
 host device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Busch, Keith" <keith.busch@intel.com>, "famz@redhat.com" <famz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>

DQoNCk9uIDEvMjkvMTgsIDg6MjkgQU0sICJTdGVmYW4gSGFqbm9jemkiIDxzdGVmYW5oYUBnbWFp
bC5jb20+IHdyb3RlOg0KDQo8dHJpbT4NCiAgICANCiAgICBFYWNoIG5ldyBmZWF0dXJlIGhhcyBh
IGNvc3QgaW4gdGVybXMgb2YgbWFpbnRhaW5hbmNlLCB0ZXN0aW5nLA0KICAgIGRvY3VtZW50YXRp
b24sIGFuZCBzdXBwb3J0LiAgVXNlcnMgbmVlZCB0byBiZSBlZHVjYXRlZCBhYm91dCB0aGUgcm9s
ZSBvZg0KICAgIGVhY2ggYXZhaWxhYmxlIHN0b3JhZ2UgY29udHJvbGxlciBhbmQgaG93IHRvIGNo
b29zZSBiZXR3ZWVuIHRoZW0uDQogICAgDQogICAgSSdtIG5vdCBzdXJlIHdoeSBRRU1VIHNob3Vs
ZCBnbyBpbiB0aGlzIGRpcmVjdGlvbiBzaW5jZSBpdCBtYWtlcyB0aGUNCiAgICBsYW5kc2NhcGUg
bW9yZSBjb21wbGV4IGFuZCBoYXJkZXIgdG8gc3VwcG9ydC4gIFlvdSd2ZSBzYWlkIHRoZQ0KICAg
IHBlcmZvcm1hbmNlIGlzIGNvbXBhcmFibGUgdG8gdmhvc3QtdXNlci1ibGsuICBTbyB3aGF0IGRv
ZXMgTlZNZSBvZmZlcg0KICAgIHRoYXQgbWFrZXMgdGhpcyB3b3J0aHdoaWxlPw0KICAgIA0KICAg
IEEgY29vbCBOVk1lIGZlYXR1cmUgd291bGQgYmUgdGhlIGFiaWxpdHkgdG8gcGFzcyB0aHJvdWdo
IGludmlkaWR1YWwNCiAgICBxdWV1ZXMgdG8gZGlmZmVyZW50IGd1ZXN0cyB3aXRob3V0IFNSLUlP
Vi4gIEluIG90aGVyIHdvcmRzLCBiaW5kIGEgcXVldWUNCiAgICB0byBuYW1lc3BhY2Ugc3Vic2V0
IHNvIHRoYXQgbXVsdGlwbGUgZ3Vlc3RzIGNhbiBiZSBpc29sYXRlZCBmcm9tIGVhY2gNCiAgICBv
dGhlci4gIFRoYXQgd2F5IHRoZSBkYXRhIHBhdGggd291bGQgbm90IHJlcXVpcmUgdm1leGl0cy4g
IFRoZSBjb250cm9sDQogICAgcGF0aCBhbmQgZGV2aWNlIGluaXRpYWxpemF0aW9uIHdvdWxkIHN0
aWxsIGJlIGVtdWxhdGVkIGJ5IFFFTVUgc28gdGhlDQogICAgaGFyZHdhcmUgZG9lcyBub3QgbmVl
ZCB0byBwcm92aWRlIHRoZSBmdWxsIHJlc291cmNlcyBhbmQgc3RhdGUgbmVlZGVkDQogICAgZm9y
IFNSLUlPVi4gIEkgbG9va2VkIGludG8gdGhpcyBidXQgY2FtZSB0byB0aGUgY29uY2x1c2lvbiB0
aGF0IGl0IHdvdWxkDQogICAgcmVxdWlyZSBjaGFuZ2VzIHRvIHRoZSBOVk1lIHNwZWNpZmljYXRp
b24gYmVjYXVzZSB0aGUgbmFtZXNwYWNlIGlzIGENCiAgICBwZXItY29tbWFuZCBmaWVsZC4NCiAg
ICANCkNvcnJlY3Qg4oCTIGFueSBjb21tYW5kIGZyb20gYW55IHF1ZXVlIGNhbiBhY2Nlc3MgYW55
IG5hbWVzcGFjZSBvbiB0aGUgY29udHJvbGxlci4NCg0KQW5vdGhlciByZWFzb24gdGhpcyBpcyBu
b3QgcG9zc2libGUgaXMgdGhhdCBtb3N0IChpZiBub3QgYWxsPykgY29udHJvbGxlcnMgaGF2ZSBD
QVAuRFNUUkQgKERvb3JiZWxsIFN0cmlkZSkgPSAwLCBtZWFuaW5nIGRvb3JiZWxsIHJlZ2lzdGVy
cyBmb3IgYWxsIHF1ZXVlcyBmYWxsIHdpdGhpbiB0aGUgc2FtZSBwYWdlLg0KDQoNCg0K
