Received: from eggs.gnu.org ([2001:4830:134:3::10]:43586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cc3zn-00057M-6j
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cc3zm-0007HP-8Z
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:43:47 -0500
Resent-Message-Id: <E1cc3zm-0007HP-8Z@eggs.gnu.org>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
Message-ID: <148670541085.57.13212277084157073846@eba24e3a0d7f>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 9 Feb 2017 21:43:31 -0800 (PST)
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 00/10] target/ppc: Implement
 POWER9 pseries tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sjitindarsingh@gmail.com
Cc: famz@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de, sam.bobroff@au1.ibm.com, david@gibson.dropbear.id.au

SGksCgpZb3VyIHNlcmllcyBmYWlsZWQgYXV0b21hdGljIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZl
IGRvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHku
CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1FFTVUtUFBDXSBbUEFUQ0ggVjIgMDAvMTBdIHRhcmdl
dC9wcGM6IEltcGxlbWVudCBQT1dFUjkgcHNlcmllcyB0Y2cKTWVzc2FnZS1pZDogMTQ4NjcwNDM2
MC0yNzM2MS0xLWdpdC1zZW5kLWVtYWlsLXNqaXRpbmRhcnNpbmdoQGdtYWlsLmNvbQpUeXBlOiBz
ZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKc2V0IC1lCmdpdCBz
dWJtb2R1bGUgdXBkYXRlIC0taW5pdCBkdGMKIyBMZXQgZG9ja2VyIHRlc3RzIGR1bXAgZW52aXJv
bm1lbnQgaW5mbwpleHBvcnQgU0hPV19FTlY9MQpleHBvcnQgSj0xNgptYWtlIGRvY2tlci10ZXN0
LXF1aWNrQGNlbnRvczYKbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEKbWFrZSBkb2NrZXIt
dGVzdC1idWlsZEBtaW4tZ2xpYgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBi
cmFuY2ggJ3Rlc3QnCmQyMDU5MmMgaHcvcHBjL3NwYXByOiBBZGQgUE9XRVI5IHRvIHBzZXJpZXMg
Y3B1IG1vZGVscwowOWFjM2E5IHRhcmdldC9wcGMvUE9XRVI5OiBBZGQgY3B1X2hhc193b3JrIGZ1
bmN0aW9uIGZvciBQT1dFUjkKMmFlNGFkNSB0YXJnZXQvcHBjL1BPV0VSOTogQWRkIFBPV0VSOSBw
YS1mZWF0dXJlcyBkZWZpbml0aW9uCmEwZThmYWYgdGFyZ2V0L3BwYy9QT1dFUjk6IEFkZCBQT1dF
UjkgbW11IGZhdWx0IGhhbmRsZXIKMjc1NGYxNyB0YXJnZXQvcHBjOiBEb24ndCB1c2UgU0RSMSB3
aGVuIHJ1bm5pbmcgdW5kZXIgYSBQT1dFUjkgY3B1IG1vZGVsCjEzMjE3OTQgdGFyZ2V0L3BwYzog
QWRkIHBhdGJfZW50cnkgdG8gc1BBUFJNYWNoaW5lU3RhdGUKYjE2NTgxNSB0YXJnZXQvcHBjL1BP
V0VSOTogRGlyZWN0IGFsbCBpbnN0ciBhbmQgZGF0YSBzdG9yYWdlIGludGVycnVwdHMgdG8gdGhl
IGh5cHYKZDUxNDJmYSB0YXJnZXQvcHBjL1BPV0VSOTogQWRhcHQgTFBDUiBoYW5kbGluZyBmb3Ig
UE9XRVI5CjkxYWU2ZTQgdGFyZ2V0L3BwYzogRml4IExQQ1IgRFBGRCBtYXNrIGRlZmluZQpmZjJk
YTEwIHRhcmdldC9wcGMvUE9XRVI5OiBBZGQgSVNBdjMuMDAgTU1VIGRlZmluaXRpb24KCj09PSBP
VVRQVVQgQkVHSU4gPT09ClN1Ym1vZHVsZSAnZHRjJyAoZ2l0Oi8vZ2l0LnFlbXUtcHJvamVjdC5v
cmcvZHRjLmdpdCkgcmVnaXN0ZXJlZCBmb3IgcGF0aCAnZHRjJwpmYXRhbDogcmVhZCBlcnJvcjog
Q29ubmVjdGlvbiByZXNldCBieSBwZWVyCkNsb25pbmcgaW50byAnZHRjJy4uLgpDbG9uZSBvZiAn
Z2l0Oi8vZ2l0LnFlbXUtcHJvamVjdC5vcmcvZHRjLmdpdCcgaW50byBzdWJtb2R1bGUgcGF0aCAn
ZHRjJyBmYWlsZWQKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGgg
Y29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQGZyZWVsaXN0cy5vcmc=
