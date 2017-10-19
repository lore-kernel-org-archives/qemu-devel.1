Received: from eggs.gnu.org ([2001:4830:134:3::10]:55481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e5GW0-00036V-RU
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e5GVw-000764-32
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:30:00 -0400
Resent-Message-Id: <E1e5GVw-000764-32@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e5GVv-00075s-Rj
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:29:56 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150844135941.413.2688233951724465156@b58463cdfd5f>
In-Reply-To: <1508417485-31911-1-git-send-email-gabriel291075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 19 Oct 2017 12:29:19 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] arm: Adding makefile for Kinetis K64
 MK64FN1M0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gabriel291075@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MDg0MTc0ODUtMzE5MTEtMS1naXQtc2VuZC1lbWFpbC1nYWJyaWVsMjkxMDc1
QGdtYWlsLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYyXSBhcm06IEFkZGluZyBt
YWtlZmlsZSBmb3IgS2luZXRpcyBLNjQgTUs2NEZOMU0wCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUg
JEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
bGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQo
Z2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRz
OyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAt
LWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwg
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVk
PTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQK
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFk
ZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwplZDg5MGE4
NzM0IGFybTogQWRkaW5nIG1ha2VmaWxlIGZvciBLaW5ldGlzIEs2NCBNSzY0Rk4xTTAKCj09PSBP
VVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogYXJtOiBBZGRpbmcgbWFrZWZpbGUg
Zm9yIEtpbmV0aXMgSzY0IE1LNjRGTjFNMC4uLgpFUlJPUjogZG8gbm90IHNldCBleGVjdXRlIHBl
cm1pc3Npb25zIGZvciBzb3VyY2UgZmlsZXMKIzI1OiBGSUxFOiBody9hcm0vTWFrZWZpbGUub2Jq
cwoKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzM2OiBGSUxFOiBody9hcm0vTWFrZWZpbGUu
b2JqczoyNjoKK15JJAoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA3IGxpbmVzIGNoZWNr
ZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5E
ID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
