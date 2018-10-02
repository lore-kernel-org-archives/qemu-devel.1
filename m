Received: from eggs.gnu.org ([2001:4830:134:3::10]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7CRT-0003Bi-CH
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 00:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7CFi-0002vr-Ui
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 00:25:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  2 Oct 2018 14:25:25 +1000
Message-Id: <20181002042526.9565-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/1] libfdt queue 20181002
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit a2ef4d9e95400cd387ab4ae19a317741e458fb07:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20181001-pull-request' into staging (2018-10-01 15:44:30 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/libfdt-20181002

for you to fetch changes up to 0b001b3094bcf80a5a0c3b7655029a10fb63f661:

  Update dtc/libfdt submodule to v1.4.7 (2018-10-02 13:53:26 +1000)

----------------------------------------------------------------
Update dtc submodule to v1.4.7

We have some upcoming things planned for ppc that will require some
newer libfdt features.  In preparation, update the dtc/libfdt
submodule to upstreasm version v1.4.7.

----------------------------------------------------------------
David Gibson (1):
      Update dtc/libfdt submodule to v1.4.7

 dtc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
