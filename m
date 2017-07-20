Received: from eggs.gnu.org ([2001:4830:134:3::10]:54783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY6J6-0005Y4-Dq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY6J3-0004v9-FD
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:55:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dY6J3-0004uI-9p
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:55:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4002619F24
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 07:55:32 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 20 Jul 2017 09:55:24 +0200
Message-Id: <20170720075526.7383-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Ui 20170720 patches
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

  git://git.kraxel.org/qemu tags/ui-20170720-pull-request

for you to fetch changes up to b02cf99b9d998b3ec23dae8a4a8210e222b4294b:

  keymaps: fr-ca: more fixups (2017-07-20 09:25:44 +0200)

----------------------------------------------------------------
ui fixes (vnc docs, keymaps) for 2.10

----------------------------------------------------------------

Gerd Hoffmann (1):
  keymaps: fr-ca: more fixups

Markus Armbruster (1):
  vnc: Clarify documentation of QMP command change

 pc-bios/keymaps/fr-ca | 10 +++++++++-
 qapi-schema.json      |  3 +--
 2 files changed, 10 insertions(+), 3 deletions(-)

--=20
2.9.3
