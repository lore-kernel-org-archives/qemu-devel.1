Received: from eggs.gnu.org ([2001:4830:134:3::10]:49260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gIMoa-0007Cq-Rd
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 19:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gIMoZ-0005Gg-Mb
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 19:55:52 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:32971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gIMoZ-0005G2-9o
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 19:55:51 -0400
Received: by mail-pf1-x441.google.com with SMTP id i62-v6so128896pfi.0
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 16:55:51 -0700 (PDT)
Date: Thu,  1 Nov 2018 16:55:24 -0700
Message-Id: <20181101235525.29042-3-palmer@sifive.com>
In-Reply-To: <20181101235525.29042-1-palmer@sifive.com>
References: <20181101235525.29042-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 2/3] Add Alistair as a RISC-V Maintainer
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

Alistair has been contributing to the RISC-V QEMU port for a while now
so I'd like him to be officially listed as a maintainer.  I've checked
with the other RISC-V maintainers and there are no objections, and I've
also checked with Alistair so he knows I'm volunteering him.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d794bd7a66fe..d550fd8b809c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -241,6 +241,7 @@ F: disas/ppc.c
 RISC-V
 M: Michael Clark <mjc@sifive.com>
 M: Palmer Dabbelt <palmer@sifive.com>
+M: Alistair Francis <Alistair.Francis@wdc.com>
 M: Sagar Karandikar <sagark@eecs.berkeley.edu>
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
 S: Maintained
-- 
2.18.1
