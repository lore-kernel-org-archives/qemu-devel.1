Received: from eggs.gnu.org ([2001:4830:134:3::10]:39872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY75R-0007ZE-TK
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY75N-0005ID-7y
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:45:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dY75N-0005Hv-1D
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:45:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93AC6C04D301
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:45:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 20 Jul 2017 10:45:21 +0200
Message-Id: <20170720084522.28616-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Usb 20170720 patches
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

The following changes since commit d4e59218ab80e86015753782fb5378767a51cc=
d0:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-0=
7-18-2' into staging (2017-07-19 20:45:37 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20170720-pull-request

for you to fetch changes up to 121829cb2160e9cd82482c1542699fa589688106:

  usb: Fix build with newer gcc (2017-07-20 10:02:11 +0200)

----------------------------------------------------------------
usb: Fix build with newer gcc

----------------------------------------------------------------

Eric Blake (1):
  usb: Fix build with newer gcc

 hw/usb/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--=20
2.9.3
