Received: from eggs.gnu.org ([209.51.188.92]:59605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glYR3-0007J0-EY
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glYR2-0007Cj-It
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:12:13 -0500
Resent-Message-Id: <E1glYR2-0007Cj-It@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1glYR2-0007AP-Cs
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:12:12 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190115184229.73688-1-emaste@freefall.freebsd.org>
Message-ID: <154807269875.5550.47391861949358881@2d3111e9616b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 21 Jan 2019 04:11:39 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: emaste@freefall.freebsd.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, emaste@freebsd.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNTE4NDIyOS43MzY4
OC0xLWVtYXN0ZUBmcmVlZmFsbC5mcmVlYnNkLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1p
bmd3QGZlZG9yYSBTSE9XX0VOVj0xIEo9MTQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0Mg
ICAgICBody9jcHUvY2x1c3Rlci5vCkluIGZ1bmN0aW9uICdhY3BpX3RhYmxlX2luc3RhbGwnLAog
ICAgaW5saW5lZCBmcm9tICdhY3BpX3RhYmxlX2FkZCcgYXQgL3RtcC9xZW11LXRlc3Qvc3JjL2h3
L2FjcGkvY29yZS5jOjI5Njo1OgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9jb3JlLmM6MTg0
Ojk6IGVycm9yOiAnc3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDQgZXF1YWxzIGRlc3RpbmF0aW9u
IHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICAgICAgc3RybmNweShleHRf
aGRyLT5zaWcsIGhkcnMtPnNpZywgc2l6ZW9mIGV4dF9oZHItPnNpZyk7CiAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAvcWVt
dS10ZXN0L3NyYy9ody9hY3BpL2NvcmUuYzoyMDM6OTogZXJyb3I6ICdzdHJuY3B5JyBzcGVjaWZp
ZWQgYm91bmQgNiBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVu
Y2F0aW9uXQogICAgICAgICBzdHJuY3B5KGV4dF9oZHItPm9lbV9pZCwgaGRycy0+b2VtX2lkLCBz
aXplb2YgZXh0X2hkci0+b2VtX2lkKTsKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L2FjcGkvY29yZS5jOjIwNzo5OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCA4
IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAg
ICAgICAgIHN0cm5jcHkoZXh0X2hkci0+b2VtX3RhYmxlX2lkLCBoZHJzLT5vZW1fdGFibGVfaWQs
CiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+CiAgICAgICAgICAgICAgICAgc2l6ZW9mIGV4dF9oZHItPm9lbV90YWJsZV9pZCk7CiAgICAg
ICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qv
c3JjL2h3L2FjcGkvY29yZS5jOjIxNjo5OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3Vu
ZCA0IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25d
CiAgICAgICAgIHN0cm5jcHkoZXh0X2hkci0+YXNsX2NvbXBpbGVyX2lkLCBoZHJzLT5hc2xfY29t
cGlsZXJfaWQsCiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgICAgICAgICAgICAgc2l6ZW9mIGV4dF9oZHItPmFzbF9j
b21waWxlcl9pZCk7Ci0tLQptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6
Njk6IGh3L2FjcGkvY29yZS5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlz
aGVkIGpvYnMuLi4uCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9zaGVlcGRvZy5jOiBJbiBmdW5j
dGlvbiAnZmluZF92ZGlfbmFtZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9zaGVlcGRvZy5j
OjEyMzk6NTogZXJyb3I6ICdzdHJuY3B5JyBzcGVjaWZpZWQgYm91bmQgMjU2IGVxdWFscyBkZXN0
aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAgICAgc3RybmNweShi
dWYgKyBTRF9NQVhfVkRJX0xFTiwgdGFnLCBTRF9NQVhfVkRJX1RBR19MRU4pOwogICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFs
bCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogWy90bXAvcWVtdS10
ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGJsb2NrL3NoZWVwZG9nLm9dIEVycm9yIDEKL3RtcC9xZW11
LXRlc3Qvc3JjL2h3L2FjcGkvYW1sLWJ1aWxkLmM6IEluIGZ1bmN0aW9uICdidWlsZF9oZWFkZXIn
OgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9hbWwtYnVpbGQuYzoxNTM1Ojk6IGVycm9yOiAn
c3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDYgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJy
b3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICAgICAgc3RybmNweSgoY2hhciAqKWgtPm9lbV9p
ZCwgb2VtX2lkLCBzaXplb2YgaC0+b2VtX2lkKTsKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvaHcv
YWNwaS9hbWwtYnVpbGQuYzoxNTQxOjk6IGVycm9yOiAnc3RybmNweScgc3BlY2lmaWVkIGJvdW5k
IDggZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0K
ICAgICAgICAgc3RybmNweSgoY2hhciAqKWgtPm9lbV90YWJsZV9pZCwgb2VtX3RhYmxlX2lkLCBz
aXplb2YoaC0+b2VtX3RhYmxlX2lkKSk7CiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxs
IHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDExNTE4NDIyOS43MzY4OC0xLWVt
YXN0ZUBmcmVlZmFsbC5mcmVlYnNkLm9yZy90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==
