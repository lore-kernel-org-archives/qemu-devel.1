Received: from eggs.gnu.org ([209.51.188.92]:43521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hBfM9-0005ao-KK
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hBfM8-00049i-Oa
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:51:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hBfM8-00048k-GJ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:51:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id t17so8133102wrw.13
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 05:51:04 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
Date: Wed,  3 Apr 2019 13:50:50 +0100
Message-Id: <20190403125055.26564-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/5] target/mips/cpu: errors and warnings
 coding style cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: amarkovic@wavecomp.com
Cc: aurelien@aurel32.net, qemu-devel@nongnu.org, arikalo@wavecomp.com

This v1 series cleans up all warnings and errors of coding style within cpu.h
file

Jules Irenge (5):
  target/mips: add space to fix checkpatch errors
  target/mips: realign comments to fix checkpatch warnings
  target/mips: replace indentation with space to fix checkpatch errors
  target/mips: remove space to fix checkpatch errors
  target/mips: wrap line into multiple lines to to fix checkpatch errors

 target/mips/cpu.h | 211 +++++++++++++++++++++++++---------------------
 1 file changed, 117 insertions(+), 94 deletions(-)

-- 
2.20.1
