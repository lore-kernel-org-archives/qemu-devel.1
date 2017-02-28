Received: from eggs.gnu.org ([2001:4830:134:3::10]:38533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cipOs-0004bz-5N
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cipOp-0002lH-3C
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:33:38 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cipOo-0002l0-Tp
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:33:35 -0500
Received: by mail-pf0-x242.google.com with SMTP id y23so1854540pfk.2
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 13:33:33 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  1 Mar 2017 08:33:23 +1100
Message-Id: <20170228213324.23510-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL] TCG queued patch
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

Only one this week.  Pranith didn't mention which compiler version,
but I can imagine gcc7 or clang warning of such a thing.


r~


The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbfba:

  vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170301

for you to fetch changes up to dc1eccd661ada3b746ca4438e444993c36a0f04f:

  aarch64: Change ext type to TCGType to fix warnings (2017-03-01 08:28:06 +1100)

----------------------------------------------------------------
Queued TCG patch

----------------------------------------------------------------
Pranith Kumar (1):
      aarch64: Change ext type to TCGType to fix warnings

 tcg/aarch64/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
