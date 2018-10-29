Received: from eggs.gnu.org ([2001:4830:134:3::10]:44821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH8NT-0003Wq-50
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH8NQ-00044H-SG
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH8NQ-00040J-Gh
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:18:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C1A17F3FE
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 14:18:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 15:18:32 +0100
Message-Id: <20181029141834.8794-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Ui 20181029 patches
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

The following changes since commit 285278ca785f5fa9a570927e1c0958a2ca2b21=
50:

  Merge remote-tracking branch 'remotes/famz/tags/testing-pull-request' i=
nto staging (2018-10-27 19:55:08 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20181029-pull-request

for you to fetch changes up to 9c956e646178fee8c14ce7dfae5a9d7cb901876c:

  spice: prepare for upcoming spice-server change (2018-10-29 14:38:17 +0=
100)

----------------------------------------------------------------
ui: sdl+spice tweaks.

----------------------------------------------------------------

Gerd Hoffmann (1):
  spice: prepare for upcoming spice-server change

Sebastian Krzyszkowiak (1):
  SDL: set a hint to not bypass the window compositor

 ui/sdl2.c          |  3 +++
 ui/spice-display.c | 26 ++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

--=20
2.9.3
