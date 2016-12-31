Received: from eggs.gnu.org ([2001:4830:134:3::10]:54560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8JX-0000yx-3A
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8JW-0008WS-Ap
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:18:27 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:18:06 +0800
Message-Id: <20161231011808.4037-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 0/2] QOM'ify work for char devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: i.mitsyanko@gmail.com, pbonzini@redhat.com, qemu-arm@nongnu.org, chouteau@adacore.com

This patch set finish QOM'ify work of char devices.
See each commit message for details.

xiaoqiang zhao (2):
  hw/char: QOM'ify exynos4210_uart.c
  hw/char: QOM'ify grlib_apbuart.c

 hw/char/exynos4210_uart.c | 16 ++++++++++------
 hw/char/grlib_apbuart.c   | 26 +++++++++++++++-----------
 2 files changed, 25 insertions(+), 17 deletions(-)

-- 
2.11.0
