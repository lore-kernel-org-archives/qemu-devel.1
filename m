Received: from eggs.gnu.org ([209.51.188.92]:55118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gprzE-000700-Rq
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 04:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gprqB-0005kv-TD
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 04:44:01 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:43937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gprq7-0005cn-Ty
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 04:43:57 -0500
Received: by mail-ed1-x543.google.com with SMTP id f9so7436128eds.10
	for <qemu-devel@nongnu.org>; Sat, 02 Feb 2019 01:43:52 -0800 (PST)
Date: Sat,  2 Feb 2019 01:43:28 -0800
Message-Id: <20190202094329.22874-10-palmer@sifive.com>
In-Reply-To: <20190202094329.22874-1-palmer@sifive.com>
References: <20190202094329.22874-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 09/10] MAINTAINERS: Remove Michael Clark as a
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
index af339b86db76..47cb3c14298e 100644
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
