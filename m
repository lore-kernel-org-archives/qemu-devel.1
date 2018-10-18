Received: from eggs.gnu.org ([2001:4830:134:3::10]:58523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gD5mI-0005tM-Fa
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gD5mF-0003Vy-6y
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:43:42 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:51362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1gD5mE-0003Qe-RE
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:43:39 -0400
Date: Thu, 18 Oct 2018 18:43:19 +0800 (CST)
Message-ID: <201810181843190635824@zte.com.cn>
In-Reply-To: <99cf25d1-3a3a-085e-8012-0a3fd8914779@redhat.com>
References: 201810181603210927379@zte.com.cn,
	99cf25d1-3a3a-085e-8012-0a3fd8914779@redhat.com
Mime-Version: 1.0
From: <peng.hao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_V6_3/5=5D_target-i386=3A_add_rtc?=
 =?utf-8?q?_0x70_port_as_coalesced=5Fpio?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: rkrcmar@redhat.com, mst@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

Pk9uIDE4LzEwLzIwMTggMTA6MDMsIHBlbmcuaGFvMkB6dGUuY29tLmNuIHdyb3RlOgo+Pj4+ICsg
ICAgLyogcmVnaXN0ZXIgcnRjIDB4NzAgcG9ydCBhcyBjb2FsZXNjZWRfcGlvICovCj4+Pj4gKyAg
ICBtZW1vcnlfcmVnaW9uX3NldF9mbHVzaF9jb2FsZXNjZWQoJnMtPmlvKTsKPj4+PiArICAgIG1l
bW9yeV9yZWdpb25faW5pdF9pbygmcy0+Y29hbGVzY2VkX2lvLCBPQkpFQ1QocyksICZjbW9zX29w
cywKPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICBzLCAicnRjMSIsIDEpOwo+Pj4+ICsg
ICAgaXNhX3JlZ2lzdGVyX2lvcG9ydChpc2FkZXYsICZzLT5jb2FsZXNjZWRfaW8sIGJhc2UpOwo+
Pj4gSSB0aGluayBpbnN0ZWFkIG9mIGlzYV9yZWdpc3Rlcl9pb3BvcnQgeW91IGNhbiB1c2UKPj4+
IG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbiwgc28gdGhhdCBzLT5jb2FsZXNjZWRfaW8gaXMg
YWRkZWQgYmVsb3cgcy0+aW8/Cj4+Pgo+PiBpc2FfcmVnaXN0ZXJfaW9wb3J0IGFsc28gY2FsbGVk
IG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbi4KPj4gbW9kaWZ5IGNvZGUgIGxpa2UgdGhpczoK
Pj4gICAvL2lzYV9yZWdpc3Rlcl9pb3BvcnQoaXNhZGV2LCAmcy0+Y29hbGVzY2VkX2lvLCBiYXNl
KTsKPj4gICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihnZXRfc3lzdGVtX2lvKCksMHg3
MCwmcy0+Y29hbGVzY2VkX2lvKTsKPj4gVGhlIHJlZ2lvbmFsIGRpc3RyaWJ1dGlvbiBiZWZvcmUg
YW5kIGFmdGVyIGNvZGUgbW9kaWZpY2F0aW9uIGlzIGNvbnNpc3RlbnQuCj4KPlJpZ2h0LCBidXQg
SSdkIHJhdGhlciBhZGQgcy0+Y29hbGVzY2VkX2lvIHN1YnJlZ2lvbiBhcyBhIHN1YnJlZ2lvbiBv
Zgo+cy0+aW8gYXQgb2Zmc2V0IDAuCk9r77yMIEkgd2lsbCBtb2RpZnkgaXQgYW5kIHJlc3VibWl0
IHRoZSBwYXRjaC4KQnkgdGhlIHdheSAsIEkgZmluZCB0aGF0ICB3aGVuIEkgYWRqdXN0ZWQgdGhl
IGZvcm1hdCBvZiB0aGUgcGF0Y2ggIlBBVENIIFY2IDEvNSIsIEkgbWFkZSBhIG1pc3Rha2UgdG8g
bW9kaWZ5IGEgY29kZSBjaGFyYWN0ZXIuIEkgYWxzbyByZXN1Ym1pdCB0aGUgcGF0Y2guClRoYW5r
cy4KPgo+UGFvbG8KPgo+PiAgICAwMDAwMDAwMDAwMDAwMDcwLTAwMDAwMDAwMDAwMDAwNzAgKHBy
aW8gMCwgaS9vKTogcnRjMQo+PiAgICAgMDAwMDAwMDAwMDAwMDA3MC0wMDAwMDAwMDAwMDAwMDcx
IChwcmlvIDAsIGkvbyk6IHJ0Yw==
