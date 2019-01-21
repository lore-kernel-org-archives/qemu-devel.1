Received: from eggs.gnu.org ([209.51.188.92]:51584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glRGI-00061c-6X
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 23:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glRGG-0001l2-7B
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 23:32:38 -0500
Resent-Message-Id: <E1glRGG-0001l2-7B@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1glRGB-0001fc-Av
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 23:32:33 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190115165710.20116-1-mhines@scalecomputing.com>
Message-ID: <154804511217.5550.13790444191417010991@2d3111e9616b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 20 Jan 2019 20:31:53 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] QGA: Fix guest-get-fsinfo PCI address
 collection in Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mhines@scalecomputing.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNTE2NTcxMC4yMDEx
Ni0xLW1oaW5lc0BzY2FsZWNvbXB1dGluZy5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5n
d0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAg
ICAgaHcvYWNwaS92bWdlbmlkLm8KICBDQyAgICAgIGh3L2FjcGkvYWNwaV9pbnRlcmZhY2Uubwov
dG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svc2hlZXBkb2cuYzogSW4gZnVuY3Rpb24gJ2ZpbmRfdmRp
X25hbWUnOgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svc2hlZXBkb2cuYzoxMjM5OjU6IGVycm9y
OiAnc3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDI1NiBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBb
LVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQogICAgIHN0cm5jcHkoYnVmICsgU0RfTUFYX1ZE
SV9MRU4sIHRhZywgU0RfTUFYX1ZESV9UQUdfTEVOKTsKICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVp
bmcgdHJlYXRlZCBhcyBlcnJvcnMKLS0tCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVk
IGpvYnMuLi4uCkluIGZ1bmN0aW9uICdhY3BpX3RhYmxlX2luc3RhbGwnLAogICAgaW5saW5lZCBm
cm9tICdhY3BpX3RhYmxlX2FkZCcgYXQgL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvY29yZS5j
OjI5Njo1OgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9jb3JlLmM6MTg0Ojk6IGVycm9yOiAn
c3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDQgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJy
b3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICAgICAgc3RybmNweShleHRfaGRyLT5zaWcsIGhk
cnMtPnNpZywgc2l6ZW9mIGV4dF9oZHItPnNpZyk7CiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9o
dy9hY3BpL2NvcmUuYzoyMDM6OTogZXJyb3I6ICdzdHJuY3B5JyBzcGVjaWZpZWQgYm91bmQgNiBl
cXVhbHMgZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQogICAg
ICAgICBzdHJuY3B5KGV4dF9oZHItPm9lbV9pZCwgaGRycy0+b2VtX2lkLCBzaXplb2YgZXh0X2hk
ci0+b2VtX2lkKTsKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvY29y
ZS5jOjIwNzo5OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCA4IGVxdWFscyBkZXN0
aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAgICAgICAgIHN0cm5j
cHkoZXh0X2hkci0+b2VtX3RhYmxlX2lkLCBoZHJzLT5vZW1fdGFibGVfaWQsCiAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgICAg
ICAgICAgICAgc2l6ZW9mIGV4dF9oZHItPm9lbV90YWJsZV9pZCk7CiAgICAgICAgICAgICAgICAg
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkv
Y29yZS5jOjIxNjo5OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCA0IGVxdWFscyBk
ZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAgICAgICAgIHN0
cm5jcHkoZXh0X2hkci0+YXNsX2NvbXBpbGVyX2lkLCBoZHJzLT5hc2xfY29tcGlsZXJfaWQsCiAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+CiAgICAgICAgICAgICAgICAgc2l6ZW9mIGV4dF9oZHItPmFzbF9jb21waWxlcl9pZCk7
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDE5MDExNTE2NTcxMC4yMDExNi0xLW1oaW5lc0BzY2FsZWNvbXB1dGluZy5jb20vdGVzdGluZy5k
b2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
