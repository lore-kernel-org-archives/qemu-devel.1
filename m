Received: from eggs.gnu.org ([2001:4830:134:3::10]:45390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fP2w1-0001TW-32
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 05:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fP2vx-0006Tx-Vc
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 05:34:53 -0400
Received: from m15-57.126.com ([220.181.15.57]:36775)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fP2vx-0006BD-9O
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 05:34:49 -0400
Date: Sat, 2 Jun 2018 17:34:38 +0800 (CST)
From: "Chen Hanxiao" <chen_han_xiao@126.com>
In-Reply-To: <9e9ef45c-25e4-6518-d353-5834cea0eef6@redhat.com>
References: <20180601165750.25420-1-chen_han_xiao@126.com>
	<20180601165750.25420-3-chen_han_xiao@126.com>
	<9e9ef45c-25e4-6518-d353-5834cea0eef6@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <180c974f.2c2c.163bfd9497d.Coremail.chen_han_xiao@126.com>
Subject: Re: [Qemu-devel] [PATCH v5.1 2/2] qga-win: add driver path usage to
 GuestFilesystemInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

CkF0IDIwMTgtMDYtMDIgMDE6MTU6MTQsICJFcmljIEJsYWtlIiA8ZWJsYWtlQHJlZGhhdC5jb20+
IHdyb3RlOgo+T24gMDYvMDEvMjAxOCAxMTo1NyBBTSwgQ2hlbiBIYW54aWFvIHdyb3RlOgo+PiBG
cm9tOiBDaGVuIEhhbnhpYW8gPGNoZW5oYW54aWFvQGdtYWlsLmNvbT4KLi4uCj4+ICAgICAgICAg
ICBmcy0+bW91bnRwb2ludCA9IGdfc3RyZHVwKCJTeXN0ZW0gUmVzZXJ2ZWQiKTsKPj4gICAgICAg
fSBlbHNlIHsKPj4gICAgICAgICAgIGZzLT5tb3VudHBvaW50ID0gZ19zdHJuZHVwKG1udF9wb2lu
dCwgbGVuKTsKPj4gKyAgICAgICAgaWYgKEdldERpc2tGcmVlU3BhY2VFeChmcy0+bW91bnRwb2lu
dCwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoUFVMQVJHRV9JTlRFR0VSKSAm
IGk2NEZyZWVCeXRlc1RvQ2FsbGVyLAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IChQVUxBUkdFX0lOVEVHRVIpICYgaTY0VG90YWxCeXRlcywKPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAoUFVMQVJHRV9JTlRFR0VSKSAmIGk2NEZyZWVCeXRlcykpIHsKPj4gKyAg
ICAgICAgICAgIGZzLT51c2VkX2J5dGVzID0gaTY0VG90YWxCeXRlcyAtIGk2NEZyZWVCeXRlczsK
Pj4gKyAgICAgICAgICAgIGZzLT50b3RhbF9ieXRlcyA9IGk2NFRvdGFsQnl0ZXM7Cj4+ICsgICAg
ICAgICAgICBmcy0+aGFzX3RvdGFsX2J5dGVzID0gdHJ1ZTsKPj4gKyAgICAgICAgICAgIGZzLT5o
YXNfdXNlZF9ieXRlcyA9IHRydWU7Cj4+ICsgICAgICAgIH0KPgo+SSdtIGxlc3MgZmFtaWxpYXIg
d2l0aCBXaW5kb3dzIEFQSSwgc28gSSB3b24ndCBnaXZlIHRoaXMgUi1iLiBCdXQgbm93IAo+dGhh
dCBJIHJlYWQgdGhpcyBwYXRjaCwgSSBkbyBoYXZlIGEgcXVlc3Rpb246IHNpbmNlIGJvdGggc3Rh
dHZmcygpIGFuZCAKPkdldERpc2tGcmVlU3BhY2VFeCgpIGdpdmUgeW91IGZyZWUgYnl0ZXMgcmF0
aGVyIHRoYW4gdXNlZCBieXRlcywgYW5kIHlvdSAKPmhhZCB0byBwZXJmb3JtIGEgc3VidHJhY3Rp
b24gdG8gcmVwb3J0ICd1c2VkLWJ5dGVzJyBvdmVyIFFHQSwgd291bGQgaXQgCj5tYWtlIGFueSBt
b3JlIHNlbnNlIHRvIGluc3RlYWQgcmVwb3J0ICdmcmVlLWJ5dGVzJyBvdmVyIFFHQSBmb3IgbGVz
cyAKPnN1YnRyYWN0aW9uIHdvcmsgb24geW91ciBlbmQgYW5kIHNvIHRoYXQgdGhlIFFHQSBpbnRl
cmZhY2UgaXMgbW9yZSAKPnNpbWlsYXIgdG8gZXhpc3RpbmcgaW50ZXJmYWNlcz8KPgoKCkFsbCBi
dWlsZC1pbiB0b29scyByZXBvcnQgdXNlZC1ieXRlcyBmb3IgbGludXggYW5kIHdpbmRvd3MuCgpG
b3Igd2luZG93cywgR2V0RGlza0ZyZWVTcGFjZUV4IHdvdWxkIHRlbGwgdG90YWwgYW5kIGZyZWUg
Ynl0ZXMsCnVzZWQgYnl0ZXMgaXMgIHRvdGFsIC0gZnJlZSwgIHdoaWNoIGlzIGV4YWN0bHkgc2Ft
ZQpmcm9tIHRoZSB2aWV3IG9mIGRpc2sgcHJvcGVydGllcy4KCkJ1dCBmb3IgbGludXgsIGRmKDEp
IGRvIHNvbWUgY2FsY3VsYXRpb24gZm9yIHNob3dpbmcgdXNlZC1ieXRlcyBhbmQgZnJlZS1ieXRl
cy4KCmRmKDEpIHRha2VzIGZfYmxvY2tzIC0gZl9iZnJlZSBmb3IgJ1VzZWQnICwKd2hpY2ggdGFr
ZSAnVXNlZCcgKyAnQXZhaWxhYmxlJyhmX2JhdmFpbCkgIGZvciBub24tcm9vdCB0b3RhbCwgCndo
aWNoIGlzIGRpZmZlcmVudCBmcm9tICdTaXplJyhmX2Jsb2Nrcyk7ClRoZW4gY2FsY3VsYXRlICAn
VXNlJScgYnkgVXNlZCAvIG5vbi1yb290LXRvdGFsLgoKSWYgd2Ugd2FudCBnZXQgd2hhdCBkZigz
KSBvdXRwdXRzLCB3ZSBtdXN0IHJlcG9ydCBtb3JlIG1lbWJlcnMgb2Ygc3RydWN0IHN0YXR2ZnMg
IGZyb20gU1RBVFZGUygzKSAsCndoaWNoIHdpbmRvd3MgZG9lcyBub3QgbmVlZCBpdC4KQW5kIGNs
aWVudCBoYWQgdG8gZG8gc29tZSBjYWxjdWxhdGlvbiB3aXRoIGlmLWVsc2UgZGVhbGluZyB3aXRo
IGRhdGEgZnJvbSB3aW5kb3dzL2xpbnV4LgoKQ3VzdG9tcyB1c3VhbGx5IHRha2UgJ1VzZSUnIHRv
IG1vbml0b3IgdGhlaXIgZGlza3MsCnNvIEkgdGhpbmsgd2Ugc2hvdWxkIHJlcG9ydCBudW1zIHRo
YXQgY2FuIGVhc2lseSBnZXQgdGhlIHJpZ2h0IHBlcmNlbnRhZ2Ugb2YgdXNhZ2UgZnJvbSBpdCwK
Zm9yIGJvdGggbGludXggYW5kIHdpbmRvd3MuCgpSZWdhcmRzLAotIENoZW4K
