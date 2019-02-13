Received: from eggs.gnu.org ([209.51.188.92]:56477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwj4-0002FO-Qa
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwj2-000727-Pf
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:45:30 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:39485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwj0-0006jh-Ne
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:45:26 -0500
Received: by mail-pg1-x535.google.com with SMTP id r11so1297927pgp.6
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:45:18 -0800 (PST)
Date: Wed, 13 Feb 2019 07:44:48 -0800
Message-Id: <20190213154450.14749-10-palmer@sifive.com>
In-Reply-To: <20190213154450.14749-1-palmer@sifive.com>
References: <20190213154450.14749-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 09/11] MAINTAINERS: Remove Michael Clark as a
 RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Palmer Dabbelt <palmer@sifive.com>

Michael is no longer employed by SiFive and does not want to continue
maintianing the RISC-V port.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2da141a928f..e170a4c73376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -259,7 +259,6 @@ F: include/hw/ppc/
 F: disas/ppc.c
 
 RISC-V
-M: Michael Clark <mjc@sifive.com>
 M: Palmer Dabbelt <palmer@sifive.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 M: Sagar Karandikar <sagark@eecs.berkeley.edu>
-- 
2.18.1
