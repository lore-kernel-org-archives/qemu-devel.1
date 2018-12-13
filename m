Received: from eggs.gnu.org ([2001:4830:134:3::10]:33591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gXMbI-0008Er-Ur
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 03:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gXMb4-0006ms-Kg
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 03:43:59 -0500
Resent-Message-Id: <E1gXMb4-0006ms-Kg@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gXMb4-0006kp-75
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 03:43:54 -0500
In-Reply-To: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
Message-ID: <154468427058.9757.15261216341451632615@02a1dbf831e2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 12 Dec 2018 22:57:51 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] util: check the return value of fcntl in
 qemu_set_{block, noblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liq3ea@gmail.com
Cc: fam@euphon.net, peter.maydell@linaro.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTQ0NjY2OTc3LTQ4MTYtMS1n
aXQtc2VuZC1lbWFpbC1saXEzZWFAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxl
ZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1
aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTgKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCmxpYnBt
ZW0gc3VwcG9ydCAgIG5vCmxpYnVkZXYgICAgICAgICAgIG5vCgpXQVJOSU5HOiBVc2Ugb2YgU0RM
IDEuMiBpcyBkZXByZWNhdGVkIGFuZCB3aWxsIGJlIHJlbW92ZWQgaW4KV0FSTklORzogZnV0dXJl
IHJlbGVhc2VzLiBQbGVhc2Ugc3dpdGNoIHRvIHVzaW5nIFNETCAyLjAKCk5PVEU6IGNyb3NzLWNv
bXBpbGVycyBlbmFibGVkOiAgJ2NjJwogIEdFTiAgICAgeDg2XzY0LXNvZnRtbXUvY29uZmlnLWRl
dmljZXMubWFrLnRtcAoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMTU0NDY2Njk3Ny00ODE2LTEtZ2l0LXNlbmQtZW1haWwtbGlxM2VhQGdtYWls
LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
