Received: from eggs.gnu.org ([209.51.188.92]:56636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glOka-0001cF-Vi
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 20:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1glOkZ-0007m6-T0
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 20:51:44 -0500
Resent-Message-Id: <E1glOkZ-0007m6-T0@eggs.gnu.org>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190115111007.27159-1-stefanha@redhat.com>
Message-ID: <154803546492.5550.12597499001850601331@2d3111e9616b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 20 Jan 2019 17:51:06 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH 0/2] qcow2: include LUKS payload overhead
 in qemu-img measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNTExMTAwNy4yNzE1
OS0xLXN0ZWZhbmhhQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRv
cmEgU0hPV19FTlY9MSBKPTE0Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgY3J5
cHRvL3Bia2RmLW5ldHRsZS5vCiAgQ0MgICAgICBjcnlwdG8vaXZnZW4ubwovdG1wL3FlbXUtdGVz
dC9zcmMvYmxvY2svc2hlZXBkb2cuYzogSW4gZnVuY3Rpb24gJ2ZpbmRfdmRpX25hbWUnOgovdG1w
L3FlbXUtdGVzdC9zcmMvYmxvY2svc2hlZXBkb2cuYzoxMjM5OjU6IGVycm9yOiAnc3RybmNweScg
c3BlY2lmaWVkIGJvdW5kIDI1NiBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJp
bmdvcC10cnVuY2F0aW9uXQogICAgIHN0cm5jcHkoYnVmICsgU0RfTUFYX1ZESV9MRU4sIHRhZywg
U0RfTUFYX1ZESV9UQUdfTEVOKTsKICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBh
cyBlcnJvcnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMTkwMTE1MTExMDA3LjI3MTU5LTEtc3RlZmFuaGFAcmVkaGF0LmNvbS90ZXN0aW5n
LmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
