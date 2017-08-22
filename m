Received: from eggs.gnu.org ([2001:4830:134:3::10]:53843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dk3RV-0002Zz-EU
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 03:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dk3RU-0005Az-B6
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 03:17:41 -0400
Resent-Message-Id: <E1dk3RU-0005Az-B6@eggs.gnu.org>
Message-ID: <150338622227.30.4308695337522931453@205a2245145f>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 22 Aug 2017 00:17:03 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bauerman@linux.vnet.ibm.com
Cc: famz@redhat.com, qemu-ppc@nongnu.org, mpe@ellerman.id.au, linuxram@us.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org, david@gibson.dropbear.id.au

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcwODIxMjAwMDM2LjE1MDM2LTEtYmF1ZXJtYW5AbGludXgudm5ldC5pYm0u
Y29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHNwYXByOiBBZGQgaWJtLCBwcm9jZXNz
b3Itc3RvcmFnZS1rZXlzIHByb3BlcnR5IHRvIENQVSBEVCBub2RlCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9u
ZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1p
dHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRj
b21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cg
LW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVt
YWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAg
ZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRm
YWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo3
MjI0MWVjMjBlIHNwYXByOiBBZGQgaWJtLCBwcm9jZXNzb3Itc3RvcmFnZS1rZXlzIHByb3BlcnR5
IHRvIENQVSBEVCBub2RlCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6
IHNwYXByOiBBZGQgaWJtLCBwcm9jZXNzb3Itc3RvcmFnZS1rZXlzIHByb3BlcnR5IHRvIENQVSBE
VCBub2RlLi4uCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2Yg
dGhpcyBzdGF0ZW1lbnQKIzU5OiBGSUxFOiBody9wcGMvc3BhcHIuYzo2MjY6CisgICAgaWYgKCEo
ZW52LT5tbXVfbW9kZWwgJiBQT1dFUlBDX01NVV9BTVIpKQpbLi4uXQoKV0FSTklORzogbGluZSBv
dmVyIDgwIGNoYXJhY3RlcnMKIzExMzogRklMRTogaHcvcHBjL3NwYXByLmM6NjgwOgorICAgICAg
ICBzcGFwci0+aW5zbl9rZXlzID0gUE9XRVJQQ19NTVVfVkVSKGVudi0+bW11X21vZGVsKSAhPSBQ
T1dFUlBDX01NVV9WRVJfMl8wNjsKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgMTAwIGxp
bmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMu
b3Jn
