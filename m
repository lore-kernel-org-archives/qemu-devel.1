Received: from eggs.gnu.org ([2001:4830:134:3::10]:46517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fIEG9-0004Du-AF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fIEG5-0004Df-77
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:15:29 -0400
Resent-Message-Id: <E1fIEG5-0004Df-77@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fIEG4-0004DM-SN
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:15:25 -0400
In-Reply-To: <20180514141218.28438-1-pbonzini@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152630729517.90.15283298035840416031@1f70390a8372>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 14 May 2018 07:14:56 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] coverity-model: replay data is considered
 trusted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, Pavel.Dovgaluk@ispras.ru

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNTE0MTQxMjE4LjI4NDM4LTEtcGJvbnppbmlAcmVkaGF0LmNvbQpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBjb3Zlcml0eS1tb2RlbDogcmVwbGF5IGRhdGEgaXMg
Y29uc2lkZXJlZCB0cnVzdGVkCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1s
KQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxn
b3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJz
ZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRD
SCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEg
Z2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1h
aWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBu
PSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBk
YXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBz
Oi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogdCBbdGFnIHVwZGF0ZV0gICAgICAg
ICAgICBwYXRjaGV3LzIwMTgwNTEyMDA0MzExLjkyOTktMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5h
cm8ub3JnIC0+IHBhdGNoZXcvMjAxODA1MTIwMDQzMTEuOTI5OS0xLXJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmcKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE4MDUxNDE0
MTIxOC4yODQzOC0xLXBib256aW5pQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE4MDUxNDE0MTIx
OC4yODQzOC0xLXBib256aW5pQHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0JwpiYjQ0NzA3Y2YwIGNvdmVyaXR5LW1vZGVsOiByZXBsYXkgZGF0YSBpcyBjb25zaWRlcmVk
IHRydXN0ZWQKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogY292ZXJp
dHktbW9kZWw6IHJlcGxheSBkYXRhIGlzIGNvbnNpZGVyZWQgdHJ1c3RlZC4uLgpFUlJPUjogc3Vz
cGVjdCBjb2RlIGluZGVudCBmb3IgY29uZGl0aW9uYWwgc3RhdGVtZW50cyAoNSwgOSkKIzI1OiBG
SUxFOiBzY3JpcHRzL2NvdmVyaXR5LW1vZGVsLmM6MTExOgorICAgICBpZiAocmVwbGF5X2ZpbGUp
IHsKKyAgICAgICAgIHVpbnQ4X3QgYzsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTkg
bGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09
IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=
