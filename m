Received: from eggs.gnu.org ([2001:4830:134:3::10]:56082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY6O0-0001hu-7V
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY6Ny-0007Dz-F6
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:00:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dY6Ny-0007C6-9P
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:00:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E7F265877
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:00:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 20 Jul 2017 10:00:20 +0200
Message-Id: <20170720080022.8104-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Misc 20170720 patches
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

The following changes since commit d4e59218ab80e86015753782fb5378767a51ccd0:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-07-18-2' into staging (2017-07-19 20:45:37 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/misc-20170720-pull-request

for you to fetch changes up to a62e20f6f84d747e55891a0d8aadd0737297571e:

  add editorconfig (2017-07-20 09:56:56 +0200)

----------------------------------------------------------------
git orderfile and editorconfig for 2.10

----------------------------------------------------------------

Gerd Hoffmann (2):
  add scripts/git.orderfile
  add editorconfig

 .editorconfig         | 15 +++++++++++++++
 scripts/git.orderfile | 29 +++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 .editorconfig
 create mode 100644 scripts/git.orderfile

-- 
2.9.3
