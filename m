Received: from eggs.gnu.org ([2001:4830:134:3::10]:48364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHbTk-0008Dm-Pi
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHbTk-00068D-0M
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:12 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:46834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gHbTj-00067r-Nc
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:11 -0400
Received: by mail-pg1-x536.google.com with SMTP id m9-v6so3585117pgl.13
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 14:23:11 -0700 (PDT)
Date: Tue, 30 Oct 2018 14:22:49 -0700
Message-Id: <20181030212249.7117-4-palmer@sifive.com>
In-Reply-To: <20181030212249.7117-1-palmer@sifive.com>
References: <20181030212249.7117-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 3/3] Add qemu-riscv@nongnu.org as the RISC-V list
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

We now have a RISC-V specific QEMU development list.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d550fd8b809c..10983bd52d64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -244,6 +244,7 @@ M: Palmer Dabbelt <palmer@sifive.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 M: Sagar Karandikar <sagark@eecs.berkeley.edu>
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
+L: qemu-riscv@nongnu.org
 S: Maintained
 F: target/riscv/
 F: hw/riscv/
-- 
2.18.1
