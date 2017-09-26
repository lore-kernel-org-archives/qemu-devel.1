Received: from eggs.gnu.org ([2001:4830:134:3::10]:38300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1dwjFO-0008E5-RT
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1dwjFK-0007SK-U1
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:21:34 -0400
Received: from m15-6.126.com ([220.181.15.6]:61013)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1dwjFK-0007OV-1w
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:21:30 -0400
Date: Tue, 26 Sep 2017 13:50:41 +0800 (CST)
From: "Chen Hanxiao" <chen_han_xiao@126.com>
In-Reply-To: <1506048366-23368-1-git-send-email-chen_han_xiao@126.com>
References: <1506048366-23368-1-git-send-email-chen_han_xiao@126.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <29f25ba0.5820.15ebcbcc43e.Coremail.chen_han_xiao@126.com>
Subject: Re: [Qemu-devel] [PATCH] qga-win: don't hang if vss hold writes
 timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: tomoki.sekiyama@gmail.com, qemu-devel@nongnu.org, Chen Hanxiao <chen_han_xiao@126.com>

CkF0IDIwMTctMDktMjIgMTA6NDY6MDYsICJDaGVuIEhhbnhpYW8iIDxjaGVuX2hhbl94aWFvQDEy
Ni5jb20+IHdyb3RlOgo+RnJvbTogQ2hlbiBIYW54aWFvIDxjaGVuaGFueGlhb0BnbWFpbC5jb20+
Cj4KPldoZW4gVk0gaXMgaW4gYSBoZWF2eSBJTywgaWYgdGhlIGNvbW1hbmQgImd1ZXN0LWZzZnJl
ZXplLWZyZWV6ZSIKPmlzIGV4ZWN1dGVkLCBWU1MgbWF5IHRpbWVvdXQgd2hlbiB0cnlpbmcgdG8g
aG9sZCB3cml0ZXMuCj4KPkluc2lkZSBndWVzdCwgRXZlbnQgSUQgMTIyOTgoVlNTX0VSUk9SX0hP
TERfV1JJVEVTX1RJTUVPVVQpCj5pcyBsb2dnZWQgaW4gdGhlIEV2ZW50IFZpZXdlci4KPgo+QXQg
dGhhdCB0aW1lLCBpZiB3ZSBjYWxsIEFib3J0QmFja3VwLCBxZ2EgbWF5IGhhbmcgZm9yZXZlci4K
Pgo+VGhpcyBwYXRjaCB3aWxsIHNvbHZlIHRoaXMgaXNzdWVzLgo+Cj5TaWduZWQtb2ZmLWJ5OiBD
aGVuIEhhbnhpYW8gPGNoZW5oYW54aWFvQGdtYWlsLmNvbT4KCkhpLCBNaWNoYWVsCgogQW55IGNv
bW1lbnRzPwoKaHR0cDovL2xpc3RzLm5vbmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwv
MjAxNy0wOS9tc2cwNjE5OS5odG1sCgpSZWdhcmRzLAotIENoZW4=
