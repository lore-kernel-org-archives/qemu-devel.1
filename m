Received: from eggs.gnu.org ([209.51.188.92]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hM3I5-0008CU-Ix
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hM3Hi-00072T-5B
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:25:34 -0400
Resent-Message-Id: <E1hM3Hi-00072T-5B@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hM3Hd-0006Mg-0P
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:25:21 -0400
In-Reply-To: <20190430034412.12935-1-richardw.yang@linux.intel.com>
Message-ID: <155677104475.10667.17544832182226944733@c2072b67cc0c>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 1 May 2019 21:24:06 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/3] Cleanup migration/ram.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richardw.yang@linux.intel.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, pbonzini@redhat.com, dgilbert@redhat.com, quintela@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQzMDAzNDQxMi4xMjkz
NS0xLXJpY2hhcmR3LnlhbmdAbGludXguaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZh
aWxlZCB0aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRB
UkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgogIENPUFkgICAgUlVOTkVSCiAgICBSVU4gdGVzdC1kZWJ1ZyBpbiBxZW11OmZlZG9y
YSAKY29udGFpbmVyX2xpbnV4LmdvOjI0Nzogc3RhcnRpbmcgY29udGFpbmVyIHByb2Nlc3MgY2F1
c2VkICJwcm9jZXNzX2xpbnV4LmdvOjI1ODogYXBwbHlpbmcgY2dyb3VwIGNvbmZpZ3VyYXRpb24g
Zm9yIHByb2Nlc3MgY2F1c2VkIFwiVGhlIG1heGltdW0gbnVtYmVyIG9mIGFjdGl2ZSBjb25uZWN0
aW9ucyBmb3IgVUlEIDAgaGFzIGJlZW4gcmVhY2hlZFwiIgovdXNyL2Jpbi9kb2NrZXItY3VycmVu
dDogRXJyb3IgcmVzcG9uc2UgZnJvbSBkYWVtb246IG9jaSBydW50aW1lIGVycm9yOiBUaGUgbWF4
aW11bSBudW1iZXIgb2YgYWN0aXZlIGNvbm5lY3Rpb25zIGZvciBVSUQgMCBoYXMgYmVlbiByZWFj
aGVkLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9k
b2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2MTUsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWlu
KCkpCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDE5MDQzMDAzNDQxMi4xMjkzNS0xLXJpY2hhcmR3LnlhbmdAbGludXguaW50ZWwuY29tL3Rl
c3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
