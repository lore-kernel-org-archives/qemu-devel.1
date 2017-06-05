Received: from eggs.gnu.org ([2001:4830:134:3::10]:39063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dHxaE-0008TA-Nd
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 15:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dHxaD-0007De-Rd
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 15:22:34 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:35095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dHxaD-0007CM-MF
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 15:22:33 -0400
Received: by mail-pf0-x22a.google.com with SMTP id l89so13001769pfi.2
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 12:22:32 -0700 (PDT)
MIME-Version: 1.0
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Mon, 5 Jun 2017 22:22:30 +0300
Message-ID: <CAKSfGUDzjxisJ-69ft=0Y7oCnCaxAeBO43a33H6i7ZRoZCZz-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] SHPC in pci-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi everyone,
Does anyone use pci-bridge built-in SHPC and found it working (especially
on x86 machines)? I really want to hear about such cases. When I'm trying
to hotplug anything into the bridge without using ACPI on x86 machine, none
of my linux guests can see it in lspci, and dmesg contains nothing about
this insertion.

Thanks
-- 
Alexander Bezzubikov
