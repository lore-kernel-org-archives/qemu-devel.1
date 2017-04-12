Received: from eggs.gnu.org ([2001:4830:134:3::10]:42941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cyS5W-0003fr-KB
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cyS5T-0004lv-CW
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:54:14 -0400
Resent-Message-Id: <E1cyS5T-0004lv-CW@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cyS5T-0004lp-4h
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:54:11 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <149204123324.10500.8212961201636663323@6c512846dbc7>
In-Reply-To: <20170407144138.12871-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 12 Apr 2017 16:53:53 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/virt: generate 64-bit
 addressable ACPI objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ard.biesheuvel@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, lersek@redhat.com, phil@philjordan.eu, mst@redhat.com, drjones@redhat.com, zhaoshenglong@huawei.com, imammedo@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzA0MDcxNDQxMzguMTI4NzEtMS1hcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnClN1YmplY3Q6IFtR
ZW11LWRldmVsXSBbUEFUQ0ggdjJdIGh3L2FybS92aXJ0OiBnZW5lcmF0ZSA2NC1iaXQgYWRkcmVz
c2FibGUgQUNQSSBvYmplY3RzClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRC
QVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
cyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4p
Igpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3Rh
bDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAk
YyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsg
dGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkK
ZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhj
ZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKYzYzYTMzZSBody9hcm0vdmlydDogZ2VuZXJhdGUgNjQtYml0IGFkZHJlc3Nh
YmxlIEFDUEkgb2JqZWN0cwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8x
OiBody9hcm0vdmlydDogZ2VuZXJhdGUgNjQtYml0IGFkZHJlc3NhYmxlIEFDUEkgb2JqZWN0cy4u
LgpFUlJPUjogb3BlbiBicmFjZSAneycgZm9sbG93aW5nIHN0cnVjdCBnbyBvbiB0aGUgc2FtZSBs
aW5lCiMxNTQ6IEZJTEU6IGluY2x1ZGUvaHcvYWNwaS9hY3BpLWRlZnMuaDoyNDQ6CitzdHJ1Y3Qg
QWNwaVhzZHREZXNjcmlwdG9yUmV2MgorewoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAx
MjUgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoK
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVs
aXN0cy5vcmc=
