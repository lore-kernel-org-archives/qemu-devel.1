Received: from eggs.gnu.org ([2001:4830:134:3::10]:34815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cKRa4-0002h6-QS
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 10:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cKRa1-0005jL-Bq
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 10:16:24 -0500
Resent-Message-Id: <E1cKRa1-0005jL-Bq@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cKRa1-0005i0-3l
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 10:16:21 -0500
In-Reply-To: <20161223151253.21338-1-msuchanek@suse.de>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148250617624.127.8347420154284875205@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 23 Dec 2016 07:16:17 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC PATCH] Fix pasting into serial console in GTK
 ui
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: msuchanek@suse.de
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTYxMjIzMTUxMjUzLjIxMzM4LTEtbXN1Y2hhbmVrQHN1c2UuZGUKU3ViamVj
dDogW1FlbXUtZGV2ZWxdIFtSRkMgUEFUQ0hdIEZpeCBwYXN0aW5nIGludG8gc2VyaWFsIGNvbnNv
bGUgaW4gR1RLIHVpCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNF
PWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWls
ZWQ9MAoKIyBVc2VmdWwgZ2l0IG9wdGlvbnMKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
bGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQo
Z2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRz
OyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAt
LWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwg
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVk
PTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQK
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFk
ZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0
L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE2MTIyMzE1MTI1My4yMTMzOC0x
LW1zdWNoYW5la0BzdXNlLmRlIC0+IHBhdGNoZXcvMjAxNjEyMjMxNTEyNTMuMjEzMzgtMS1tc3Vj
aGFuZWtAc3VzZS5kZQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjc0ZTk2NDYgRml4
IHBhc3RpbmcgaW50byBzZXJpYWwgY29uc29sZSBpbiBHVEsgdWkKCj09PSBPVVRQVVQgQkVHSU4g
PT09CkNoZWNraW5nIFBBVENIIDEvMTogRml4IHBhc3RpbmcgaW50byBzZXJpYWwgY29uc29sZSBp
biBHVEsgdWkuLi4KRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYWZ0ZXIgdGhhdCBvcGVuIHBhcmVu
dGhlc2lzICcoJwojNTE6IEZJTEU6IHVpL2d0ay5jOjE3NTU6CisgICAgaWYgKCBzaXplID4gbGVu
KSB7CgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMg
c3RhdGVtZW50CiM1NzogRklMRTogdWkvZ3RrLmM6MTc2MToKKyAgICBpZiAoaW5idWYtPnNlbnQg
PCBpbmJ1Zi0+c2l6ZSkKWy4uLl0KKyAgICBlbHNlIHsKWy4uLl0KCkVSUk9SOiBicmFjZXMge30g
YXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzc0OiBGSUxFOiB1
aS9ndGsuYzoxNzc4OgorICAgICAgICBpZiAoIWluYnVmKQpbLi4uXQoKdG90YWw6IDMgZXJyb3Jz
LCAwIHdhcm5pbmdzLCA3MCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
