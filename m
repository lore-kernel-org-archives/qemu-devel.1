Received: from eggs.gnu.org ([209.51.188.92]:49369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfg0-0003O9-U0
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffP-0002CL-Eu
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:23:48 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 20 Apr 2019 02:23:44 +0000
Message-ID: <7d7b75ffdb42418d9c949eff7e35aa9d5ecf504a.1555726824.git.alistair.francis@wdc.com>
References: <cover.1555726824.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555726824.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 1/6] linux-user/riscv: Add the CPU type as a
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "palmer@sifive.com" <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "imammedo@redhat.com" <imammedo@redhat.com>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogbGludXgtdXNlci9yaXNjdi90YXJnZXRfZWxmLmggfCAxICsNCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvcmlzY3YvdGFy
Z2V0X2VsZi5oIGIvbGludXgtdXNlci9yaXNjdi90YXJnZXRfZWxmLmgNCmluZGV4IGE2NzE2YTZh
YWMuLjlkZDY1NjUyZWUgMTAwNjQ0DQotLS0gYS9saW51eC11c2VyL3Jpc2N2L3RhcmdldF9lbGYu
aA0KKysrIGIvbGludXgtdXNlci9yaXNjdi90YXJnZXRfZWxmLmgNCkBAIC05LDYgKzksNyBAQA0K
ICNkZWZpbmUgUklTQ1ZfVEFSR0VUX0VMRl9IDQogc3RhdGljIGlubGluZSBjb25zdCBjaGFyICpj
cHVfZ2V0X21vZGVsKHVpbnQzMl90IGVmbGFncykNCiB7DQorICAgIC8qIFRZUEVfUklTQ1ZfQ1BV
X0FOWSAqLw0KICAgICByZXR1cm4gImFueSI7DQogfQ0KICNlbmRpZg0KLS0gDQoyLjIxLjANCg0K
