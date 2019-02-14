Received: from eggs.gnu.org ([209.51.188.92]:54509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1guGyp-0006zQ-3U
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1guGoK-0004cc-D6
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:12:17 -0500
Resent-Message-Id: <E1guGoK-0004cc-D6@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1guGoK-0004XM-4o
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:12:16 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <155014990651.24.13923108881499540848@49fa7ef69f7b>
In-Reply-To: <20190213195501.7790-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 14 Feb 2019 05:11:48 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v3 0/1] blockdev: acquire aio_context for
 bitmap add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDIxMzE5NTUwMS43Nzkw
LTEtanNub3dAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBT
SE9XX0VOVj0xIEo9MTQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBody9zbWJp
b3Mvc21iaW9zX3R5cGVfMzgtc3R1Yi5vCiAgQ0MgICAgICBody9zc2kvcGwwMjIubwovdG1wL3Fl
bXUtdGVzdC9zcmMvYmxvY2tkZXYuYzogSW4gZnVuY3Rpb24gJ3FtcF9ibG9ja19kaXJ0eV9iaXRt
YXBfYWRkJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrZGV2LmM6Mjg2ODoxNzogZXJyb3I6IGV4
cGVjdGVkICc7JyBiZWZvcmUgJ30nIHRva2VuCiAgICAgICAgIGdvdG8gb3V0CiAgICAgICAgICAg
ICAgICAgXgogICAgICAgICAgICAgICAgIDsKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwMjEzMTk1NTAxLjc3OTAtMS1qc25vd0ByZWRo
YXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
