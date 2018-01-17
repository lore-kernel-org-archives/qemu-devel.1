Received: from eggs.gnu.org ([2001:4830:134:3::10]:54691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ebhYJ-000595-6W
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ebhYG-0003ul-25
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:27 -0500
Resent-Message-Id: <E1ebhYG-0003ul-25@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ebhYF-0003tt-Ou
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:23 -0500
In-Reply-To: <20180116142316.30486-1-pbonzini@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151616908700.575.7368076470257215397@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 16 Jan 2018 22:04:47 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2 0/4] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgZG9ja2VyLWJ1aWxkQG1pbi1nbGliIGJ1aWxkIHRlc3Qu
IFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cu
IElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNl
IGl0CmxvY2FsbHkuCgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxODAxMTYxNDIzMTYuMzA0
ODYtMS1wYm9uemluaUByZWRoYXQuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjIg
MC80XSBjb3JvdXRpbmUtbG9jazogcG9seW1vcnBoaWMgQ29RdWV1ZQoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaApzZXQgLWUKZ2l0IHN1Ym1vZHVsZSB1cGRhdGUgLS1pbml0
IGR0YwojIExldCBkb2NrZXIgdGVzdHMgZHVtcCBlbnZpcm9ubWVudCBpbmZvCmV4cG9ydCBTSE9X
X0VOVj0xCmV4cG9ydCBKPTgKdGltZSBtYWtlIGRvY2tlci10ZXN0LWJ1aWxkQG1pbi1nbGliCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKY2ViODU3OWI3
MSBjdXJsOiBjb252ZXJ0IHRvIENvUXVldWUKZGViOGYzNGI3NCBjb3JvdXRpbmUtbG9jazogbWFr
ZSBxZW11X2NvX2VudGVyX25leHQgdGhyZWFkLXNhZmUKNWEzMGYzNmZiYSBjb3JvdXRpbmUtbG9j
azogY29udmVydCBDb1F1ZXVlIHRvIHVzZSBRZW11TG9ja2FibGUKMjE1YjRlZjAzZCBsb2NrYWJs
ZTogYWRkIFFlbXVMb2NrYWJsZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KU3VibW9kdWxlICdkdGMn
IChnaXQ6Ly9naXQucWVtdS1wcm9qZWN0Lm9yZy9kdGMuZ2l0KSByZWdpc3RlcmVkIGZvciBwYXRo
ICdkdGMnCkNsb25pbmcgaW50byAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW0wM3Q5Y3df
L3NyYy9kdGMnLi4uClN1Ym1vZHVsZSBwYXRoICdkdGMnOiBjaGVja2VkIG91dCAnZTU0Mzg4MDE1
YWYxZmI0YmYwNGQwYmNhOTljYWJhMTA3NGQ5Y2M0MicKICBCVUlMRCAgIG1pbi1nbGliClRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2Nr
ZXIucHkiLCBsaW5lIDQwNywgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKICBGaWxl
ICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDQwNCwgaW4gbWFpbgogICAgcmV0dXJu
IGFyZ3MuY21kb2JqLnJ1bihhcmdzLCBhcmd2KQogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tl
ci5weSIsIGxpbmUgMjg3LCBpbiBydW4KICAgIGRrciA9IERvY2tlcigpCiAgRmlsZSAiLi90ZXN0
cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSAxMzMsIGluIF9faW5pdF9fCiAgICBzZWxmLl9jb21t
YW5kID0gX2d1ZXNzX2RvY2tlcl9jb21tYW5kKCkKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2Nr
ZXIucHkiLCBsaW5lIDU4LCBpbiBfZ3Vlc3NfZG9ja2VyX2NvbW1hbmQKICAgIGNvbW1hbmRzX3R4
dCkKRXhjZXB0aW9uOiBDYW5ub3QgZmluZCB3b3JraW5nIGRvY2tlciBjb21tYW5kLiBUcmllZDoK
ICBkb2NrZXIKICBzdWRvIC1uIGRvY2tlcgptYWtlOiAqKiogW3Rlc3RzL2RvY2tlci9NYWtlZmls
ZS5pbmNsdWRlOjM3OiBkb2NrZXItaW1hZ2UtbWluLWdsaWJdIEVycm9yIDEKCnJlYWwJMG0wLjY0
OXMKdXNlcgkwbTAuMDQ5cwpzeXMJMG0wLjAyOXMKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMgoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
