Received: from eggs.gnu.org ([2001:4830:134:3::10]:43618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTG12-0004h6-8K
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTG0x-0004mf-D5
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:44:40 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:58330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1cTG0x-0004lF-5K
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:44:35 -0500
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 16 Jan 2017 23:44:30 +0100
Message-Id: <20170116224431.19010-1-glaubitz@physik.fu-berlin.de>
Subject: [Qemu-devel] linux-user: Update sh4 syscall definitions to match
 Linux 4.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Hi!

Same as with my previous patch for the sh4 target, here is the updated
syscall definition table for Linux 4.6+. Since the last update to 4.4,
three new syscalls were added.

Thanks,
Adrian
