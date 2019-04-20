Received: from eggs.gnu.org ([209.51.188.92]:50740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfjJ-0006kf-3i
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfjI-00045I-9x
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:49 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 20 Apr 2019 02:27:43 +0000
Message-ID: <b91bacd428706e5cb44e4db83c75f7a03d6fae2b.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 8/8] target/riscv: Add the HGATP register
 masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "palmer@sifive.com" <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggfCAxMSArKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yv
Y3B1X2JpdHMuaCBiL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oDQppbmRleCBhMTc5MTM3YmMxLi5k
YzlkNTNkNGJlIDEwMDY0NA0KLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCisrKyBiL3Rh
cmdldC9yaXNjdi9jcHVfYml0cy5oDQpAQCAtMjA4LDYgKzIwOCwxNyBAQA0KICNkZWZpbmUgQ1NS
X0hJREVMRUcgICAgICAgICAweGEwMw0KICNkZWZpbmUgQ1NSX0hHQVRQICAgICAgICAgICAweGE4
MA0KIA0KKyNpZiBkZWZpbmVkKFRBUkdFVF9SSVNDVjMyKQ0KKyNkZWZpbmUgSEdBVFBfTU9ERSAg
ICAgICAgICAgU0FUUDMyX01PREUNCisjZGVmaW5lIEhHQVRQX0FTSUQgICAgICAgICAgIFNBVFAz
Ml9BU0lEDQorI2RlZmluZSBIR0FUUF9QUE4gICAgICAgICAgICBTQVRQMzJfUFBODQorI2VuZGlm
DQorI2lmIGRlZmluZWQoVEFSR0VUX1JJU0NWNjQpDQorI2RlZmluZSBIR0FUUF9NT0RFICAgICAg
ICAgICBTQVRQNjRfTU9ERQ0KKyNkZWZpbmUgSEdBVFBfQVNJRCAgICAgICAgICAgU0FUUDY0X0FT
SUQNCisjZGVmaW5lIEhHQVRQX1BQTiAgICAgICAgICAgIFNBVFA2NF9QUE4NCisjZW5kaWYNCisN
CiAvKiBQZXJmb3JtYW5jZSBDb3VudGVycyAqLw0KICNkZWZpbmUgQ1NSX01IUE1DT1VOVEVSMyAg
ICAweGIwMw0KICNkZWZpbmUgQ1NSX01IUE1DT1VOVEVSNCAgICAweGIwNA0KLS0gDQoyLjIxLjAN
Cg0K
