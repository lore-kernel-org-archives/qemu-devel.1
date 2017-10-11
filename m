Received: from eggs.gnu.org ([2001:4830:134:3::10]:51602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e29Jt-000513-JW
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 01:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e29Jq-0004CT-BA
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 01:12:37 -0400
Resent-Message-Id: <E1e29Jq-0004CT-BA@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e29Jq-00049l-2p
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 01:12:34 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150769872707.288.14640370876066682590@b58463cdfd5f>
In-Reply-To: <1507696406-11168-1-git-send-email-jiang.biao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 10 Oct 2017 22:12:07 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] checkpatch: replace ERROR with WARN for
 extern checking.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiang.biao2@zte.com.cn
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, zhong.weidong@zte.com.cn

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MDc2OTY0MDYtMTExNjgtMS1naXQtc2VuZC1lbWFpbC1qaWFuZy5iaWFvMkB6
dGUuY29tLmNuClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGNoZWNrcGF0Y2g6IHJlcGxh
Y2UgRVJST1Igd2l0aCBXQVJOIGZvciBleHRlcm4gY2hlY2tpbmcuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9u
ZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1p
dHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRj
b21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cg
LW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVt
YWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAg
ZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRm
YWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo1
YThlODE1ZTc4IGNoZWNrcGF0Y2g6IHJlcGxhY2UgRVJST1Igd2l0aCBXQVJOIGZvciBleHRlcm4g
Y2hlY2tpbmcuCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IGNoZWNr
cGF0Y2g6IHJlcGxhY2UgRVJST1Igd2l0aCBXQVJOIGZvciBleHRlcm4gY2hlY2tpbmcuLi4uCkVS
Uk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMjU6IEZJTEU6IHNjcmlwdHMvY2hlY2twYXRj
aC5wbDoyNTUwOgorCQkJCVdBUk4oImV4dGVybnMgc2hvdWxkIGJlIGF2b2lkZWQgaW4gLmMgZmls
ZXNcbiIgLiAgJGhlcmVjdXJyKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMz
NDogRklMRTogc2NyaXB0cy9jaGVja3BhdGNoLnBsOjI1NjA6CisJCQlXQVJOKCJleHRlcm5zIHNo
b3VsZCBiZSBhdm9pZGVkIGluIC5jIGZpbGVzXG4iIC4gICRoZXJlY3Vycik7Cgp0b3RhbDogMSBl
cnJvcnMsIDEgd2FybmluZ3MsIDE2IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxl
IHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFs
c2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRD
SCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
