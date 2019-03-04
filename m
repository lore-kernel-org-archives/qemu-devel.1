Received: from eggs.gnu.org ([209.51.188.92]:44296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h0jzz-00046G-F5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 04:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h0jzu-0000Mq-Eq
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 04:35:03 -0500
Resent-Message-Id: <E1h0jzu-0000Mq-Eq@eggs.gnu.org>
Message-ID: <155169206054.24.15027796208553933258@6acff2cf482b>
In-Reply-To: <20190218214251.8969-1-jsnow@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 4 Mar 2019 01:34:22 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v4 0/1] blockdev: acquire aio_context for
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDIxODIxNDI1MS44OTY5
LTEtanNub3dAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBT
SE9XX0VOVj0xIEo9MTQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBody9jb3Jl
L3N0cmVhbS5vCiAgQ0MgICAgICBody9jb3JlL3B0aW1lci5vCi90bXAvcWVtdS10ZXN0L3NyYy9i
bG9ja2Rldi5jOiBJbiBmdW5jdGlvbiAncW1wX2Jsb2NrX2RpcnR5X2JpdG1hcF9hZGQnOgovdG1w
L3FlbXUtdGVzdC9zcmMvYmxvY2tkZXYuYzoyODY4OjE3OiBlcnJvcjogZXhwZWN0ZWQgJzsnIGJl
Zm9yZSAnfScgdG9rZW4KICAgICAgICAgZ290byBvdXQKICAgICAgICAgICAgICAgICBeCiAgICAg
ICAgICAgICAgICAgOwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAxOTAyMTgyMTQyNTEuODk2OS0xLWpzbm93QHJlZGhhdC5jb20vdGVzdGlu
Zy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
