Received: from eggs.gnu.org ([2001:4830:134:3::10]:38963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPcKw-0006Ts-OH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPcKs-000589-Te
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:55:14 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gPcKq-000535-SH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:55:10 -0500
Received: by mail-pl1-x641.google.com with SMTP id b22-v6so7670752pls.7
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 15:55:02 -0800 (PST)
Date: Wed, 21 Nov 2018 15:46:51 -0800
Message-Id: <20181121234651.24596-2-palmer@sifive.com>
In-Reply-To: <20181121234651.24596-1-palmer@sifive.com>
References: <20181121234651.24596-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH for-3.1 2/2] MAINTAINERS: Mark RISC-V as
 Supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>

There's three of us that are paid to work on this.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e89adc81d5d5..d5ec5e74f328 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -250,7 +250,7 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
 M: Sagar Karandikar <sagark@eecs.berkeley.edu>
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
 L: qemu-riscv@nongnu.org
-S: Maintained
+S: Supported
 F: target/riscv/
 F: hw/riscv/
 F: include/hw/riscv/
-- 
2.18.1
