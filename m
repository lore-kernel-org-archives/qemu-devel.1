Received: from eggs.gnu.org ([2001:4830:134:3::10]:58488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cUtbl-00049e-TS
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 06:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cUtbi-0001tC-Q1
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 06:13:21 -0500
Resent-Message-Id: <E1cUtbi-0001tC-Q1@eggs.gnu.org>
Message-ID: <148499718699.28.5734417610995647444@b042e9bf0dd0>
In-Reply-To: <20170121105949.15466-1-jazeltq@gmail.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 21 Jan 2017 03:13:08 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC v3] RBD: Add support readv,writev for rbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jazeltq@gmail.com
Cc: famz@redhat.com, jdurgin@redhat.com, jcody@redhat.com, jdillama@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, tianqing@unitedstack.com, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtSRkMgdjNdIFJCRDogQWRkIHN1cHBvcnQgcmVhZHYsd3JpdGV2IGZvciByYmQKTWVz
c2FnZS1pZDogMjAxNzAxMjExMDU5NDkuMTU0NjYtMS1qYXplbHRxQGdtYWlsLmNvbQpUeXBlOiBz
ZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpu
PTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgoj
IFVzZWZ1bCBnaXQgb3B0aW9ucwpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9n
IC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAg
ICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0
PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAg
ICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmY4MjY1ODMgUkJEOiBB
ZGQgc3VwcG9ydCByZWFkdix3cml0ZXYgZm9yIHJiZAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hl
Y2tpbmcgUEFUQ0ggMS8xOiBSQkQ6IEFkZCBzdXBwb3J0IHJlYWR2LHdyaXRldiBmb3IgcmJkLi4u
CkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiM4MTogRklMRTogYmxvY2svcmJkLmM6Njc5Ogor
ICAgIGNoYXIgKiBidWYgPSBOVUxMOyAkCgpFUlJPUjogImZvbyAqIGJhciIgc2hvdWxkIGJlICJm
b28gKmJhciIKIzgxOiBGSUxFOiBibG9jay9yYmQuYzo2Nzk6CisgICAgY2hhciAqIGJ1ZiA9IE5V
TEw7IAoKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzkxOiBGSUxFOiBibG9jay9yYmQuYzo2
ODk6CisgICAgJAoKdG90YWw6IDMgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMjYgbGluZXMgY2hlY2tl
ZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
