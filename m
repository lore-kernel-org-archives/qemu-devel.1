Received: from eggs.gnu.org ([2001:4830:134:3::10]:40003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXgu4-0006oC-Qx
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXgu0-00074s-29
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:48:04 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:35864)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXgtz-00074Q-6g
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:47:59 -0400
Date: Wed, 19 Jul 2017 12:47:53 +0800 (CST)
Message-ID: <201707191247531805742@zte.com.cn>
References: 1500342577-12486-1-git-send-email-wang.yi59@zte.com.cn,
	20170718232551.GE8345@localhost.localdomain
Mime-Version: 1.0
From: <wang.yi59@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_v2=5D_hmp=3A_allow_cpu_index_for?=
 =?utf-8?q?_=22info_lapic=22?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, dgilbert@redhat.com, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn, wang.yi59@zte.com.cn

SGkgRWR1YXJkbywNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5IQ0KDQo+T24gTW9uLCBKdWwg
MTcsIDIwMTcgYXQgMDk6NDk6MzdQTSAtMDQwMCwgWWkgV2FuZyB3cm90ZToNCg0KPj4gQWRkIFt2
Y3B1XSBpbmRleCBzdXBwb3J0IGZvciBobXAgY29tbWFuZCAiaW5mbyBsYXBpYyIsIHdoaWNoIGlz
DQoNCj4+IHVzZWZ1bCB3aGVuIGRlYnVnZ2luZyBpcGkgYW5kIHNvIG9uLiBDdXJyZW50IGJlaGF2
aW9yIGlzIG5vdA0KDQo+PiBjaGFuZ2VkIHdoZW4gdGhlIHBhcmFtZXRlciBpc24ndCBzcGVjaWZp
ZWQuDQoNCj4+IA0KDQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBXYW5nIDx3YW5nLnlpNTlAenRlLmNv
bS5jbj4NCg0KPj4gU2lnbmVkLW9mZi1ieTogWXVuIExpdSA8bGl1Lnl1bmhAenRlLmNvbS5jbj4N
Cg0KPg0KDQo+V2UgaGF2ZSA4IG1vbml0b3IgY29tbWFuZHMgKHNlZSBiZWxvdykgdGhhdCB1c2Ug
dGhlIENQVSBzZXQgYnkNCg0KPnRoZSAiY3B1IiBjb21tYW5kIChtb25fZ2V0X2NwdSgpKSBhcyBp
bnB1dC4gIFdoeSBpcyAiaW5mbyBsYXBpYyINCg0KPnNwZWNpYWw/DQoNCldoZW4gd2UgZGVidWdn
aW5nIGEgcHJvYmxlbSBvZiBpcGksIHdlIHdhbnRlZCB0byB2ZXJpZnkgbGFwaWMgaW5mbw0KDQpv
biBlYWNoIHZDUFUsIGJ1dCB3ZSBmb3VuZCB0aGF0IHdlIGNvdWxkIG9ubHkgZ2V0IHZDUFUgMCdz
IGxhcGljDQoNCnRocm91Z2ggImluZm8gbGFwaWMiLCBzbyB3ZSBzdXBwb3NlZCB0aGlzIHBhdGNo
IGNvdWxkIGhlbHAgdGhvc2UNCg0Kd2hvIGhhdmUgdGhlIHNhbWUgcHJvYmxlbSBhcyB1cy4NCg0K
DQoNCg0KPg0KDQo+KiBpbmZvIGNwdXN0YXRzDQoNCj4qIGluZm8gbGFwaWMNCg0KPiogaW5mbyBt
ZW0NCg0KPiogaW5mbyByZWdpc3RlcnMNCg0KPiogaW5mbyB0bGINCg0KPiogeA0KDQo+KiBtZW1z
YXZlDQoNCj4qIGluamVjdC1ubWkgKFFNUCkNCg0KTW9uaXRvciBjb21tYW5kICJpbmZvIHJlZ2lz
dGVycyIgYWxyZWFkeSBoYXZlICItYSIgcGFyYW1ldGVyIHRvDQoNCnNob3cgYWxsIHZDUFUncyBp
bmZvLiAtKQ0KDQpNYXkgSSBzZW5kIHNvbWUgbmV3IHBhdGNoZXMgZm9yIHRoZSBvdGhlciBtb25p
dG9yIGNvbW1hbmRzLCB3aGljaCBtYXkNCg0KYmUgaGVscGZ1bCBmb3IgYW5hbHl6aW5nIG11bHRp
cGxlIGNwdSBwcm9ibGVtcz8NCg0KDQoNCg0KDQotLS0NCg0KQmVzdCB3aXNoZXMNCg0KWWkgV2Fu
Zw==
