Received: from eggs.gnu.org ([2001:4830:134:3::10]:51390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fjTgI-0000f9-9U
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 14:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fjTgD-0004aH-HV
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 14:11:06 -0400
Resent-Message-Id: <E1fjTgD-0004aH-HV@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fjTgD-0004YO-6K
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 14:11:01 -0400
In-Reply-To: <20180726132947.28538-1-alex.bennee@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153279872224.5387.1816141035966333544@502c9da6d61e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 28 Jul 2018 10:25:23 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v1 for 3.0 0/2] fix for bug 1783362
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNzI2MTMyOTQ3LjI4NTM4LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZwpT
dWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYxIGZvciAzLjAgMC8yXSBmaXggZm9yIGJ1ZyAx
NzgzMzYyCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UK
bj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIK
Zm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6
ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMg
LS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRo
ZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRv
bmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1
YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFu
Y2ggJ3Rlc3QnCjAyNGQyYjNkYTMgdGVzdHM6IGFkZCBjaGVja19pbnZhbGlkX21hcHMgdG8gdGVz
dC1tbWFwCmExMzNiNGE4YjUgbGludXgtdXNlci9tbWFwLmM6IGhhbmRsZSBsZW4gPSAwIG1hcHMg
Y29ycmVjdGx5Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzI6IGxpbnV4
LXVzZXIvbW1hcC5jOiBoYW5kbGUgbGVuID0gMCBtYXBzIGNvcnJlY3RseS4uLgpDaGVja2luZyBQ
QVRDSCAyLzI6IHRlc3RzOiBhZGQgY2hlY2tfaW52YWxpZF9tYXBzIHRvIHRlc3QtbW1hcC4uLgpF
UlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM1NDogRklMRTogdGVzdHMv
dGNnL211bHRpYXJjaC90ZXN0LW1tYXAuYzo0OTI6CiteSWNoZWNrX2ludmFsaWRfbW1hcHMoKTsk
Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDM0IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0
Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
