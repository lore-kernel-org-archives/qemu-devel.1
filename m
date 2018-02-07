Received: from eggs.gnu.org ([2001:4830:134:3::10]:44439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ek3HI-00051u-Bw
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ek3HF-0001aM-A5
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:39:24 -0500
Resent-Message-Id: <E1ek3HF-0001aM-A5@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ek3HF-0001Zv-26
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:39:21 -0500
In-Reply-To: <1518046997-22714-1-git-send-email-mjc@sifive.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151804753284.267.1961024641475204958@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 7 Feb 2018 15:52:13 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v1] Implement support for IEEE 754-201x
 minimumNumber/maximumNumber
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, aurelien@aurel32.net, peter.maydell@linaro.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MTgwNDY5OTctMjI3MTQtMS1naXQtc2VuZC1lbWFpbC1tamNAc2lmaXZlLmNv
bQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYxXSBJbXBsZW1lbnQgc3VwcG9ydCBmb3Ig
SUVFRSA3NTQtMjAxeCBtaW5pbXVtTnVtYmVyL21heGltdW1OdW1iZXIKCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0t
b25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29t
bWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4g
JGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxv
ZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9
ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAg
ICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQg
JGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CjFkYmU3ODA5MmMgSW1wbGVtZW50IHN1cHBvcnQgZm9yIElFRUUgNzU0LTIwMXggbWluaW11bU51
bWJlci9tYXhpbXVtTnVtYmVyCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAx
LzE6IEltcGxlbWVudCBzdXBwb3J0IGZvciBJRUVFIDc1NC0yMDF4IG1pbmltdW1OdW1iZXIvbWF4
aW11bU51bWJlci4uLgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4
Old4VikKIzg1OiBGSUxFOiBmcHUvc29mdGZsb2F0LmM6Nzc3MzoKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGZsb2F0X3N0YXR1cyAqc3RhdHVzKSAgICAgICAgICAgICAgICAgIFwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjog
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4Old4VikKIzkxOiBGSUxFOiBmcHUv
c29mdGZsb2F0LmM6Nzc3OToKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZsb2F0
X3N0YXR1cyAqc3RhdHVzKSAgICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3Ms
IDk0IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVl
bGlzdHMub3Jn
