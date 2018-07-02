Received: from eggs.gnu.org ([2001:4830:134:3::10]:47613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fZtYf-0007Di-9G
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 03:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fZtYb-0007pr-DM
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 03:47:37 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon,  2 Jul 2018 16:26:44 +1000
Message-Id: <20180702062644.48040-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [GIT PULL for qemu-pseries] pseries: Update SLOF
 firmware image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

The following changes since commit edb1fb337f65f82fe32b989c4f018efe85c1dddb:

  pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)

are available in the git repository at:

  git@github.com:aik/qemu.git tags/qemu-slof-20180702

for you to fetch changes up to edb1fb337f65f82fe32b989c4f018efe85c1dddb:

  pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)

----------------------------------------------------------------

I just missed a couple of gcc 8.1 fixes and thought I can still squeeze
them before the 3.0  soft freeze.


*** Note: this is not for master, this is for pseries
