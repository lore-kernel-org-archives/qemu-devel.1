Received: from eggs.gnu.org ([209.51.188.92]:52119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpSKk-0008Ro-85
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 01:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpSKj-0008LW-AE
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 01:29:50 -0500
Resent-Message-Id: <E1gpSKj-0008LW-AE@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gpSKj-0008KC-2g
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 01:29:49 -0500
Message-ID: <154899621616.29184.6571631668991530666@ebba9967afc0>
In-Reply-To: <20190131071658.29120-1-tao3.xu@intel.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 31 Jan 2019 20:43:38 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Build ACPI Heterogeneous Memory
 Attribute Table (HMAT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tao3.xu@intel.com
Cc: fam@euphon.net, eblake@redhat.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, ehabkost@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com, danmei.wei@intel.com, karl.heubaum@oracle.com, rth@twiddle.net

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDEzMTA3MTY1OC4yOTEy
MC0xLXRhbzMueHVAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IFNIT1dfRU5WPTEgSj0xNAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBMSU5LICAgIGFhcmNo
NjQtc29mdG1tdS9xZW11LXN5c3RlbS1hYXJjaDY0dy5leGUKbnVtYS5vOm51bWEuYzooLnJkYXRh
JC5yZWZwdHIuaG1hdF9jYWNoZV9pbmZvWy5yZWZwdHIuaG1hdF9jYWNoZV9pbmZvXSsweDApOiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBobWF0X2NhY2hlX2luZm8nCm51bWEubzpudW1hLmM6KC5y
ZGF0YSQucmVmcHRyLmhtYXRfbGJfaW5mb1sucmVmcHRyLmhtYXRfbGJfaW5mb10rMHgwKTogdW5k
ZWZpbmVkIHJlZmVyZW5jZSB0byBgaG1hdF9sYl9pbmZvJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJl
dHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxOTk6IHFlbXUtc3lz
dGVtLWFhcmNoNjR3LmV4ZV0gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQyOTogc3ViZGly
LWFhcmNoNjQtc29mdG1tdV0gRXJyb3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFz
dCk6CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDE5MDEzMTA3MTY1OC4yOTEyMC0xLXRhbzMueHVAaW50ZWwuY29tL3Rlc3RpbmcuZG9ja2Vy
LW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
