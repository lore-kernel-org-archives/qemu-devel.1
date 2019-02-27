Received: from eggs.gnu.org ([209.51.188.92]:55753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gz1QT-0004Ft-5Y
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gz1QQ-00017e-Hn
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:47:16 -0500
Resent-Message-Id: <E1gz1QQ-00017e-Hn@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gz1QP-00014F-AD
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:47:14 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <155128234984.1544.12247186527656040148@49fa7ef69f7b>
In-Reply-To: <20190227111347.15063-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 27 Feb 2019 07:45:51 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v5] hw/block: better reporting on pflash
 backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: fam@euphon.net, armbru@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDIyNzExMTM0Ny4xNTA2
My0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwMjI3MTExMzQ3LjE1MDYzLTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY1XSBody9ibG9j
azogYmV0dGVyIHJlcG9ydGluZyBvbiBwZmxhc2ggYmFja2luZyBmaWxlIG1pc21hdGNoClR5cGU6
IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBh
cnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNj
OGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcg
YnJhbmNoICd0ZXN0JwoyNzZhZTlhOWEyIGh3L2Jsb2NrOiBiZXR0ZXIgcmVwb3J0aW5nIG9uIHBm
bGFzaCBiYWNraW5nIGZpbGUgbWlzbWF0Y2gKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiAi
KGZvbyopIiBzaG91bGQgYmUgIihmb28gKikiCiM3MDogRklMRTogaHcvYmxvY2svcGZsYXNoX2Nm
aTAxLmM6NzY5OgorICAgICAgICAgICAgICAgIG1lbXNldCgodWludDhfdCopcGZsLT5zdG9yYWdl
ICsgYmFja2luZ19sZW4sIDB4ZmYsIHBhZF9ieXRlcyk7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAg
Y2hhcmFjdGVycwojODI6IEZJTEU6IGh3L2Jsb2NrL3BmbGFzaF9jZmkwMS5jOjc4MToKKyAgICAg
ICAgICAgIHdhcm5fcmVwb3J0KCJkZXZpY2UgbmVlZHMgJSIgUFJJdTY0ICIgYnl0ZXMsIHJlc3Qg
aWdub3JlZCIsIHRvdGFsX2xlbik7Cgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDU4IGxp
bmVzIGNoZWNrZWQKCkNvbW1pdCAyNzZhZTlhOWEyY2EgKGh3L2Jsb2NrOiBiZXR0ZXIgcmVwb3J0
aW5nIG9uIHBmbGFzaCBiYWNraW5nIGZpbGUgbWlzbWF0Y2gpIGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMTkwMjI3MTExMzQ3LjE1MDYzLTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
