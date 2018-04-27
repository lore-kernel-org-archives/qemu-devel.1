Received: from eggs.gnu.org ([2001:4830:134:3::10]:60066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fCBpT-0000n4-2L
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fCBpO-0001t8-GO
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:26:59 -0400
Resent-Message-Id: <E1fCBpO-0001t8-GO@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fCBpO-0001j6-6O
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:26:54 -0400
In-Reply-To: <20180427100244.14258-1-zyimin@linux.ibm.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152482562980.2358.13648855475561777522@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 27 Apr 2018 03:40:30 -0700 (PDT)
Subject: Re: [Qemu-devel] [RFC PATCH 0/1] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zyimin@linux.ibm.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNDI3MTAwMjQ0LjE0MjU4LTEtenlpbWluQGxpbnV4LmlibS5jb20KU3Vi
amVjdDogW1FlbXUtZGV2ZWxdIFtSRkMgUEFUQ0ggMC8xXSBzMzkweC9wY2k6IGFkZCBjb21tb24g
Zm1iCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0x
CnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9y
IGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQo
Z2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1m
b3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4K
ICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUK
CmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTlj
MjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9w
YXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIw
MTgwNDI3MTAwMjQ0LjE0MjU4LTEtenlpbWluQGxpbnV4LmlibS5jb20gLT4gcGF0Y2hldy8yMDE4
MDQyNzEwMDI0NC4xNDI1OC0xLXp5aW1pbkBsaW51eC5pYm0uY29tClN3aXRjaGVkIHRvIGEgbmV3
IGJyYW5jaCAndGVzdCcKNzJlMmQzZjMwYyBzMzkweC9wY2k6IGFkZCBjb21tb24gZm1iCgo9PT0g
T1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHMzOTB4L3BjaTogYWRkIGNvbW1v
biBmbWIuLi4KRVJST1I6IHNwYWNlcyBwcm9oaWJpdGVkIGFyb3VuZCB0aGF0ICc6JyAoY3R4Old4
VykKIzUwOiBGSUxFOiBody9zMzkweC9zMzkwLXBjaS1idXMuaDoyOTM6CisgICAgdWludDMyX3Qg
Zm9ybWF0ICA6IDg7CiAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHByb2hp
Yml0ZWQgYXJvdW5kIHRoYXQgJzonIChjdHg6V3hXKQojNTE6IEZJTEU6IGh3L3MzOTB4L3MzOTAt
cGNpLWJ1cy5oOjI5NDoKKyAgICB1aW50MzJfdCBmbXRfaW5kIDogMjQ7CiAgICAgICAgICAgICAg
ICAgICAgICBeCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMxODU6
IEZJTEU6IGh3L3MzOTB4L3MzOTAtcGNpLWluc3QuYzoxMDg0OgorXkleSV5JICAgICAgICAgICAg
ICAgICAgICBmbWJfdXBkYXRlLCBwYmRldik7JAoKdG90YWw6IDMgZXJyb3JzLCAwIHdhcm5pbmdz
LCAxNTggbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=
