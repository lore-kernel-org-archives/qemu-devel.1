Received: from eggs.gnu.org ([209.51.188.92]:39993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQR-00045C-MJ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQM-0001kB-BG
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hCRPd-0000IF-3j
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id w10so8689873wrm.4
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:09:51 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
Date: Fri,  5 Apr 2019 17:09:34 +0100
Message-Id: <20190405160938.27494-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/4] target/mips: errors and warnings
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: amarkovic@wavecomp.com
Cc: arikalo@wavecomp.com, qemu-devel@nongnu.org

This v3 improves on code alignments

Jules Irenge (4):
  target/mips: realign comments to fix checkpatch warnings
  target/mips: add or remove space to fix checkpatch errors
  target/mips: wrap lines to fix checkpatch errors
  target/mips: replace tab code indent with spaces to fix checkpatch
    errors

 target/mips/cpu.h | 213 +++++++++++++++++++++++++---------------------
 1 file changed, 118 insertions(+), 95 deletions(-)

-- 
2.20.1
