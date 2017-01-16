Received: from eggs.gnu.org ([2001:4830:134:3::10]:45037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTG5b-00009I-Jm
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTG5W-0006No-QJ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:49:23 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1cTG5W-0006NB-Jo
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:49:18 -0500
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 16 Jan 2017 23:49:14 +0100
Message-Id: <20170116224915.19430-1-glaubitz@physik.fu-berlin.de>
Subject: [Qemu-devel] [PATCH v2] linux-user: Update m68k syscall definitions
 to match Linux
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

Fixed a copy-and-paste error: s/file_range/copy_file_range/.

Cheers,
Adrian
