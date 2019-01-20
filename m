Received: from eggs.gnu.org ([209.51.188.92]:60431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl6SP-0005Sf-Rd
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 01:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl6SN-0002pO-Rf
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 01:19:45 -0500
Received: from m13-1.163.com ([220.181.13.1]:40285)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl6SM-0002nw-82
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 01:19:43 -0500
Date: Sun, 20 Jan 2019 14:04:10 +0800 (CST)
From: =?GBK?B?wO7Hvw==?= <liq3ea@163.com>
In-Reply-To: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
References: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Message-ID: <4627c86e.406c.16869dbf8f9.Coremail.liq3ea@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH PULL 00/10] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yuval.shaia@oracle.com, kamalheib1@gmail.com, cohuck@redhat.com, philmd@redhat.com

CgpIaSBNYXJjZWwsClNlZW1zIHlvdSBsb3N0IGFub3RoZXI6CgoKaHc6IHB2cmRtYTogZml4IG1l
bW9yeSBsZWFrIGluIGVycm9yIHBhdGgKLS0+aHR0cDovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9o
dG1sL3FlbXUtZGV2ZWwvMjAxOS0wMS9tc2cwMTIxNy5odG1sCgoKCkF0IDIwMTktMDEtMTkgMTg6
MDM6MDUsICJNYXJjZWwgQXBmZWxiYXVtIiA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+IHdy
b3RlOgo+VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBhOGQyYjA2ODU2ODFlMmYy
OTFmYWFhNTAxZWZiYmQ3Njg3NWY4ZWM4Ogo+Cj4gIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFu
Y2ggJ3JlbW90ZXMvY29odWNrL3RhZ3MvczM5MHgtMjAxOTAxMTgnIGludG8gc3RhZ2luZyAoMjAx
OS0wMS0xOCAxNjo1NjoxNSArMDAwMCkKPgo+YXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6Cj4KPiAgaHR0cHM6Ly9naXRodWIuY29tL21hcmNlbC1hcGYvcWVtdSB0YWdzL3Jk
bWEtcHVsbC1yZXF1ZXN0Cj4KPmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAwZjY0NWJh
MTZjNmI3NmNjZjIwNzZkMzg0NjBhYTk5ODE5ODg5M2JjOgo+Cj4gIGNvbnRyaWIvcmRtYWNtLW11
eDogZml4IGNsYW5nIGNvbXBpbGF0aW9uICgyMDE5LTAxLTE5IDExOjAxOjU3ICswMjAwKQo+Cj4t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj5SRE1BIHF1ZXVlCj4gKiBDbGFuZyBjb21waWxhdGlvbiBmaXgKPiAqIENvdmVyaXR5
IGZpeAo+ICogVmFyaW91cyBmaXhlcyBmb3IgdGhlIHB2cmRtYSBkZXZpY2UKPgo+LS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
S2FtYWwgSGVpYiAoMSk6Cj4gICAgICBkb2NzL3B2cmRtYTogVXBkYXRlIHJkbWFjbS1tdXggZG9j
dW1lbnRhdGlvbgo+Cj5MaSBRaWFuZyAoMSk6Cj4gICAgICBodzogcmRtYTogZml4IGFuIG9mZi1i
eS1vbmUgaXNzdWUKPgo+TWFyY2VsIEFwZmVsYmF1bSAoMyk6Cj4gICAgICBjb250cmliL3JkbWFj
bS1tdXg6IHJlbW92ZSBXbm8tZm9ybWF0LXRydW5jYXRpb24gZmxhZwo+ICAgICAgaHcvcmRtYTog
bW9kaWZ5IHN0cnVjdCBpbml0aWFsaXphdGlvbgo+ICAgICAgY29udHJpYi9yZG1hY20tbXV4OiBm
aXggY2xhbmcgY29tcGlsYXRpb24KPgo+WXV2YWwgU2hhaWEgKDUpOgo+ICAgICAgaHcvcHZyZG1h
OiBSZW1vdmUgbWF4LXNnZSBjb21tYW5kLWxpbmUgcGFyYW0KPiAgICAgIGh3L3JkbWE6IERlbGV0
ZSB1bnVzZWQgc3RydWN0IG1lbWJlcgo+ICAgICAgaHcvcHZyZG1hOiBQb3N0IENRRSB3aGVuIHJl
Y2VpdmUgaW52YWxpZCBnaWQgaW5kZXgKPiAgICAgIGh3L3B2cmRtYTogTWFrZSBmdW5jdGlvbiBw
dnJkbWFfcXBfc2VuZC9yZWN2IHJldHVybiB2b2lkLgo+ICAgICAgaHcvcmRtYTogVmVyaWZ5IHRo
YXQgcHRyIGlzIG5vdCBOVUxMIGJlZm9yZSBmcmVlaW5nCj4KPiBNYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAyICsrCj4gY29udHJpYi9yZG1hY20tbXV4L01ha2VmaWxlLm9ianMg
fCAgMSAtCj4gY29udHJpYi9yZG1hY20tbXV4L21haW4uYyAgICAgICAgfCAxMiArKysrLS0tLQo+
IGRvY3MvcHZyZG1hLnR4dCAgICAgICAgICAgICAgICAgIHwgIDQgKystCj4gaHcvcmRtYS9yZG1h
X2JhY2tlbmQuYyAgICAgICAgICAgfCA2MyArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4gaHcvcmRtYS9yZG1hX2JhY2tlbmQuaCAgICAgICAgICAgfCAxMiArKysrKysr
Kwo+IGh3L3JkbWEvcmRtYV9iYWNrZW5kX2RlZnMuaCAgICAgIHwgIDEgLQo+IGh3L3JkbWEvcmRt
YV9ybS5jICAgICAgICAgICAgICAgIHwgIDkgKysrKy0tCj4gaHcvcmRtYS92bXcvcHZyZG1hX21h
aW4uYyAgICAgICAgfCAxMCArKystLS0tCj4gaHcvcmRtYS92bXcvcHZyZG1hX3FwX29wcy5jICAg
ICAgfCA0NCArKysrKysrKysrKysrKysrKysrKystLS0tLS0tCj4gaHcvcmRtYS92bXcvcHZyZG1h
X3FwX29wcy5oICAgICAgfCAgNCArLS0KPiAxMSBmaWxlcyBjaGFuZ2VkLCA5NiBpbnNlcnRpb25z
KCspLCA2NiBkZWxldGlvbnMoLSkKPi0tIAo+Mi4xNy4xCg==
