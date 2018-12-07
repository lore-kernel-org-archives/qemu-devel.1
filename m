Received: from eggs.gnu.org ([2001:4830:134:3::10]:39777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVIfx-00020T-Re
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVIft-0001dp-Nm
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:08:25 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Dec 2018 16:08:03 +0000
Message-Id: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/3] macppc: minor patches for 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Here are a few minor macppc patches that have been sitting in my local queue
during freeze in preparation for 4.0.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (3):
  MAINTAINERS: add myself as maintainer for Mac Old World and New World
    machines
  mac_newworld: enable access to EDID data for the VGA device
  mac_oldworld: enable access to EDID data for the VGA device

 MAINTAINERS           | 6 ++++--
 hw/ppc/mac_newworld.c | 5 ++++-
 hw/ppc/mac_oldworld.c | 5 ++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.11.0
