Received: from eggs.gnu.org ([209.51.188.92]:53878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glViF-0006WC-3W
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glViE-0004D6-60
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:17:47 -0500
Resent-Message-Id: <E1glViE-0004D6-60@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1glViD-0004BU-VX
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:17:46 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190116030815.27273-1-peterx@redhat.com>
Message-ID: <154805952549.5550.9154893774048296420@2d3111e9616b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 21 Jan 2019 00:32:07 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2 0/4] intel_iommu: misc fixes for error
 exposed after error_report_once()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, eric.auger@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNjAzMDgxNS4yNzI3
My0xLXBldGVyeEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IFNIT1dfRU5WPTEgSj0xNAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGh3L2Js
b2NrL3BmbGFzaF9jZmkwMS5vCkluIGZ1bmN0aW9uICdhY3BpX3RhYmxlX2luc3RhbGwnLAogICAg
aW5saW5lZCBmcm9tICdhY3BpX3RhYmxlX2FkZCcgYXQgL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Fj
cGkvY29yZS5jOjI5Njo1OgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9jb3JlLmM6MTg0Ojk6
IGVycm9yOiAnc3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDQgZXF1YWxzIGRlc3RpbmF0aW9uIHNp
emUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICAgICAgc3RybmNweShleHRfaGRy
LT5zaWcsIGhkcnMtPnNpZywgc2l6ZW9mIGV4dF9oZHItPnNpZyk7CiAgICAgICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10
ZXN0L3NyYy9ody9hY3BpL2NvcmUuYzoyMDM6OTogZXJyb3I6ICdzdHJuY3B5JyBzcGVjaWZpZWQg
Ym91bmQgNiBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0
aW9uXQogICAgICAgICBzdHJuY3B5KGV4dF9oZHItPm9lbV9pZCwgaGRycy0+b2VtX2lkLCBzaXpl
b2YgZXh0X2hkci0+b2VtX2lkKTsKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3
L2FjcGkvY29yZS5jOjIwNzo5OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCA4IGVx
dWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAgICAg
ICAgIHN0cm5jcHkoZXh0X2hkci0+b2VtX3RhYmxlX2lkLCBoZHJzLT5vZW1fdGFibGVfaWQsCiAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
CiAgICAgICAgICAgICAgICAgc2l6ZW9mIGV4dF9oZHItPm9lbV90YWJsZV9pZCk7CiAgICAgICAg
ICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L2FjcGkvY29yZS5jOjIxNjo5OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCA0
IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAg
ICAgICAgIHN0cm5jcHkoZXh0X2hkci0+YXNsX2NvbXBpbGVyX2lkLCBoZHJzLT5hc2xfY29tcGls
ZXJfaWQsCiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+CiAgICAgICAgICAgICAgICAgc2l6ZW9mIGV4dF9oZHItPmFzbF9jb21w
aWxlcl9pZCk7Ci0tLQptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6
IGh3L2FjcGkvY29yZS5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVk
IGpvYnMuLi4uCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9zaGVlcGRvZy5jOiBJbiBmdW5jdGlv
biAnZmluZF92ZGlfbmFtZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9zaGVlcGRvZy5jOjEy
Mzk6NTogZXJyb3I6ICdzdHJuY3B5JyBzcGVjaWZpZWQgYm91bmQgMjU2IGVxdWFscyBkZXN0aW5h
dGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAgICAgc3RybmNweShidWYg
KyBTRF9NQVhfVkRJX0xFTiwgdGFnLCBTRF9NQVhfVkRJX1RBR19MRU4pOwogICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3
YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0
L3NyYy9ydWxlcy5tYWs6Njk6IGJsb2NrL3NoZWVwZG9nLm9dIEVycm9yIDEKL3RtcC9xZW11LXRl
c3Qvc3JjL2h3L2FjcGkvYW1sLWJ1aWxkLmM6IEluIGZ1bmN0aW9uICdidWlsZF9oZWFkZXInOgov
dG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9hbWwtYnVpbGQuYzoxNTM1Ojk6IGVycm9yOiAnc3Ry
bmNweScgc3BlY2lmaWVkIGJvdW5kIDYgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJyb3I9
c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICAgICAgc3RybmNweSgoY2hhciAqKWgtPm9lbV9pZCwg
b2VtX2lkLCBzaXplb2YgaC0+b2VtX2lkKTsKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNw
aS9hbWwtYnVpbGQuYzoxNTQxOjk6IGVycm9yOiAnc3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDgg
ZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAg
ICAgICAgc3RybmNweSgoY2hhciAqKWgtPm9lbV90YWJsZV9pZCwgb2VtX3RhYmxlX2lkLCBzaXpl
b2YoaC0+b2VtX3RhYmxlX2lkKSk7CiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdh
cm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDExNjAzMDgxNS4yNzI3My0xLXBldGVy
eEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRo
YXQuY29t
