Received: from eggs.gnu.org ([2001:4830:134:3::10]:48891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ci7KF-0007jh-Ag
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ci7KC-0008Qn-8O
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:29:55 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1ci7KC-0008QX-29
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:29:52 -0500
Received: by mail-wr0-x242.google.com with SMTP id o22so7498207wro.3
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 14:29:49 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sun, 26 Feb 2017 23:29:14 +0100
Message-Id: <1488148156-2036-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 0/2] sun4v queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org, Artyom Tarasenko <atar4qemu@gmail.com>

The following changes since commit a951316b8a5c3c63254f20a826afeed940dd4cba:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-03 14:41:49 +0000)

are available in the git repository at:

  https://github.com/artyom-tarasenko/qemu tags/pull-sun4v-20170226

for you to fetch changes up to a5a08302d44a8b1a8c5819b1411002f85bb5f847:

  niagara: check if a serial port is available (2017-02-26 22:46:08 +0100)

----------------------------------------------------------------
Pull request for Niagara patches 2017 02 26

----------------------------------------------------------------
Artyom Tarasenko (2):
      niagara: fail if a firmware file is missing
      niagara: check if a serial port is available

 hw/sparc64/niagara.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)
