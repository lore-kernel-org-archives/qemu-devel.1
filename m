Received: from eggs.gnu.org ([2001:4830:134:3::10]:60828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fWCZh-0002yY-NH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fWCZe-0006G3-E5
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:17:25 -0400
Resent-Message-Id: <E1fWCZe-0006G3-E5@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fWCZe-0006Di-4J
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:17:22 -0400
In-Reply-To: <20180622003140.164613-1-mst@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152963649940.840.12519409178336343639@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 21 Jun 2018 20:01:40 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v4 0/2] kvm: limited x86 CPU power
 management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, ehabkost@redhat.com, kvm@vger.kernel.org, rth@twiddle.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNjIyMDAzMTQwLjE2NDYxMy0xLW1zdEByZWRoYXQuY29tClN1YmplY3Q6
IFtRZW11LWRldmVsXSBbUEFUQ0ggdjQgMC8yXSBrdm06IGxpbWl0ZWQgeDg2IENQVSBwb3dlciBt
YW5hZ2VtZW50Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJh
c2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9
MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4u
KSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90
YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cg
JGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07
IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkp
CmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRj
aGV3LzIwMTgwNjIxMjIzOTQ2LjIwNzM4LTEtY2xnQGthb2Qub3JnIC0+IHBhdGNoZXcvMjAxODA2
MjEyMjM5NDYuMjA3MzgtMS1jbGdAa2FvZC5vcmcKICogW25ldyB0YWddICAgICAgICAgICAgICAg
cGF0Y2hldy8yMDE4MDYyMjAwMzE0MC4xNjQ2MTMtMS1tc3RAcmVkaGF0LmNvbSAtPiBwYXRjaGV3
LzIwMTgwNjIyMDAzMTQwLjE2NDYxMy0xLW1zdEByZWRoYXQuY29tCiAqIFtuZXcgdGFnXSAgICAg
ICAgICAgICAgIHBhdGNoZXcvMjAxODA2MjIwMDQ0MzUuMTAyOTEtMS1mNGJ1Z0BhbXNhdC5vcmcg
LT4gcGF0Y2hldy8yMDE4MDYyMjAwNDQzNS4xMDI5MS0xLWY0YnVnQGFtc2F0Lm9yZwpTd2l0Y2hl
ZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmNlMWJkYzMxYWYgaTM4Ni9jcHU6IG1ha2UgLWNwdSBo
b3N0IHN1cHBvcnQgbW9uaXRvci9td2FpdAo1NzdmMjU4YjE1IGt2bTogc3VwcG9ydCAtb3ZlcmNv
bW1pdCBjcHUtcG09b258b2ZmCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAx
LzI6IGt2bTogc3VwcG9ydCAtb3ZlcmNvbW1pdCBjcHUtcG09b258b2ZmLi4uCkVSUk9SOiBkbyBu
b3QgaW5pdGlhbGlzZSBnbG9iYWxzIHRvIDAgb3IgTlVMTAojMTAzOiBGSUxFOiB2bC5jOjE0NToK
K2Jvb2wgZW5hYmxlX2NwdV9wbSA9IGZhbHNlOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCAxMTAgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKQ2hlY2tpbmcgUEFUQ0ggMi8yOiBpMzg2L2NwdTogbWFrZSAtY3B1IGhvc3Qgc3VwcG9ydCBt
b25pdG9yL213YWl0Li4uCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t
