Received: from eggs.gnu.org ([2001:4830:134:3::10]:51909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <you-hero@126.com>) id 1dAaOs-0000o5-14
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <you-hero@126.com>) id 1dAaOq-0003Ke-R6
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:12:22 -0400
Date: Tue, 16 May 2017 18:41:19 +0800 (CST)
From: =?GBK?B?zuLWvtPC?= <you-hero@126.com>
In-Reply-To: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Message-ID: <1ebb7cca.a83b.15c10d90dcc.Coremail.you-hero@126.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH v4 0/6] COLO block replication supports
 shared disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, qemu-block@nongnu.org, zhangchen.fnst@cn.fujitsu.com, eddie.dong@intel.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

SEmjrCBIYWkgTGlhbmcKCgpJcyB0aGVyZSByZWNlbnRseSBhbnkgcGxhbiB0byBwb3N0IGxpYnZp
cnQgc3VwcG9ydCBmb3IgQ09MTyBmZWF0dXJlPwoKClJlZ2FyZHMsCgoKWmhpIFlvbmcgV3UKCgpB
dCAyMDE3LTA0LTEyIDIyOjA1OjE1LCAiemhhbmdoYWlsaWFuZyIgPHpoYW5nLnpoYW5naGFpbGlh
bmdAaHVhd2VpLmNvbT4gd3JvdGU6Cj5DT0xPIGJsb2NrIHJlcGxpY2F0aW9uIGRvZXNuJ3Qgc3Vw
cG9ydCB0aGUgc2hhcmVkIGRpc2sgY2FzZSwKPkhlcmUgd2UgdHJ5IHRvIGltcGxlbWVudCBpdCBh
bmQgdGhpcyBpcyB0aGUgNHRoIHZlcnNpb24uCj4KPlBsZWFzZSByZXZpZXcgYW5kIGFueSBjb21t
aXRzIGFyZSB3ZWxjb21lZC4KPgo+Q2M6IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgKGdpdCkgPGRn
aWxiZXJ0QHJlZGhhdC5jb20+Cj5DYzogZWRkaWUuZG9uZ0BpbnRlbC5jb20KPgo+djQ6Cj4tIEFk
ZCBwcm9wZXIgY29tbWVudCBmb3IgcHJpbWFyeV9kaXNrIGluIHBhdGNoIDIgKFN0ZWZhbikKPi0g
Q2FsbCBiZHJ2X2ludmFsaWRhdGVfY2FjaGUoKSB3aGlsZSBkbyBjaGVja3BvaW50IGZvciBzaGFy
ZWQgZGlzayBpbiBwYXRjaCA1Cj4KPnYzOgo+LSBGaXggc29tZSBjb21tZW50cyBmcm9tIFN0ZWZh
biBhbmQgRXJpYwo+Cj52MjoKPi0gRHJvcCB0aGUgcGF0Y2ggd2hpY2ggYWRkIGEgYmxrX3Jvb3Qo
KSBoZWxwZXIKPi0gRml4IHNvbWUgY29tbWVudHMgZnJvbSBDaGFuZ2xvbmcKPgo+emhhbmdoYWls
aWFuZyAoNik6Cj4gIGRvY3MvYmxvY2stcmVwbGljYXRpb246IEFkZCBkZXNjcmlwdGlvbiBmb3Ig
c2hhcmVkLWRpc2sgY2FzZQo+ICByZXBsaWNhdGlvbjogYWRkIHNoYXJlZC1kaXNrIGFuZCBzaGFy
ZWQtZGlzay1pZCBvcHRpb25zCj4gIHJlcGxpY2F0aW9uOiBTcGxpdCBvdXQgYmFja3VwX2RvX2No
ZWNrcG9pbnQoKSBmcm9tCj4gICAgc2Vjb25kYXJ5X2RvX2NoZWNrcG9pbnQoKQo+ICByZXBsaWNh
dGlvbjogZml4IGNvZGUgbG9naWMgd2l0aCB0aGUgbmV3IHNoYXJlZF9kaXNrIG9wdGlvbgo+ICBy
ZXBsaWNhdGlvbjogSW1wbGVtZW50IGJsb2NrIHJlcGxpY2F0aW9uIGZvciBzaGFyZWQgZGlzayBj
YXNlCj4gIG5iZC9yZXBsaWNhdGlvbjogaW1wbGVtZW50IC5iZHJ2X2dldF9pbmZvKCkgZm9yIG5i
ZCBhbmQgcmVwbGljYXRpb24KPiAgICBkcml2ZXIKPgo+IGJsb2NrL25iZC5jICAgICAgICAgICAg
ICAgIHwgIDEyICsrKwo+IGJsb2NrL3JlcGxpY2F0aW9uLmMgICAgICAgIHwgMTk4ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+IGRvY3MvYmxvY2stcmVwbGlj
YXRpb24udHh0IHwgMTM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KPiBxYXBpL2Js
b2NrLWNvcmUuanNvbiAgICAgICB8ICAxMCArKy0KPiA0IGZpbGVzIGNoYW5nZWQsIDMwNiBpbnNl
cnRpb25zKCspLCA1MyBkZWxldGlvbnMoLSkKPgo+LS0gCj4xLjguMy4xCj4KPgo+Cg==
