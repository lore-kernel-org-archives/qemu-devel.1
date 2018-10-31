Received: from eggs.gnu.org ([2001:4830:134:3::10]:35648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHoo2-0004q4-OM
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHonv-0004L8-2s
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:37:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gHonu-0004KP-Rl
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:36:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CBC3307CDC1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 11:36:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 31 Oct 2018 11:36:49 +0000
Message-Id: <20181031113651.32430-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Misc next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9=
cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1=
-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/misc-next-pull-request

for you to fetch changes up to f5177798d899a2ee2a2d0babd3f5399d0f786333:

  scripts: report on author emails that are mangled by the mailing list (=
2018-10-31 11:31:08 +0000)

----------------------------------------------------------------
Merge misc fixes

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (2):
  block: drop moderated sheepdog mailing list from MAINTAINERS file
  scripts: report on author emails that are mangled by the mailing list

 MAINTAINERS           | 1 -
 scripts/checkpatch.pl | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

--=20
2.19.1
