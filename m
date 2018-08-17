Received: from eggs.gnu.org ([2001:4830:134:3::10]:34099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fqbh1-00009d-2N
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fqbdW-0003HU-2c
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:05:42 -0400
Resent-Message-Id: <E1fqbdW-0003HU-2c@eggs.gnu.org>
In-Reply-To: <1534422540-18815-1-git-send-email-hans-erik.floryd@rt-labs.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153450031408.22457.16041227636962253331@502c9da6d61e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 17 Aug 2018 03:05:15 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] sdhci: add i.MX SD Stable Clock bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hans-erik.floryd@rt-labs.com
Cc: famz@redhat.com, qemu-trivial@nongnu.org, f4bug@amsat.org, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MzQ0MjI1NDAtMTg4MTUtMS1naXQtc2VuZC1lbWFpbC1oYW5zLWVyaWsuZmxv
cnlkQHJ0LWxhYnMuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHNkaGNpOiBhZGQg
aS5NWCBTRCBTdGFibGUgQ2xvY2sgYml0Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8
IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0t
cmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2lu
ZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAg
IGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZp
CiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmVlZWE3ODNiNzIgc2RoY2k6IGFkZCBpLk1YIFNE
IFN0YWJsZSBDbG9jayBiaXQKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEv
MTogc2RoY2k6IGFkZCBpLk1YIFNEIFN0YWJsZSBDbG9jayBiaXQuLi4KRVJST1I6IHN1c3BlY3Qg
Y29kZSBpbmRlbnQgZm9yIGNvbmRpdGlvbmFsIHN0YXRlbWVudHMgKDcsIDEwKQojMzQ6IEZJTEU6
IGh3L3NkL3NkaGNpLmM6MTY1NzoKKyAgICAgICBpZiAocy0+Y2xrY29uICYgU0RIQ19DTE9DS19J
TlRfU1RBQkxFKQorICAgICAgICAgIHJldCB8PSBFU0RIQ19QUk5TVFNfU0RTVEI7CgpFUlJPUjog
YnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiMz
NDogRklMRTogaHcvc2Qvc2RoY2kuYzoxNjU3OgorICAgICAgIGlmIChzLT5jbGtjb24gJiBTREhD
X0NMT0NLX0lOVF9TVEFCTEUpClsuLi5dCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDE5
IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2
aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0
aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09
PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t
