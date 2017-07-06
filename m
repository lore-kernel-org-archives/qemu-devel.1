Received: from eggs.gnu.org ([2001:4830:134:3::10]:35639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGXZ-0002pN-S3
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGXV-0008BI-A5
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:50:33 -0400
Resent-Message-Id: <E1dTGXV-0008BI-A5@eggs.gnu.org>
In-Reply-To: <20170629132749.997-1-pbonzini@redhat.com>
Message-ID: <149938502010.27.5512931677882909534@7a482c8a7db2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 6 Jul 2017 16:50:20 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 00/11] Block layer thread-safety, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2MiAwMC8xMV0gQmxvY2sgbGF5ZXIgdGhyZWFkLXNhZmV0eSwgcGFydCAy
Ck1lc3NhZ2UtaWQ6IDIwMTcwNjI5MTMyNzQ5Ljk5Ny0xLXBib256aW5pQHJlZGhhdC5jb20KVHlw
ZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJh
c2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9
MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJl
dmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcg
UEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBp
ZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQog
ICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
ClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKZmF0YWw6
IENhbm5vdCB1cGRhdGUgcGF0aHMgYW5kIHN3aXRjaCB0byBicmFuY2ggJ3Rlc3QnIGF0IHRoZSBz
YW1lIHRpbWUuCkRpZCB5b3UgaW50ZW5kIHRvIGNoZWNrb3V0ICdvcmlnaW4vcGF0Y2hldy8yMDE3
MDYyOTEzMjc0OS45OTctMS1wYm9uemluaUByZWRoYXQuY29tJyB3aGljaCBjYW4gbm90IGJlIHJl
c29sdmVkIGFzIGNvbW1pdD8KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZp
bGUgIi9ob21lL2ZhbS9iaW4vcGF0Y2hldyIsIGxpbmUgNDQwLCBpbiB0ZXN0X29uZQogICAgZ2l0
X2Nsb25lX3JlcG8oY2xvbmUsIHJbInJlcG8iXSwgclsiaGVhZCJdLCBsb2dmKQogIEZpbGUgIi9o
b21lL2ZhbS9iaW4vcGF0Y2hldyIsIGxpbmUgNTMsIGluIGdpdF9jbG9uZV9yZXBvCiAgICBjd2Q9
Y2xvbmUpCiAgRmlsZSAiL3Vzci9saWI2NC9weXRob24zLjUvc3VicHJvY2Vzcy5weSIsIGxpbmUg
MjcxLCBpbiBjaGVja19jYWxsCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwg
Y21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydnaXQnLCAnY2hl
Y2tvdXQnLCAnb3JpZ2luL3BhdGNoZXcvMjAxNzA2MjkxMzI3NDkuOTk3LTEtcGJvbnppbmlAcmVk
aGF0LmNvbScsICctYicsICd0ZXN0J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDEy
OAoKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEBmcmVlbGlzdHMub3Jn
