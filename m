Received: from eggs.gnu.org ([2001:4830:134:3::10]:58605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abhijit.ray.chaudhury@gmail.com>) id 1dvLMm-0006kK-O1
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abhijit.ray.chaudhury@gmail.com>) id 1dvLMm-0001Zf-15
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:39:28 -0400
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f]:45924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <abhijit.ray.chaudhury@gmail.com>)
	id 1dvLMl-0001ZX-TC
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:39:27 -0400
Received: by mail-it0-x22f.google.com with SMTP id x15so932504itb.0
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 03:39:27 -0700 (PDT)
MIME-Version: 1.0
From: Abhijit Ray Chaudhury <abhijit.ray.chaudhury@gmail.com>
Date: Fri, 22 Sep 2017 16:09:26 +0530
Message-ID: <CAACKNgWgNbvH_UV-nLUrcrN7F1jh9G2-ZAScm=Xv2OKhc6WyLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Support for ARM CP15 registers via GDB interface of
 qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I want to view ARM CP15 register sets via gdb when I am emulating arm.
However I only see ARM Core Register Sets and NEON registers through
gdb interface.

Can you please let me know how to add cp15 register set support using
gdb interface in qemu.

Thanks in advance,
-Abhijit
