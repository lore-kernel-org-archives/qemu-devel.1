Received: from eggs.gnu.org ([2001:4830:134:3::10]:37556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjALF-0005cw-Tf
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjALB-0006Bg-PA
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:55:17 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cjALB-0006BX-Kq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:55:13 -0500
Received: by mail-qk0-x244.google.com with SMTP id u188so13506860qkc.3
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 11:55:13 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  2 Mar 2017 06:55:01 +1100
Message-Id: <20170301195502.4432-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL] target/sparc queued patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This one has been languishing for a few weeks.


r~



The following changes since commit b28f9db1a7ce4d537ce2fae6fbce5e5e37dc265b:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170228-1' into staging (2017-03-01 17:58:54 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tgt-20170302

for you to fetch changes up to 3db010c3398d03646d74f2d36a68e62539342e6c:

  target/sparc: Restore ldstub of odd asis (2017-03-02 06:52:43 +1100)

----------------------------------------------------------------
Queued sparc patch

----------------------------------------------------------------
Richard Henderson (1):
      target/sparc: Restore ldstub of odd asis

 target/sparc/translate.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)
