Received: from eggs.gnu.org ([2001:4830:134:3::10]:36233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1erg1C-0000f7-6z
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1erg19-0005PS-0g
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:26:18 -0500
Resent-Message-Id: <E1erg19-0005PS-0g@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1erg18-0005Ot-Om
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:26:14 -0500
In-Reply-To: <1519978965-16865-1-git-send-email-jusual@mail.ru>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151997915724.1311.11669146562378490878@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 2 Mar 2018 00:25:58 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] checkpatch: add a warning for
 basename/dirname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@gmail.com, jim@groklearning.com, cohuck@redhat.com, joel@jms.id.au, marcandre.lureau@redhat.com, pbonzini@redhat.com, jusual@mail.ru

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MTk5Nzg5NjUtMTY4NjUtMS1naXQtc2VuZC1lbWFpbC1qdXN1YWxAbWFpbC5y
dQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBjaGVja3BhdGNoOiBhZGQgYSB3YXJuaW5n
IGZvciBiYXNlbmFtZS9kaXJuYW1lCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9i
YXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdj
IC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2
ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQ
QVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlm
ICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAt
LW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAg
ICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0
dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAg
ICAgICAgICBwYXRjaGV3LzE1MTk5Nzg5NjUtMTY4NjUtMS1naXQtc2VuZC1lbWFpbC1qdXN1YWxA
bWFpbC5ydSAtPiBwYXRjaGV3LzE1MTk5Nzg5NjUtMTY4NjUtMS1naXQtc2VuZC1lbWFpbC1qdXN1
YWxAbWFpbC5ydQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmQ1Yjg1YTlhZGIgY2hl
Y2twYXRjaDogYWRkIGEgd2FybmluZyBmb3IgYmFzZW5hbWUvZGlybmFtZQoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBjaGVja3BhdGNoOiBhZGQgYSB3YXJuaW5nIGZv
ciBiYXNlbmFtZS9kaXJuYW1lLi4uCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMTk6
IEZJTEU6IHNjcmlwdHMvY2hlY2twYXRjaC5wbDoyNTg5OgorCQkJV0FSTigiY29uc2lkZXIgdXNp
bmcgZ19wYXRoX2dldF8kMSBpbiBwcmVmZXJlbmNlIHRvICQxKDMpXG4iIC4gJGhlcmVjdXJyKTsK
CnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTEgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRj
aCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
