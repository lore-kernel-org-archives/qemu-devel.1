Received: from eggs.gnu.org ([2001:4830:134:3::10]:58585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHSZ-0005Xz-Ns
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHSW-0005vK-E6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:18:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faHSW-0005uu-7Y
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:18:52 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com
	[10.5.11.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62E51308FB9E
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 09:18:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 11:18:46 +0200
Message-Id: <20180703091847.7057-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Ui 20180703 patches
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

The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c6=
56:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into =
staging (2018-07-02 17:57:46 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180703-pull-request

for you to fetch changes up to 4939a1df7d60b4a24458544557ae262852e28567:

  ui: do not build-depend or link with libdrm, it is not needed (2018-07-=
03 10:30:25 +0200)

----------------------------------------------------------------
ui: drop libdrm dependency.

----------------------------------------------------------------

Michael Tokarev (1):
  ui: do not build-depend or link with libdrm, it is not needed

 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.9.3
