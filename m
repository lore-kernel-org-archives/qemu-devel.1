Received: from eggs.gnu.org ([2001:4830:134:3::10]:59100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yin.zuowei@zte.com.cn>) id 1cywsY-0004oB-QL
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yin.zuowei@zte.com.cn>) id 1cywsV-0004mr-KZ
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:46:54 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:36959)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yin.zuowei@zte.com.cn>) id 1cywsT-0004eP-RJ
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:46:51 -0400
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
	by mse01.zte.com.cn with ESMTP id v3E8kKeC058304
	for <qemu-devel@nongnu.org>; Fri, 14 Apr 2017 16:46:20 +0800 (GMT-8)
	(envelope-from yin.zuowei@zte.com.cn)
Date: Fri, 14 Apr 2017 16:46:21 +0800 (CST)
Message-ID: <201704141646219600739@zte.com.cn>
Mime-Version: 1.0
From: <yin.zuowei@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: [Qemu-devel] =?utf-8?q?=5BBUG=5D_network_=3A_windows_os_lost_ip_a?=
 =?utf-8?q?ddress_of_the_network_card_=C2=A0in_some_cases?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

d2UgIGZvdW5kIHRoaXMgcHJvYmxlbSBmb3IgYSBsb25nIHRpbWUg44CCRm9yIGV4YW1wbGUsIGlm
IHdlIGhhcyB0aHJlZSBuZXR3b3JrIGNhcmQgaW4gdmlydHVhbCB4bWwgZmlsZSDvvIxzdWNoIGFz
ICJuZXR3b3JrIGNvbm5lY3Rpb24gMSIgLyAibmV0d29yayBjb25uZWN0aW9uIDIiLyJuZXR3b3Jr
IGNvbm5lY3Rpb24gMyIg44CCDQoNCkVjaG8gbmV0d29yayBjYXJkIGhhcyBvd24gaXAgYWRkcmVz
cyDvvIxzdWNoIGFzIDE5Mi4xNjguMS4xIC8gMi4xIC8zLjEgLCB3aGVuIGRlbGV0ZSB0aGUgZmly
c3QgY2FyZCDvvIxyZWJvb3QgdGhlIHdpbmRvd3MgdmlydHVhbCBvcywgdGhlbiB0aGlzIHByb2Js
ZW0gaGFwcGVuZWQgIQ0KDQoNCg0KDQp3ZSBmb3VuZCB0aGF0IHRoZSBzZW5jb25kIG5ldHdvcmsg
Y2FyZCB3aWxsICByZXBsYWNlIHRoZSBmaXJzdCBvbmUgLCB0aGVuIHRoZSBpcCBhZGRyZXNzIG9m
ICJuZXR3b3JrIGNvbm5lY3Rpb24gMiAiIGJlY29tZSAxOTIuMTY4LjEuMSDjgIINCg0KDQpPdXIg
dGhpcmQgcGFydHkgdXNlcnMgYmVnYW4gdG8gY29tcGxhaW4gYWJvdXQgdGhpcyBidWcg44CCQWxs
IHRoZSBidXNpbmVzcyBvZiB0aGUgc2Vjb25kIGlwICBsb3N0ICEhISANCg0KSSBtZWFuIGJvdGgg
b2Ygd2luZG93cyBhbmQgbGludXggaGFzIHRoaXMgYnVnICwgIHdlIHNvbHZlIHRoaXMgYnVnIGlu
IGxpbnV4ICB0aHJvdWdodCBib25kaW5nIG5ldGNyYWQgcGNpIGFuZCBtYWMgYWRkcmVzcyDjgIIN
Cg0KVGhlcmUgaXMgbm8gZ29vZCBzb2x1dGlvbiBvbiB3aW5kb3dzIG9zIC4gdGhlcmEgYXJlID8g
IHdlIGltcGxlbWVudGVkIGEgcGxhbiB0byByZXN1bXB0aW9uIG9mIElQIGJ5IFFHQS4gIElzIHRo
ZXJlIGEgYmV0dGVyIHdheSA/
