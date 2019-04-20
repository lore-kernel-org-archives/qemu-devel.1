Received: from eggs.gnu.org ([209.51.188.92]:50397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiS-0005vS-Ti
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiS-0003Y8-1O
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:26:56 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 20 Apr 2019 02:26:37 +0000
Message-ID: <cover.1555727081.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 0/8] RISC-V: Add some prep patches for the
 Hypervisor
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

DQpBbGlzdGFpciBGcmFuY2lzICg4KToNCiAgdGFyZ2V0L3Jpc2N2OiBNYXJrIHByaXZpbGVnZSBs
ZXZlbCAyIGFzIHJlc2VydmVkDQogIHRhcmdldC9yaXNjdjogVHJpZ2dlciBpbnRlcnJ1cHQgb24g
TUlQIHVwZGF0ZSBhc3luY2hyb25vdXNseQ0KICB0YXJnZXQvcmlzY3Y6IEltcHJvdmUgdGhlIHNj
YXVzZSBsb2dpYw0KICB0YXJnZXQvcmlzY3Y6IEFkZCB0aGUgTVBWIGFuZCBNVEwgbXN0YXR1cyBi
aXRzDQogIHRhcmdldC9yaXNjdjogQWxsb3cgc2V0dGluZyBtc3RhdHVzIHZpcnR1bGlzYXRpb24g
Yml0cw0KICB0YXJnZXQvcmlzY3Y6IEFkZCBIeXBlcnZpc29yIENTUiBtYWNyb3MNCiAgdGFyZ2V0
L3Jpc2N2OiBBZGQgdGhlIEhTVEFUVVMgcmVnaXN0ZXIgbWFza3MNCiAgdGFyZ2V0L3Jpc2N2OiBB
ZGQgdGhlIEhHQVRQIHJlZ2lzdGVyIG1hc2tzDQoNCiB0YXJnZXQvcmlzY3YvY3B1X2JpdHMuaCAg
IHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQogdGFyZ2V0L3Jp
c2N2L2NwdV9oZWxwZXIuYyB8IDM1ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KIHRh
cmdldC9yaXNjdi9jc3IuYyAgICAgICAgfCAxOSArKysrKysrLS0tLS0tLS0tLQ0KIDMgZmlsZXMg
Y2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yMS4w
DQoNCg==
