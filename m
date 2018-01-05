Received: from eggs.gnu.org ([2001:4830:134:3::10]:35066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eXHgc-00081l-Aj
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 21:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eXHgY-0001lu-S4
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 21:24:46 -0500
Received: from m15-47.126.com ([220.181.15.47]:38886)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eXHgX-0001bs-Ho
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 21:24:42 -0500
Date: Fri, 5 Jan 2018 09:53:45 +0800 (CST)
From: "Chen Hanxiao" <chen_han_xiao@126.com>
In-Reply-To: <20171216073417.29847-1-chen_han_xiao@126.com>
References: <20171216073417.29847-1-chen_han_xiao@126.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <2f94e1ab.1ccd.160c4062532.Coremail.chen_han_xiao@126.com>
Subject: Re: [Qemu-devel] [PATCH] qga: unset frozen state if no mount points
 are frozen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

CgpBdCAyMDE3LTEyLTE2IDE1OjM0OjE3LCAiQ2hlbiBIYW54aWFvIiA8Y2hlbl9oYW5feGlhb0Ax
MjYuY29tPiB3cm90ZToKPkZyb206IENoZW4gSGFueGlhbyA8Y2hlbmhhbnhpYW9AZ21haWwuY29t
Pgo+Cj5JZiB3ZSBzZXQgbW91bnRwb2ludHMgdG8gcW1wX2d1ZXN0X2ZzZnJlZXplX2ZyZWV6ZV9s
aXN0LAo+d2UgbWF5IGdvdCBub3RoaW5nIHRvIGZyZWV6ZSBhcyBhbGwgbW91bnRwb2ludHMgYXJl
Cj5ub3QgdmFsaWQuCj5DYWxsIGdhX3Vuc2V0X2Zyb3plbiBpbiB0aGlzIHNlbmFyaW8uCj4KPkNj
OiBNaWNoYWVsIFJvdGggPG1kcm90aEBsaW51eC52bmV0LmlibS5jb20+Cj5TaWduZWQtb2ZmLWJ5
OiBDaGVuIEhhbnhpYW8gPGNoZW5oYW54aWFvQGdtYWlsLmNvbT4KPi0tLQo+IHFnYS9jb21tYW5k
cy1wb3NpeC5jIHwgNiArKysrKysKPiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4K
PmRpZmYgLS1naXQgYS9xZ2EvY29tbWFuZHMtcG9zaXguYyBiL3FnYS9jb21tYW5kcy1wb3NpeC5j
Cj5pbmRleCBlODA5ZTM4MmViLi45ZmQ1MWYxZDdhIDEwMDY0NAo+LS0tIGEvcWdhL2NvbW1hbmRz
LXBvc2l4LmMKPisrKyBiL3FnYS9jb21tYW5kcy1wb3NpeC5jCj5AQCAtMTI3Myw2ICsxMjczLDEy
IEBAIGludDY0X3QgcW1wX2d1ZXN0X2ZzZnJlZXplX2ZyZWV6ZV9saXN0KGJvb2wgaGFzX21vdW50
cG9pbnRzLAo+ICAgICB9Cj4gCj4gICAgIGZyZWVfZnNfbW91bnRfbGlzdCgmbW91bnRzKTsKPisg
ICAgLyogV2UgbWF5IG5vdCBpc3N1ZSBhbnkgRklGUkVFWkUgaGVyZSB3aGVuIGhhZCBtb3VudHBv
aW50cy4KPisgICAgICogSnVzdCB1bnNldCBnYV9zdGF0ZSBoZXJlIGFuZCByZWFkeSBmb3IgdGhl
IG5leHQgY2FsbC4KPisgICAgICovCj4rICAgIGlmIChoYXNfbW91bnRwb2ludHMgJiYgaSA9PSAw
KSB7Cj4rICAgICAgICBnYV91bnNldF9mcm96ZW4oZ2Ffc3RhdGUpOwo+KyAgICB9Cj4gICAgIHJl
dHVybiBpOwo+IAo+IGVycm9yOgo+LS0gCgpIaSwKICAgQW55IGNvbW1lbnRzPwoKUmVnYXJkcywK
LSBDaGVuCg==
