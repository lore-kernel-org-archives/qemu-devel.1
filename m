Received: from eggs.gnu.org ([2001:4830:134:3::10]:52451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangqian@sangfor.com.cn>) id 1cOLrn-0002gx-Ls
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangqian@sangfor.com.cn>) id 1cOLrk-00052l-Kh
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:58:51 -0500
Received: from m129-177.yeah.net ([123.58.177.129]:18415)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangqian@sangfor.com.cn>) id 1cOLrj-00050b-UI
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:58:48 -0500
Message-ID: <AOAA8gA7ALBQysnC4XRVtKo3.3.1483437512378.Hmail.zhangqian@sangfor.com.cn>
In-Reply-To: <601a7b61-d7b8-57b2-af41-c7c6d89bcef1@redhat.com>
MIME-Version: 1.0
From: Zhang Qian <zhangqian@sangfor.com.cn>
Date: Tue, 3 Jan 2017 17:58:32 +0800 (GMT+08:00)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH=5D_scsi-disk=3A_fix_crash_on_VER?=
 =?utf-8?q?IFY_command?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

CkF0IDIwMTctMDEtMDMgMTc6Mzg6NDksIFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4KPk9uIDAzLzAxLzIwMTcgMDk6MTIsIFpoYW5nIFFpYW4gd3JvdGU6Cj4+
IHllcywgeW91IGFyZSByaWdodC4KPj4gVGhlIHNjZW5hcmlvcyBvZiBwcm9ibGVtIGlzCj4+IGEg
c2NzaS1kaXNrIG9iamVjdCByZWNlaXZlcyBWRVJJRlkgY29tbWFuZCB3aXRoIEJZVENISyBiaXQg
YmVpbmcgemVybywKPj4gc2NzaV9ibG9ja19pc19wYXNzdGhyb3VnaCByZXR1cm5zIGZhbHNlIGFu
ZCBmaW5hbGx5IHNjc2ktYmxvY2sgdXNlcwo+PiBzY3NpX2Rpc2tfZG1hX2NvbW1hbmQgZm9yCj4+
IFZFUklGWS4gU28gdGhlIG1vZGUgaXMgc2V0IHRvIFNDU0lfWEZFUl9OT05FLgo+PiBJbiBzY3Np
X3JlcV9jb250aW51ZSwgc2NzaV9yZWFkX2RhdGEgZnVuY3Rpb24gaXMgY2FsbGVkLgo+Cj5VaG0s
IGlzIHRoZSBmaXggc2ltcGx5Cj4KPmRpZmYgLS1naXQgYS9ody9zY3NpL3Njc2ktZGlzay5jIGIv
aHcvc2NzaS9zY3NpLWRpc2suYwo+aW5kZXggYmRkMWU1Zi4uYzA4MDg4OCAxMDA2NDQKPi0tLSBh
L2h3L3Njc2kvc2NzaS1kaXNrLmMKPisrKyBiL2h3L3Njc2kvc2NzaS1kaXNrLmMKPkBAIC0yNzAx
LDcgKzI3MDEsNyBAQCBzdGF0aWMgYm9vbCBzY3NpX2Jsb2NrX2lzX3Bhc3N0aHJvdWdoKFNDU0lE
aXNrU3RhdGUgKnMsIHVpbnQ4X3QgKmJ1ZikKPiAgICAgICAgICAqIGZvciB0aGUgbnVtYmVyIG9m
IGxvZ2ljYWwgYmxvY2tzIHNwZWNpZmllZCBpbiB0aGUgbGVuZ3RoCj4gICAgICAgICAgKiBmaWVs
ZCkuICBGb3Igb3RoZXIgbW9kZXMsIGRvIG5vdCB1c2Ugc2NhdHRlci9nYXRoZXIgb3BlcmF0aW9u
Lgo+ICAgICAgICAgICovCj4tICAgICAgICBpZiAoKGJ1ZlsxXSAmIDYpICE9IDIpIHsKPisgICAg
ICAgIGlmICgoYnVmWzFdICYgNikgPT0gMikgewo+ICAgICAgICAgICAgIHJldHVybiBmYWxzZTsK
PiAgICAgICAgIH0KPiAgICAgICAgIGJyZWFrOwo+Cj50aGVuPwoKCkkgdmVyaWZpZWQgeW91ciBw
YXRjaCwgaXQgaXMgb2suCgoKYnV0ICB3aHkgbm90IHVzZSAoYnVmWzFdICYgMikgPT0gMiAgPwoK
Cj5UaGFua3MsCj4KPlBhb2xvCgoKDQoNCg==
