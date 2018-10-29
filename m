Received: from eggs.gnu.org ([2001:4830:134:3::10]:56120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHADi-0004o4-Hj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHADf-0007Zb-CE
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:16:50 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gHADe-0007SL-Td
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:16:47 -0400
Received: by mail-pf1-x443.google.com with SMTP id z2-v6so1685790pfe.2
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 09:16:41 -0700 (PDT)
Date: Mon, 29 Oct 2018 09:16:05 -0700
Message-Id: <20181029161605.11486-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH] Add Alistair as a RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu, qemu-devel@nongnu.org, Palmer Dabbelt <palmer@sifive.com>

Alistair has been contributing to the RISC-V QEMU port for a while now
so I'd like him to be officially listed as a maintainer.  I've checked
with the other RISC-V mainatiners and there are no objectics, and I've
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
