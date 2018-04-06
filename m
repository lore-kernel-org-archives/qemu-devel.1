Received: from eggs.gnu.org ([2001:4830:134:3::10]:55157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4RGK-0000KU-P4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4RGJ-0005JP-TH
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:18:40 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:37038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f4RGJ-0005Gx-Kz
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:18:39 -0400
Received: by mail-pf0-x235.google.com with SMTP id x16so713467pfm.4
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 06:18:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  6 Apr 2018 23:18:31 +1000
Message-Id: <20180406131832.23901-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL for-2.12 0/1] target/hppa: seabios-hppa update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, deller@gmx.de

Helge Deller has fixed some bios bugs and has asked
that I update qemu thus.


r~


The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca62d:

  Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-hppa-20180407

for you to fetch changes up to 5aa48600823a1fc2f5c8c3ec3e93227d4638e3a4:

  Update seabios-hppa (2018-04-06 23:14:51 +1000)

----------------------------------------------------------------
Update hppa-softmmu bios

----------------------------------------------------------------
Richard Henderson (1):
      Update seabios-hppa

 pc-bios/hppa-firmware.img | Bin 215696 -> 215936 bytes
 roms/seabios-hppa         |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
