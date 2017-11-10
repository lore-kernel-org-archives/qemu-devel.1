Received: from eggs.gnu.org ([2001:4830:134:3::10]:58570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9tL-00007m-FE
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9tI-0007td-GK
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:02:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eD9tI-0007rZ-AE
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:02:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7627380C1B
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 14:02:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 10 Nov 2017 15:02:34 +0100
Message-Id: <20171110140236.26651-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Ui 20171110 patches
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

The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a8=
42:

  Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20171110-pull-request

for you to fetch changes up to 2e9a8565701c22a0090876cb9e2293db4a6fb205:

  ui: use QEMU_IS_ALIGNED macro (2017-11-10 14:27:29 +0100)

----------------------------------------------------------------
ui: fixes for 2.11

----------------------------------------------------------------

Gerd Hoffmann (1):
  ui: fix dcl unregister

Philippe Mathieu-Daud=C3=A9 (1):
  ui: use QEMU_IS_ALIGNED macro

 ui/console-gl.c | 2 +-
 ui/console.c    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--=20
2.9.3
