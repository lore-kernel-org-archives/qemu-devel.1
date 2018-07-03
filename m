Received: from eggs.gnu.org ([2001:4830:134:3::10]:44299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1faIPM-0001nN-S6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1faIPJ-0003Yh-O5
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:19:40 -0400
Resent-Message-Id: <E1faIPJ-0003Yh-O5@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1faIPJ-0003YR-F1
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:19:37 -0400
In-Reply-To: <20180702202415.GA12440@computer>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153061316393.732.4268977752063009597@946cad8fd14e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 3 Jul 2018 03:19:24 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] module: Use QEMU_MODULE_PATH as a search
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: decatf@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.comfamz@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNzAyMjAyNDE1LkdBMTI0NDBAY29tcHV0ZXIKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gbW9kdWxlOiBVc2UgUUVNVV9NT0RVTEVfUEFUSCBhcyBhIHNlYXJjaCBw
YXRoCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0x
CnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9y
IGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQo
Z2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1m
b3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4K
ICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUK
CmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTlj
MjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2gg
J3Rlc3QnCjc2NDNkZDJiNGUgbW9kdWxlOiBVc2UgUUVNVV9NT0RVTEVfUEFUSCBhcyBhIHNlYXJj
aCBwYXRoCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IG1vZHVsZTog
VXNlIFFFTVVfTU9EVUxFX1BBVEggYXMgYSBzZWFyY2ggcGF0aC4uLgpFUlJPUjogYnJhY2VzIHt9
IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiM2MzogRklMRTog
dXRpbC9tb2R1bGUuYzoxOTE6CisgICAgaWYgKHNlYXJjaF9wYXRoICE9IE5VTEwpClsuLi5dCgp0
b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDQzIGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2gg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
