Received: from eggs.gnu.org ([209.51.188.92]:36689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hF7Ew-0008Rc-8R
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hF7Eu-0000hY-Al
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:13:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hF7Es-0000fp-B7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:13:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id q1so14160548wrp.0
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 18:13:48 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
Date: Sat, 13 Apr 2019 02:12:59 +0100
Message-Id: <20190413011302.6610-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/3] target/mips: Errors and warnings cleanup
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

This v4 series combines two previously distinct patches into one patch
replace tab code indent patch and the add or rmove space into 
one patch add or remove space patch.

Jules Irenge (3):
  target/mips: add or remove space to fix checkpatch errors
  target/mips: realign comments to fix checkpatch warnings
  target/mips: wrap lines to fix checkpatch errors

 target/mips/cpu.h | 211 +++++++++++++++++++++++++---------------------
 1 file changed, 117 insertions(+), 94 deletions(-)

-- 
2.20.1
