Received: from eggs.gnu.org ([2001:4830:134:3::10]:43044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gRHPF-0005ME-RX
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gRHPF-0004C5-08
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:58:33 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gRHPE-000484-Pu
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:58:32 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gRHP7-0001gE-EX
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:58:25 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Nov 2018 13:58:17 +0000
Message-Id: <20181126135820.18998-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/3] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Last arm patches for rc3...

thanks
-- PMM

The following changes since commit 72138f9bf5d8c316043b0d2cc7a674f70930cf95:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2018-11-26 11:46:04 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181126

for you to fetch changes up to 58102ce7fbb2362aa53984aabcf684d164da2d9d:

  net: cadence_gem: Remove incorrect assert() (2018-11-26 13:41:42 +0000)

----------------------------------------------------------------
target-arm queue:
 * some updates to MAINTAINERS file entries
 * cadence_gem: Remove an incorrect assert()

----------------------------------------------------------------
Edgar E. Iglesias (1):
      net: cadence_gem: Remove incorrect assert()

Eric Auger (1):
      MAINTAINERS: Add an ARM SMMU section

Thomas Huth (1):
      MAINTAINERS: Assign some more files in the hw/arm/ directory

 hw/net/cadence_gem.c |  1 -
 MAINTAINERS          | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
