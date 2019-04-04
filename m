Received: from eggs.gnu.org ([209.51.188.92]:59587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hC6Ku-0006re-SS
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hC6Kt-0007Uc-UV
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:39:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hC6Kt-0007QY-IE
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:39:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id 4so4010822wmf.1
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 10:39:32 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
Date: Thu,  4 Apr 2019 18:39:19 +0100
Message-Id: <20190404173921.30841-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/2] target/mips: errors and warnings
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

This v2 series combines previous two patches into one and removes some
left trailing spaces

Jules Irenge (2):
  target/mips: realign comments to fix checkpatch warnings
  target/mips: add or remove space to fix checkpatch errors

 target/mips/cpu.h | 60 +++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

-- 
2.20.1
