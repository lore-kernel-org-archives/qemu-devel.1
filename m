Received: from eggs.gnu.org ([2001:4830:134:3::10]:58748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dmM3C-0007E3-Vq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dmM38-0005Sm-Rp
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:34:07 -0400
Resent-Message-Id: <E1dmM38-0005Sm-Rp@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dmM38-0005S6-Jb
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:34:02 -0400
In-Reply-To: <20170828153118.13500-1-agraf@suse.de>
Message-ID: <150393442266.27.2514179159640044257@b5667b65043c>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 28 Aug 2017 08:33:44 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] console: add question-mark escape
 operator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: agraf@suse.de
Cc: famz@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzA4MjgxNTMxMTguMTM1MDAtMS1hZ3JhZkBzdXNlLmRlClN1YmplY3Q6IFtRZW11LWRldmVsXSBb
UEFUQ0ggdjJdIGNvbnNvbGU6IGFkZCBxdWVzdGlvbi1tYXJrIGVzY2FwZSBvcGVyYXRvcgpUeXBl
OiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFz
ZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0w
CgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2
ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQ
QVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlm
ICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAt
LW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAg
ICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0
dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAg
ICAgICAgICBwYXRjaGV3LzIwMTcwODI4MTUzMTE4LjEzNTAwLTEtYWdyYWZAc3VzZS5kZSAtPiBw
YXRjaGV3LzIwMTcwODI4MTUzMTE4LjEzNTAwLTEtYWdyYWZAc3VzZS5kZQpTd2l0Y2hlZCB0byBh
IG5ldyBicmFuY2ggJ3Rlc3QnCmJjOGZkYjQwYjIgY29uc29sZTogYWRkIHF1ZXN0aW9uLW1hcmsg
ZXNjYXBlIG9wZXJhdG9yCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6
IGNvbnNvbGU6IGFkZCBxdWVzdGlvbi1tYXJrIGVzY2FwZSBvcGVyYXRvci4uLgpFUlJPUjogYnJh
Y2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiMyNjog
RklMRTogdWkvY29uc29sZS5jOjg4MzoKKyAgICAgICAgICAgIGlmIChjaCA9PSAnOycgfHwgY2gg
PT0gJz8nKQpbLi4uXQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4IGxpbmVzIGNoZWNr
ZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5E
ID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
