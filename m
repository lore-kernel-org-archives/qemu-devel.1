Received: from eggs.gnu.org ([209.51.188.92]:59406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hFPGj-0003DH-Tl
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 16:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hFPGi-0000LU-0g
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 16:28:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hFPGg-0000HL-Av
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 16:28:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id r186so3009843wmf.1
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 13:28:52 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
Date: Sat, 13 Apr 2019 21:28:16 +0100
Message-Id: <20190413202818.13622-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 0/2] target/mips: Errors amd warnings
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net, Jules Irenge <jbi.octave@gmail.com>

This v5 series combines patch v4 2/3 into patch v4 1/3 hence the number
of patches to two.

Jules Irenge (2):
  target/mips: add or remove space to fix checkpatch errors
  target/mips: realign comments to fix checkpatch warnings

 target/mips/cpu.h | 211 +++++++++++++++++++++++++---------------------
 1 file changed, 117 insertions(+), 94 deletions(-)

-- 
2.20.1
