Received: from eggs.gnu.org ([2001:4830:134:3::10]:38625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ejT6D-000244-CX
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ejT67-0004ME-LB
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:01:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ejT67-0004L9-H4
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:01:27 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed,  7 Feb 2018 12:01:23 -0500
Message-Id: <20180207170124.26704-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

The following changes since commit 0833df03f4206a6cf416fbb3d380fa95c8e61fba:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180206a' into staging (2018-02-07 12:07:23 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to 3260cdfffbf00f33923f5f9f6bef45932d7ac28b:

  hbitmap: fix missing restore count when finish deserialization (2018-02-07 11:35:49 -0500)

----------------------------------------------------------------

----------------------------------------------------------------

Liang Li (1):
  hbitmap: fix missing restore count when finish deserialization

 util/hbitmap.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.14.3
