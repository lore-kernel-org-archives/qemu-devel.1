Received: from eggs.gnu.org ([2001:4830:134:3::10]:34033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gXTRD-00045d-Jf
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gXTQv-0003fl-NC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:02:02 -0500
Resent-Message-Id: <E1gXTQv-0003fl-NC@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gXTQv-0002oW-CW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:01:53 -0500
In-Reply-To: <1544701071-2922-1-git-send-email-liq3ea@gmail.com>
Message-ID: <154471686589.17726.17792356837247129570@02a1dbf831e2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 13 Dec 2018 08:01:07 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] util: check the return value of fcntl
 in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liq3ea@gmail.com
Cc: fam@euphon.net, peter.maydell@linaro.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTQ0NzAxMDcxLTI5MjItMS1n
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
ZXcub3JnL2xvZ3MvMTU0NDcwMTA3MS0yOTIyLTEtZ2l0LXNlbmQtZW1haWwtbGlxM2VhQGdtYWls
LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
