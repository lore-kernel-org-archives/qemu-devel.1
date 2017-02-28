Received: from eggs.gnu.org ([2001:4830:134:3::10]:56269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cigDQ-0001C7-PC
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cigDM-0006sE-GN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:45:12 -0500
Resent-Message-Id: <E1cigDM-0006sE-GN@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cigDM-0006qa-7g
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:45:08 -0500
In-Reply-To: <20170228113535.7099-2-ebischoff@suse.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148828217147.186.4212905025515476122@0e2666bad730>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 28 Feb 2017 03:42:52 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] Adding support for LPD and LPDG
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ebischoff@suse.com
Cc: famz@redhat.com, rth@twiddle.net, agraf@suse.de, mmarek@suse.cz, mbenes@suse.cz, qemu-devel@nongnu.org, ebischoff@nerim.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzAyMjgxMTM1MzUuNzA5OS0yLWViaXNjaG9mZkBzdXNlLmNvbQpUeXBlOiBzZXJpZXMKU3ViamVj
dDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gQWRkaW5nIHN1cHBvcnQgZm9yIExQRCBhbmQgTFBERyBp
bnN0cnVjdGlvbnMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9
YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxl
ZD0wCgojIFVzZWZ1bCBnaXQgb3B0aW9ucwpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChn
aXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7
IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0t
Zm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAu
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9
MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3Qv
cWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMTcwMjI4MTEzNTM1LjcwOTktMi1l
YmlzY2hvZmZAc3VzZS5jb20gLT4gcGF0Y2hldy8yMDE3MDIyODExMzUzNS43MDk5LTItZWJpc2No
b2ZmQHN1c2UuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZjczNTliZCBBZGRp
bmcgc3VwcG9ydCBmb3IgTFBEIGFuZCBMUERHIGluc3RydWN0aW9ucwoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBBZGRpbmcgc3VwcG9ydCBmb3IgTFBEIGFuZCBMUERH
IGluc3RydWN0aW9ucy4uLgpFUlJPUjogc3VzcGVjdCBjb2RlIGluZGVudCBmb3IgY29uZGl0aW9u
YWwgc3RhdGVtZW50cyAoNiwgMTEpCiM0NjogRklMRTogdGFyZ2V0L3MzOTB4L3RyYW5zbGF0ZS5j
OjI3NTk6CisgICAgICBpZiAocGFyYWxsZWxfY3B1cykgeworICAgICAgICAgICBwb3RlbnRpYWxf
cGFnZV9mYXVsdChzKTsKCkVSUk9SOiBzdXNwZWN0IGNvZGUgaW5kZW50IGZvciBjb25kaXRpb25h
bCBzdGF0ZW1lbnRzICg0LCA5KQojNjk6IEZJTEU6IHRhcmdldC9zMzkweC90cmFuc2xhdGUuYzoy
NzgyOgorICAgIGlmIChwYXJhbGxlbF9jcHVzKSB7CisgICAgICAgICBwb3RlbnRpYWxfcGFnZV9m
YXVsdChzKTsKCkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiAz
IGVycm9ycywgMCB3YXJuaW5ncywgOTEgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhp
dGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
