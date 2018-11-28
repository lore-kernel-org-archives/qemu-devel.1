Received: from eggs.gnu.org ([2001:4830:134:3::10]:33794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gRxSA-0004Hv-Cq
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gRxS8-0006OC-G5
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:52:22 -0500
Resent-Message-Id: <E1gRxS8-0006OC-G5@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gRxS6-0006L0-Jq
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:52:19 -0500
In-Reply-To: <20181126191454.9455-1-ricardo.perez_blanco@nokia.com>
Message-ID: <154340230394.17700.13721980116479411692@c26723477dc9>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 28 Nov 2018 02:51:45 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] [PATCH] Allow AArch64 processors to boot
 from a kernel placed over 4GB.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ricardo.perez_blanco@nokia.com
Cc: famz@redhat.com, ricardoperezblanco@gmail.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
ODExMjYxOTE0NTQuOTQ1NS0xLXJpY2FyZG8ucGVyZXpfYmxhbmNvQG5va2lhLmNvbQpTdWJqZWN0
OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBbUEFUQ0hdIEFsbG93IEFBcmNoNjQgcHJvY2Vzc29ycyB0
byBib290IGZyb20gYSBrZXJuZWwgcGxhY2VkIG92ZXIgNEdCLgpUeXBlOiBzZXJpZXMKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChn
aXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMg
VHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCgpjb21taXRz
PSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29t
bWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1u
IDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFp
bCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZh
aWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFp
bGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOTZl
MjNlNCBBbGxvdyBBQXJjaDY0IHByb2Nlc3NvcnMgdG8gYm9vdCBmcm9tIGEga2VybmVsIHBsYWNl
ZCBvdmVyIDRHQi4KCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogQWxs
b3cgQUFyY2g2NCBwcm9jZXNzb3JzIHRvIGJvb3QgZnJvbSBhIGtlcm5lbCBwbGFjZWQgb3ZlciA0
R0IuLi4uCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMjI6IEZJTEU6IGh3L2FybS9i
b290LmM6Njc6CisgICAgRklYVVBfQVJHUFRSX0hJR0hFUl8zMkJJVFMsICAgICAgIC8qIG92ZXJ3
cml0ZSB3aXRoIHBvaW50ZXIgdG8ga2VybmVsIGFyZ3MgKGhpZ2hlciAzMiBiaXRzKSAqLwoKRVJS
T1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMyNDogRklMRTogaHcvYXJtL2Jvb3QuYzo2OToK
KyAgICBGSVhVUF9FTlRSWVBPSU5UX0hJR0hFUl8zMkJJVFMsICAgLyogb3ZlcndyaXRlIHdpdGgg
a2VybmVsIGVudHJ5IHBvaW50IChoaWdoZXIgMzIgYml0cykgKi8KCldBUk5JTkc6IGxpbmUgb3Zl
ciA4MCBjaGFyYWN0ZXJzCiMzNjogRklMRTogaHcvYXJtL2Jvb3QuYzo5MToKKyAgICB7IDAsIEZJ
WFVQX0VOVFJZUE9JTlRfSElHSEVSXzMyQklUUyB9LCAvKiAud29yZCBAS2VybmVsIEVudHJ5IEhp
Z2hlciAzMi1iaXRzICovCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzY1OiBGSUxF
OiBody9hcm0vYm9vdC5jOjExNjI6CisgICAgICAgICAgICBmaXh1cGNvbnRleHRbRklYVVBfQVJH
UFRSX0hJR0hFUl8zMkJJVFNdID0gKGluZm8tPmxvYWRlcl9zdGFydCArIEtFUk5FTF9BUkdTX0FE
RFIpID4+IDMyOwoKdG90YWw6IDMgZXJyb3JzLCAxIHdhcm5pbmdzLCA1MyBsaW5lcyBjaGVja2Vk
CgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
