Received: from eggs.gnu.org ([2001:4830:134:3::10]:49961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ciSrq-00052R-3g
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ciSrl-0000vP-IH
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:30:02 -0500
Resent-Message-Id: <E1ciSrl-0000vP-IH@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ciSrl-0000v9-Aw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:29:57 -0500
In-Reply-To: <20170227201456.31814-1-berrange@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148823093151.186.12396350889629389667@0e2666bad730>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 27 Feb 2017 13:28:52 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] io: ignore case when matching websockets
 HTTP headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, den@openvz.org, anton.nefedov@virtuozzo.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzAyMjcyMDE0NTYuMzE4MTQtMS1iZXJyYW5nZUByZWRoYXQuY29tClR5cGU6IHNlcmllcwpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBpbzogaWdub3JlIGNhc2Ugd2hlbiBtYXRjaGluZyB3
ZWJzb2NrZXRzIEhUVFAgaGVhZGVycwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3
YyAtbCkKZmFpbGVkPTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpj
b21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBp
biAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQg
bG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1h
dD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAg
ICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhp
dCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZm
ODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNo
ZXctcHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvY292ZXIuMTQ4ODIy
MDk3MC5naXQuamNvZHlAcmVkaGF0LmNvbSAtPiBwYXRjaGV3L2NvdmVyLjE0ODgyMjA5NzAuZ2l0
Lmpjb2R5QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiOTQxMTcz
IGlvOiBpZ25vcmUgY2FzZSB3aGVuIG1hdGNoaW5nIHdlYnNvY2tldHMgSFRUUCBoZWFkZXJzCgo9
PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGlvOiBpZ25vcmUgY2FzZSB3
aGVuIG1hdGNoaW5nIHdlYnNvY2tldHMgSFRUUCBoZWFkZXJzLi4uCkVSUk9SOiBsaW5lIG92ZXIg
OTAgY2hhcmFjdGVycwojNTA6IEZJTEU6IGlvL2NoYW5uZWwtd2Vic29jay5jOjI1ODoKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoYW5kc2hha2VfZW5kIC0g
KGNoYXIgKilpb2MtPmVuY2lucHV0LmJ1ZmZlciwKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5n
cywgMzQgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZy
ZWVsaXN0cy5vcmc=
