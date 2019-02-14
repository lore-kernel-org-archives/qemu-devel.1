Received: from eggs.gnu.org ([209.51.188.92]:41621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gu8dW-0001a1-P1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gu8dK-0005JA-GF
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:26 -0500
Resent-Message-Id: <E1gu8dK-0005JA-GF@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gu8dI-0005FL-Kn
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:21 -0500
Message-ID: <155011841530.7770.8244531092798205662@ebba9967afc0>
In-Reply-To: <20190212200750.27521-1-jsnow@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 13 Feb 2019 20:26:56 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] blockdev: acquire aio_context for
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
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDIxMjIwMDc1MC4yNzUy
MS0xLWpzbm93QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEg
U0hPV19FTlY9MSBKPTE0Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgdWkvaW5w
dXQta2V5bWFwLm8KICBDQyAgICAgIHVpL2tiZC1zdGF0ZS5vCi90bXAvcWVtdS10ZXN0L3NyYy9i
bG9ja2Rldi5jOiBJbiBmdW5jdGlvbiAncW1wX2Jsb2NrX2RpcnR5X2JpdG1hcF9hZGQnOgovdG1w
L3FlbXUtdGVzdC9zcmMvYmxvY2tkZXYuYzoyODY4OjE3OiBlcnJvcjogZXhwZWN0ZWQgJzsnIGJl
Zm9yZSAnfScgdG9rZW4KICAgICAgICAgZ290byBvdXQKICAgICAgICAgICAgICAgICBeCiAgICAg
ICAgICAgICAgICAgOwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAxOTAyMTIyMDA3NTAuMjc1MjEtMS1qc25vd0ByZWRoYXQuY29tL3Rlc3Rp
bmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
