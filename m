Received: from eggs.gnu.org ([2001:4830:134:3::10]:39665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dhY2y-00058q-1A
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dhY2u-0006xk-RO
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:22:00 -0400
Resent-Message-Id: <E1dhY2u-0006xk-RO@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dhY2u-0006wt-Jr
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:21:56 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150278889264.78.9910864097228957226@dd743fd916bd>
In-Reply-To: <1502787511-20894-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 15 Aug 2017 02:21:33 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] hw/acpi: Select an node with memory for
 mapping memory hole to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: douly.fnst@cn.fujitsu.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com, david@redhat.com, mst@redhat.com, armbru@redhat.com, dgilbert@redhat.com, imammedo@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMTUw
Mjc4NzUxMS0yMDg5NC0xLWdpdC1zZW5kLWVtYWlsLWRvdWx5LmZuc3RAY24uZnVqaXRzdS5jb20K
U3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gaHcvYWNwaTogU2VsZWN0IGFuIG5vZGUgd2l0
aCBtZW1vcnkgZm9yIG1hcHBpbmcgbWVtb3J5IGhvbGUgdG8KVHlwZTogc2VyaWVzCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0
IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZv
ciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAk
KGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0t
Zm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVu
CiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25l
CgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5
YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20v
cGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8y
MDE3MDgxNTA4NTczMi45Nzk0LTEtbGRva3RvckByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAxNzA4
MTUwODU3MzIuOTc5NC0xLWxkb2t0b3JAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFu
Y2ggJ3Rlc3QnCjhkNGQ1NmJhNTQgaHcvYWNwaTogU2VsZWN0IGFuIG5vZGUgd2l0aCBtZW1vcnkg
Zm9yIG1hcHBpbmcgbWVtb3J5IGhvbGUgdG8KCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5n
IFBBVENIIDEvMTogaHcvYWNwaTogU2VsZWN0IGFuIG5vZGUgd2l0aCBtZW1vcnkgZm9yIG1hcHBp
bmcgbWVtb3J5IGhvbGUgdG8uLi4KRVJST1I6IHRyYWlsaW5nIHN0YXRlbWVudHMgc2hvdWxkIGJl
IG9uIG5leHQgbGluZQojODg6IEZJTEU6IGh3L2kzODYvYWNwaS1idWlsZC5jOjI0MDU6CisgICAg
Zm9yIChub2RlID0gMDsKWy4uLl0KKyAgICAgICAgICAgIG5vZGUrKyk7Cgp0b3RhbDogMSBlcnJv
cnMsIDAgd2FybmluZ3MsIDk5IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
