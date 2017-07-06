Received: from eggs.gnu.org ([2001:4830:134:3::10]:35577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGXT-0002kv-Np
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGXS-0008AB-Lk
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:50:27 -0400
Resent-Message-Id: <E1dTGXS-0008AB-Lk@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dTGXS-00089g-D0
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:50:26 -0400
In-Reply-To: <1498715394-16402-1-git-send-email-tianyu.lan@intel.com>
Message-ID: <149938501143.27.5496610612212455695@7a482c8a7db2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 6 Jul 2017 16:50:12 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/3] Qemu: Add Xen vIOMMU interrupt
 remapping function support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tianyu.lan@intel.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, xen-devel@lists.xensource.com, kevin.tian@intel.com, sstabellini@kernel.org, mst@redhat.com, marcel@redhat.com, anthony.perard@citrix.com, chao.gao@intel.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCAwLzNdIFFlbXU6IEFkZCBYZW4gdklPTU1VIGludGVycnVwdCByZW1hcHBp
bmcgZnVuY3Rpb24gc3VwcG9ydApNZXNzYWdlLWlkOiAxNDk4NzE1Mzk0LTE2NDAyLTEtZ2l0LXNl
bmQtZW1haWwtdGlhbnl1LmxhbkBpbnRlbC5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAt
LW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNv
bW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGlu
ICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBs
b2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0
PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAg
ICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0
ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4
NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKZmF0YWw6IENhbm5vdCB1cGRhdGUgcGF0aHMgYW5k
IHN3aXRjaCB0byBicmFuY2ggJ3Rlc3QnIGF0IHRoZSBzYW1lIHRpbWUuCkRpZCB5b3UgaW50ZW5k
IHRvIGNoZWNrb3V0ICdvcmlnaW4vcGF0Y2hldy8xNDk4NzE1Mzk0LTE2NDAyLTEtZ2l0LXNlbmQt
ZW1haWwtdGlhbnl1LmxhbkBpbnRlbC5jb20nIHdoaWNoIGNhbiBub3QgYmUgcmVzb2x2ZWQgYXMg
Y29tbWl0PwpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiL2hvbWUv
ZmFtL2Jpbi9wYXRjaGV3IiwgbGluZSA0NDAsIGluIHRlc3Rfb25lCiAgICBnaXRfY2xvbmVfcmVw
byhjbG9uZSwgclsicmVwbyJdLCByWyJoZWFkIl0sIGxvZ2YpCiAgRmlsZSAiL2hvbWUvZmFtL2Jp
bi9wYXRjaGV3IiwgbGluZSA1MywgaW4gZ2l0X2Nsb25lX3JlcG8KICAgIGN3ZD1jbG9uZSkKICBG
aWxlICIvdXNyL2xpYjY0L3B5dGhvbjMuNS9zdWJwcm9jZXNzLnB5IiwgbGluZSAyNzEsIGluIGNo
ZWNrX2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnBy
b2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ2dpdCcsICdjaGVja291dCcsICdv
cmlnaW4vcGF0Y2hldy8xNDk4NzE1Mzk0LTE2NDAyLTEtZ2l0LXNlbmQtZW1haWwtdGlhbnl1Lmxh
bkBpbnRlbC5jb20nLCAnLWInLCAndGVzdCddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1
cyAxMjgKCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAZnJlZWxpc3RzLm9yZw==
