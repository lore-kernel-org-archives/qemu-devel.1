Received: from eggs.gnu.org ([2001:4830:134:3::10]:56618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJzXN-00061a-PS
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJzXJ-0007pV-W9
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:28:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gJzXI-0007fL-2n
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:28:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A4303081252
	for <qemu-devel@nongnu.org>; Tue,  6 Nov 2018 11:28:34 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Nov 2018 12:28:28 +0100
Message-Id: <20181106112829.1948-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Seabios 20181106 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 7d56239f159afc2e7bd42623947e56ba48f378=
36:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
81102' into staging (2018-11-02 17:17:12 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/seabios-20181106-pull-request

for you to fetch changes up to 0b8f74488e50f98b04e63157f85fde8a13f8d6aa:

  update seabios to master snapshot (2018-11-06 12:23:58 +0100)

----------------------------------------------------------------
seabios update for 3.1

----------------------------------------------------------------

Gerd Hoffmann (1):
  update seabios to master snapshot

 pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-bochs-display.bin | Bin 27648 -> 27648 bytes
 pc-bios/vgabios-cirrus.bin        | Bin 38400 -> 38400 bytes
 pc-bios/vgabios-qxl.bin           | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-ramfb.bin         | Bin 28160 -> 28160 bytes
 pc-bios/vgabios-stdvga.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-virtio.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-vmware.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios.bin               | Bin 38400 -> 38400 bytes
 roms/seabios                      |   2 +-
 11 files changed, 1 insertion(+), 1 deletion(-)

--=20
2.9.3
