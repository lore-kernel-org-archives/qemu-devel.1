Received: from eggs.gnu.org ([2001:4830:134:3::10]:44364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcot-0008HU-4I
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcoq-0002te-3b
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:52:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFcop-0002s1-W7
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:52:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 312DD406C792
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 09:52:31 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 11:52:24 +0200
Message-Id: <20180507095225.11659-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Vga 20180507 patches
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

The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9=
b9:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' i=
nto staging (2018-05-04 14:42:46 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20180507-pull-request

for you to fetch changes up to 5bd5c27c7d284d01477c5cc022ce22438c46bf9f:

  qxl: fix local renderer crash (2018-05-07 11:47:57 +0200)

----------------------------------------------------------------
qxl: fix local renderer crash

----------------------------------------------------------------

Gerd Hoffmann (1):
  qxl: fix local renderer crash

 hw/display/qxl-render.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--=20
2.9.3
