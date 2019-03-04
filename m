Received: from eggs.gnu.org ([209.51.188.92]:56931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h0uML-00012s-Tj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h0uML-0008N5-1P
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:38:49 -0500
Resent-Message-Id: <E1h0uML-0008N5-1P@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1h0uMK-0008KQ-O8
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:38:48 -0500
Message-ID: <155173191314.24.3401262847871164036@6acff2cf482b>
In-Reply-To: <20190218182851.19714-1-svens@stackframe.org>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 4 Mar 2019 12:38:34 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] hw/hppa/dino: mask out lower 2 bits of PCI
 config addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: svens@stackframe.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, deller@gmx.de, rth@twiddle.net

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDIxODE4Mjg1MS4xOTcx
NC0xLXN2ZW5zQHN0YWNrZnJhbWUub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTAyMTgxODI4NTEuMTk3MTQtMS1zdmVuc0BzdGFja2ZyYW1lLm9yZy90ZXN0aW5nLmRvY2tlci1t
aW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
