Received: from eggs.gnu.org ([209.51.188.92]:59430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gth6o-0003g5-A1
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gth6n-00076Q-M5
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:04:58 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c]:39863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1gth6n-00074c-Gt
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:04:57 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id e16so259789vsq.6
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 15:04:56 -0800 (PST)
MIME-Version: 1.0
From: Jim Wilson <jimw@sifive.com>
Date: Tue, 12 Feb 2019 15:04:44 -0800
Message-ID: <CAFyWVabfDYU+2+iDYOeFMBL4+hVFL5q=fSR7Pb=VX1af5xsTNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH v4 0/5] RISC-V: Add gdb xml files and gdbstub
 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Jim Wilson <jimw@sifive.com>

This is the 4th version of the patch set.  Updated as per the review
from Alistair, it has the riscv_csrrw_debug function added, and
Reviewed-By lines added.  Otherwise it is the same as the 3rd version.

Jim
