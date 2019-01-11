Received: from eggs.gnu.org ([209.51.188.92]:38790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghvHH-0003FO-Sq
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghvHH-0004xy-0w
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:47:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghvHG-0004xH-MP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:47:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E145CC0C6C29
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 11:47:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 11 Jan 2019 12:47:00 +0100
Message-Id: <20190111114701.6195-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Misc 20190111 patches
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

The following changes since commit 291741033f611a4f0bbce3f7c9dead84ce315f96:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20190110-pull-request' into staging (2019-01-10 18:45:23 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/misc-20190111-pull-request

for you to fetch changes up to 78ac44af547e09bdddc75e41a525cdc8eec60be4:

  roms: seabios: Rename CROSS_COMPILE to CROSS_PREFIX (2019-01-11 12:46:07 +0100)

----------------------------------------------------------------
misc: fix seabios cross build.

----------------------------------------------------------------

Roman Bolshakov (1):
  roms: seabios: Rename CROSS_COMPILE to CROSS_PREFIX

 roms/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.9.3
