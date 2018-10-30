Received: from eggs.gnu.org ([2001:4830:134:3::10]:48336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHbTi-0008Dk-Ri
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHbTh-00067T-Up
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:40680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gHbTh-00066m-NP
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:09 -0400
Received: by mail-pl1-x631.google.com with SMTP id b9-v6so6171589pls.7
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 14:23:09 -0700 (PDT)
Date: Tue, 30 Oct 2018 14:22:48 -0700
Message-Id: <20181030212249.7117-3-palmer@sifive.com>
In-Reply-To: <20181030212249.7117-1-palmer@sifive.com>
References: <20181030212249.7117-1-palmer@sifive.com>
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
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@sifive.com>

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
