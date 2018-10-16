Received: from eggs.gnu.org ([2001:4830:134:3::10]:58510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCY8K-0002bK-8E
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCY8E-0000J4-Hn
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:48:11 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:39331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCY8E-0000GG-6f
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:48:06 -0400
Received: by mail-pf1-x429.google.com with SMTP id c25-v6so12165165pfe.6
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:48:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 15:47:58 -0700
Message-Id: <20181016224759.3158-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/1] target/hppa patch queue
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

The following changes since commit 09558375a634e17cea6cfbfec883ac2376d2dc7f:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181016-1' into staging (2018-10-16 17:42:56 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-hppa-20181016

for you to fetch changes up to 5f538f75324ef69d624b5f71ab2c7f4e72a7d744:

  target/hppa: Raise exception 26 on emulated hardware (2018-10-16 15:32:22 -0700)

----------------------------------------------------------------
Queued hppa patch

----------------------------------------------------------------
Helge Deller (1):
      target/hppa: Raise exception 26 on emulated hardware

 target/hppa/mem_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
