Received: from eggs.gnu.org ([209.51.188.92]:55388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h36h1-0005uy-FB
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 18:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h36X7-0000IU-Bu
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 18:03:02 -0400
Resent-Message-Id: <E1h36X7-0000IU-Bu@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1h36X7-0000HZ-3K
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 18:03:01 -0400
Message-ID: <155225535059.31099.18079898826613752491@6acff2cf482b>
In-Reply-To: <1552119170-15474-1-git-send-email-thuth@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 10 Mar 2019 15:02:31 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] hw/char/parallel: Make it possible to
 compile also without CONFIG_PARALLEL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-devel@nongnu.org, mrezanin@redhat.com, f4bug@amsat.org, mst@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTUyMTE5MTcwLTE1NDc0LTEt
Z2l0LXNlbmQtZW1haWwtdGh1dGhAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1p
bmd3QGZlZG9yYSBTSE9XX0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgogIEdFTiAgICAgeDg2XzY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0teDg2XzY0LmV4ZQouLi9o
dy9jaGFyL3BhcmFsbGVsLWhlbHBlci5vOiBJbiBmdW5jdGlvbiBgcGFyYWxsZWxfaW5pdCc6Ci90
bXAvcWVtdS10ZXN0L3NyYy9ody9jaGFyL3BhcmFsbGVsLWhlbHBlci5jOjIyOiB1bmRlZmluZWQg
cmVmZXJlbmNlIHRvIGBpc2FfY3JlYXRlJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEg
ZXhpdCBzdGF0dXMKbWFrZVsxXTogKioqIFtNYWtlZmlsZToyMTI6IHFlbXUtc3lzdGVtLWFhcmNo
NjR3LmV4ZV0gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQ0OTogc3ViZGlyLWFhcmNoNjQt
c29mdG1tdV0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4u
LgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MTU1MjExOTE3MC0xNTQ3NC0xLWdpdC1zZW5kLWVtYWlsLXRodXRoQHJlZGhhdC5jb20vdGVzdGlu
Zy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
