Received: from eggs.gnu.org ([2001:4830:134:3::10]:43020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cyS5q-0003rr-7g
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cyS5n-0004vK-2j
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:54:34 -0400
Resent-Message-Id: <E1cyS5n-0004vK-2j@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cyS5m-0004vE-Qy
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:54:31 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <149204126659.10500.5552161461329675894@6c512846dbc7>
In-Reply-To: <20170407143847.GM2138@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 12 Apr 2017 16:54:26 -0700 (PDT)
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzA0MDcxNDM4NDcuR00yMTM4QHdvcmstdm0KU3ViamVjdDogW1FlbXUtZGV2ZWxdIEhhY2tzIGZv
ciBidWlsZGluZyBvbiBnY2MgNyAvIEZlZG9yYSAyNgpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9n
IC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgojIFVzZWZ1bCBnaXQgb3B0aW9u
cwpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2
ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQ
QVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlm
ICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAt
LW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAg
ICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hl
ZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmFkMDBhYzMgSGFja3MgZm9yIGJ1aWxkaW5nIG9uIGdj
YyA3IC8gRmVkb3JhIDI2Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6
IEhhY2tzIGZvciBidWlsZGluZyBvbiBnY2MgNyAvIEZlZG9yYSAyNi4uLgpXQVJOSU5HOiBsaW5l
IG92ZXIgODAgY2hhcmFjdGVycwojNjM6IEZJTEU6IGJsb2NrL2Jsa3ZlcmlmeS5jOjMxMToKKyAg
ICAgICAgICAgICAgICAgcy0+dGVzdF9maWxlLT5icy0+ZXhhY3RfZmlsZW5hbWUpLCA8LCBzaXpl
b2YoYnMtPmV4YWN0X2ZpbGVuYW1lKSk7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVy
cwojODU6IEZJTEU6IGh3L3VzYi9idXMuYzo0MTE6CisgICAgICAgIGdfYXNzZXJ0X2NtcGludChz
bnByaW50Zihkb3duc3RyZWFtLT5wYXRoLCBzaXplb2YoZG93bnN0cmVhbS0+cGF0aCksICIlcy4l
ZCIsCgpFUlJPUjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJv
cnMsIDIgd2FybmluZ3MsIDY0IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
