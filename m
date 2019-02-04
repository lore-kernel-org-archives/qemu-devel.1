Received: from eggs.gnu.org ([209.51.188.92]:38387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gqhoC-0003vt-9H
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gqhoB-0005oi-BU
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:13:24 -0500
Resent-Message-Id: <E1gqhoB-0005oi-BU@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gqhoA-0005nc-6x
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:13:23 -0500
Message-ID: <154930038693.29184.3120782428001056058@ebba9967afc0>
In-Reply-To: <1549299863-42415-1-git-send-email-pbonzini@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 4 Feb 2019 09:13:07 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] docker: fix test-mingw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTQ5Mjk5ODYzLTQyNDE1LTEt
Z2l0LXNlbmQtZW1haWwtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gZG9j
a2VyOiBmaXggdGVzdC1taW5ndwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMTU0OTI5OTg2My00
MjQxNS0xLWdpdC1zZW5kLWVtYWlsLXBib256aW5pQHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGlt
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1h
aWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTlj
MjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9w
YXRjaGV3LXByb2plY3QvcWVtdQogICAzMzVkYmI1ZGUxLi43NzNjNGE2MjI4ICBtYXN0ZXIgICAg
IC0+IG1hc3RlcgogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzE1NDkyOTk4NjMt
NDI0MTUtMS1naXQtc2VuZC1lbWFpbC1wYm9uemluaUByZWRoYXQuY29tIC0+IHBhdGNoZXcvMTU0
OTI5OTg2My00MjQxNS0xLWdpdC1zZW5kLWVtYWlsLXBib256aW5pQHJlZGhhdC5jb20KU3dpdGNo
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KY2hlY2twYXRj
aC5wbDogbm8gcmV2aXNpb25zIHJldHVybmVkIGZvciByZXZsaXN0ICcxJwo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAyNTUKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NDkyOTk4NjMtNDI0MTUt
MS1naXQtc2VuZC1lbWFpbC1wYm9uemluaUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t
