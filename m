Received: from eggs.gnu.org ([2001:4830:134:3::10]:53445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUxLy-0000Cn-AL
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUxLu-0000xw-4j
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:50:06 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:43179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUxLt-0000xL-LJ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:50:02 -0400
Received: by mail-pl0-x22e.google.com with SMTP id c41-v6so9337096plj.10
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 09:50:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 06:49:54 -1000
Message-Id: <20180618164955.6923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/1] alpha-softmmu queue
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


The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-axp-20180618

for you to fetch changes up to 75cacb128b2d39863a72f60cbefc0987cbcaf641:

  hw/isa/smc37c669: Change the parallel I/O base to 378H (2018-06-16 19:46:54 -1000)

----------------------------------------------------------------
Place parallel device properly, fixing vga

----------------------------------------------------------------
Philippe Mathieu-Daudé (1):
      hw/isa/smc37c669: Change the parallel I/O base to 378H

 hw/isa/smc37c669-superio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
