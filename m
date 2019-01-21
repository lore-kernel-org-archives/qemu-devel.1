Received: from eggs.gnu.org ([209.51.188.92]:39642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glSsX-0001eH-Kp
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glSkB-0002oG-ND
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:07:37 -0500
Resent-Message-Id: <E1glSkB-0002oG-ND@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1glSk6-0002hi-8c
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:07:31 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190115193750.17234-1-farosas@linux.ibm.com>
Message-ID: <154804991020.5550.10637299560200451310@2d3111e9616b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 20 Jan 2019 21:51:51 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v3 0/3] ppc/gdbstub: Expose SPRs to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: farosas@linux.ibm.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNTE5Mzc1MC4xNzIz
NC0xLWZhcm9zYXNAbGludXguaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBTSE9XX0VOVj0xIEo9MTQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBo
dy9hY3BpL3ZtZ2VuaWQubwogIENDICAgICAgaHcvYWNwaS9hY3BpX2ludGVyZmFjZS5vCi90bXAv
cWVtdS10ZXN0L3NyYy9ibG9jay9zaGVlcGRvZy5jOiBJbiBmdW5jdGlvbiAnZmluZF92ZGlfbmFt
ZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9zaGVlcGRvZy5jOjEyMzk6NTogZXJyb3I6ICdz
dHJuY3B5JyBzcGVjaWZpZWQgYm91bmQgMjU2IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vy
cm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAgICAgc3RybmNweShidWYgKyBTRF9NQVhfVkRJX0xF
TiwgdGFnLCBTRF9NQVhfVkRJX1RBR19MRU4pOwogICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0
cmVhdGVkIGFzIGVycm9ycwotLS0KbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4KSW4gZnVuY3Rpb24gJ2FjcGlfdGFibGVfaW5zdGFsbCcsCiAgICBpbmxpbmVkIGZyb20g
J2FjcGlfdGFibGVfYWRkJyBhdCAvdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9jb3JlLmM6Mjk2
OjU6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9hY3BpL2NvcmUuYzoxODQ6OTogZXJyb3I6ICdzdHJu
Y3B5JyBzcGVjaWZpZWQgYm91bmQgNCBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1z
dHJpbmdvcC10cnVuY2F0aW9uXQogICAgICAgICBzdHJuY3B5KGV4dF9oZHItPnNpZywgaGRycy0+
c2lnLCBzaXplb2YgZXh0X2hkci0+c2lnKTsKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Fj
cGkvY29yZS5jOjIwMzo5OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCA2IGVxdWFs
cyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAgICAgICAg
IHN0cm5jcHkoZXh0X2hkci0+b2VtX2lkLCBoZHJzLT5vZW1faWQsIHNpemVvZiBleHRfaGRyLT5v
ZW1faWQpOwogICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9jb3JlLmM6
MjA3Ojk6IGVycm9yOiAnc3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDggZXF1YWxzIGRlc3RpbmF0
aW9uIHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICAgICAgc3RybmNweShl
eHRfaGRyLT5vZW1fdGFibGVfaWQsIGhkcnMtPm9lbV90YWJsZV9pZCwKICAgICAgICAgXn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KICAgICAgICAgICAg
ICAgICBzaXplb2YgZXh0X2hkci0+b2VtX3RhYmxlX2lkKTsKICAgICAgICAgICAgICAgICB+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9jb3Jl
LmM6MjE2Ojk6IGVycm9yOiAnc3RybmNweScgc3BlY2lmaWVkIGJvdW5kIDQgZXF1YWxzIGRlc3Rp
bmF0aW9uIHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICAgICAgc3RybmNw
eShleHRfaGRyLT5hc2xfY29tcGlsZXJfaWQsIGhkcnMtPmFzbF9jb21waWxlcl9pZCwKICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4KICAgICAgICAgICAgICAgICBzaXplb2YgZXh0X2hkci0+YXNsX2NvbXBpbGVyX2lkKTsKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkw
MTE1MTkzNzUwLjE3MjM0LTEtZmFyb3Nhc0BsaW51eC5pYm0uY29tL3Rlc3RpbmcuZG9ja2VyLW1p
bmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
