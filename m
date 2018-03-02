Received: from eggs.gnu.org ([2001:4830:134:3::10]:38491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eriCp-00026f-CO
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eriCm-0000zO-76
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:46:27 -0500
Resent-Message-Id: <E1eriCm-0000zO-76@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eriCl-0000xk-UZ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:46:24 -0500
In-Reply-To: <1519987399-19160-1-git-send-email-jusual@mail.ru>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151998755913.1314.1200286372629865537@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 2 Mar 2018 02:46:00 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: add a warning for
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
c3NhZ2UtaWQ6IDE1MTk5ODczOTktMTkxNjAtMS1naXQtc2VuZC1lbWFpbC1qdXN1YWxAbWFpbC5y
dQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYyXSBjaGVja3BhdGNoOiBhZGQgYSB3YXJu
aW5nIGZvciBiYXNlbmFtZS9kaXJuYW1lCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8
IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0t
cmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2lu
ZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAg
IGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZp
CiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9t
IGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogICAwZGM4YWU1ZThlLi40
MjdjYmM3ZTQxICBtYXN0ZXIgICAgIC0+IG1hc3RlcgogKiBbbmV3IHRhZ10gICAgICAgICAgICAg
ICBwYXRjaGV3LzE1MTk5ODczOTktMTkxNjAtMS1naXQtc2VuZC1lbWFpbC1qdXN1YWxAbWFpbC5y
dSAtPiBwYXRjaGV3LzE1MTk5ODczOTktMTkxNjAtMS1naXQtc2VuZC1lbWFpbC1qdXN1YWxAbWFp
bC5ydQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmMxYmU1YzM4NTQgY2hlY2twYXRj
aDogYWRkIGEgd2FybmluZyBmb3IgYmFzZW5hbWUvZGlybmFtZQoKPT09IE9VVFBVVCBCRUdJTiA9
PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBjaGVja3BhdGNoOiBhZGQgYSB3YXJuaW5nIGZvciBiYXNl
bmFtZS9kaXJuYW1lLi4uCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMjI6IEZJTEU6
IHNjcmlwdHMvY2hlY2twYXRjaC5wbDoyNTg5OgorCQkJV0FSTigiY29uc2lkZXIgdXNpbmcgZ19w
YXRoX2dldF8kMSgpIGluIHByZWZlcmVuY2UgdG8gZ19zdHJkdXAoJDEoKSlcbiIgLiAkaGVyZWN1
cnIpOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMSBsaW5lcyBjaGVja2VkCgpZb3Vy
IHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
