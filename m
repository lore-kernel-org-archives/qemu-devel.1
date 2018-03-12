Received: from eggs.gnu.org ([2001:4830:134:3::10]:43736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1evrjv-0004ET-2Z
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1evrjs-0007ps-1V
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:47 -0400
Resent-Message-Id: <E1evrjs-0007ps-1V@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1evrjr-0007op-P3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:43 -0400
In-Reply-To: <20180312131806.23209-1-stefanha@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152087753197.39.12710552937901569774@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 12 Mar 2018 10:58:52 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMzEyMTMxODA2LjIzMjA5LTEtc3RlZmFuaGFAcmVkaGF0LmNvbQpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBjaGVja3BhdGNoOiB3YXJuIGFib3V0IG1pc3Npbmcg
TUFJTlRBSU5FUlMgZmlsZSBjaGFuZ2VzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
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
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjg5ZDY2NTA2OWQgY2hlY2twYXRjaDogd2FybiBh
Ym91dCBtaXNzaW5nIE1BSU5UQUlORVJTIGZpbGUgY2hhbmdlcwoKPT09IE9VVFBVVCBCRUdJTiA9
PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBjaGVja3BhdGNoOiB3YXJuIGFib3V0IG1pc3NpbmcgTUFJ
TlRBSU5FUlMgZmlsZSBjaGFuZ2VzLi4uCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJz
CiM0NzogRklMRTogc2NyaXB0cy9jaGVja3BhdGNoLnBsOjEzOTM6CisJCSAgICAgKCRsaW5lID1+
IC9ce1xzKihbXHdcL1wuXC1dKilccypcPVw+XHMqKFtcd1wvXC5cLV0qKVxzKlx9LyAmJgoKRVJS
T1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM1MTogRklMRTogc2NyaXB0cy9jaGVja3BhdGNo
LnBsOjEzOTc6CisJCQlXQVJOKCJhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2Vz
IE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/XG4iIC4KCnRvdGFsOiAxIGVycm9ycywgMSB3YXJu
aW5ncywgMzEgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QGZyZWVsaXN0cy5vcmc=
