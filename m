Received: from eggs.gnu.org ([2001:4830:134:3::10]:51996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dJRGr-0002Ri-60
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 17:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dJRGo-00049y-1s
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 17:16:41 -0400
Resent-Message-Id: <E1dJRGo-00049y-1s@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dJRGn-00049h-Py
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 17:16:37 -0400
In-Reply-To: <cover.e0862272629975a2a7296103cf5d5f8de70abc01.1497035841.git-series.knut.omang@oracle.com>
Message-ID: <149704298673.3807.6161585661619548904@84b42461e25a>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 9 Jun 2017 14:16:27 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/2] Unit test+fix for problem with QEMU
 handling of multiple bind()s to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: knut.omang@oracle.com
Cc: famz@redhat.com, berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IGNvdmVyLmUwODYyMjcyNjI5OTc1YTJhNzI5NjEwM2NmNWQ1ZjhkZTcwYWJjMDEu
MTQ5NzAzNTg0MS5naXQtc2VyaWVzLmtudXQub21hbmdAb3JhY2xlLmNvbQpTdWJqZWN0OiBbUWVt
dS1kZXZlbF0gW1BBVENIIDAvMl0gVW5pdCB0ZXN0K2ZpeCBmb3IgcHJvYmxlbSB3aXRoIFFFTVUg
aGFuZGxpbmcgb2YgbXVsdGlwbGUgYmluZCgpcyB0byB0aGUgc2FtZSBwb3J0Cgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxv
ZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
CmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBj
IGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdp
dCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9y
bWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAg
ICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpl
eGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIx
ZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0JwowMTZmMjhjIHNvY2tldDogSGFuZGxlIHJhY2UgY29uZGl0aW9uIGJldHdlZW4gYmluZHMg
dG8gdGhlIHNhbWUgcG9ydApiNGZmNjUwIEFkZCB0ZXN0LWxpc3RlbiAtIGEgc3RyZXNzIHRlc3Qg
Zm9yIFFFTVUgc29ja2V0IGxpc3RlbgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFU
Q0ggMS8yOiBBZGQgdGVzdC1saXN0ZW4gLSBhIHN0cmVzcyB0ZXN0IGZvciBRRU1VIHNvY2tldCBs
aXN0ZW4uLi4KRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMxNzM6IEZJTEU6IHRlc3Rz
L3Rlc3QtbGlzdGVuLmM6OTk6CisgICAgICAgICAgICBwcmludGYoIioqIEZhaWxlZCB0byBhc3Np
Z24gYSBwb3J0IHRvIHRocmVhZCAlZCAoZXJybm8gPSAlZClcbiIsIGksIHRocltpXS5lbm8pOwoK
V0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzE3NzogRklMRTogdGVzdHMvdGVzdC1s
aXN0ZW4uYzoxMDM6CisgICAgICAgICAgICBnX2Fzc2VydChzdHJzdHIodGhyW2ldLmVycnN0ciwg
IkZhaWxlZCB0byBsaXN0ZW4gb24gc29ja2V0IikgIT0gTlVMTCk7Cgp0b3RhbDogMSBlcnJvcnMs
IDEgd2FybmluZ3MsIDE0OSBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgpDaGVja2luZyBQQVRDSCAyLzI6IHNvY2tldDogSGFuZGxlIHJhY2UgY29u
ZGl0aW9uIGJldHdlZW4gYmluZHMgdG8gdGhlIHNhbWUgcG9ydC4uLgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
