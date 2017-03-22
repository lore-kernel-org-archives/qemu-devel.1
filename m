Received: from eggs.gnu.org ([2001:4830:134:3::10]:32839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cqfmp-0002bJ-Tv
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cqfmm-0005IR-1Q
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:54:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cqfml-0005Hx-S2
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:54:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 22 Mar 2017 12:54:37 +0000
Message-Id: <20170322125438.6235-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 940a8ce075e3408742a4edcabfd6c2a15e2539eb:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-03-20 16:34:26 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to ff5bbe56c6f9a74c2d77389a21d5d2368458c939:

  parallels: fix default options parsing (2017-03-21 10:02:36 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Edgar Kaziahmedov (1):
  parallels: fix default options parsing

 block/parallels.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.9.3
