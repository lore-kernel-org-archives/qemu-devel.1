Received: from eggs.gnu.org ([209.51.188.92]:53371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpXFa-0001EV-PL
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 06:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpXFZ-00036D-Fz
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 06:44:50 -0500
Resent-Message-Id: <E1gpXFZ-00036D-Fz@eggs.gnu.org>
Message-ID: <154902145391.29184.7539255014900374417@ebba9967afc0>
In-Reply-To: <20190123101458.12478-1-eric.auger@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 1 Feb 2019 03:44:15 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v5 00/18] ARM virt: Initial RAM expansion
 and PCDIMM/NVDIMM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com
Cc: fam@euphon.net, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com, drjones@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDEyMzEwMTQ1OC4xMjQ3
OC0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBTSE9XX0VOVj0xIEo9MTQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBh
YXJjaDY0LXNvZnRtbXUvaHcvYXJtL25zZXJpZXMubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11
L2h3L2FybS9vbWFwX3N4MS5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9hcm0vdmlydC1hY3BpLWJ1
aWxkLmM6IEluIGZ1bmN0aW9uICdidWlsZF9zcmF0JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Fy
bS92aXJ0LWFjcGktYnVpbGQuYzo1NDg6NDg6IGVycm9yOiBpbmNvbXBhdGlibGUgdHlwZSBmb3Ig
YXJndW1lbnQgMyBvZiAnYnVpbGRfc3JhdF9tZW1vcnknCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG1zLT5kZXZpY2VfbWVtb3J5LT5tci5zaXplLCBuYl9udW1hX25vZGVzIC0gMSwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+Xn5+fn4KSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9ody9hcm0vdmlydC1hY3BpLWJ1aWxkLmM6
NDI6CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDE5MDEyMzEwMTQ1OC4xMjQ3OC0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS90ZXN0aW5nLmRv
Y2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
