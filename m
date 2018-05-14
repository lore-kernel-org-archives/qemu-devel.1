Received: from eggs.gnu.org ([2001:4830:134:3::10]:51192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fIHpb-00009g-Se
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fIHpX-0007HO-0m
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:04:19 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fIHpW-0007G2-NN
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:04:14 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 14 May 2018 20:05:05 +0200
Message-Id: <20180514180506.17388-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/1] M68k for 2.13 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

The following changes since commit 7a9180b77eca258ab418ec00ab397392e70e55d9:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-05-14 14:15:27 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.13-pull-request

for you to fetch changes up to 5a73e7f313da0e4657bcac61b533ced71b0d0224:

  m68k: fix floatx80_mod() (Coverity CID1390568) (2018-05-14 19:13:07 +0200)

----------------------------------------------------------------
Fix coverity CID1390568
----------------------------------------------------------------

Laurent Vivier (1):
  m68k: fix floatx80_mod() (Coverity CID1390568)

 target/m68k/softfloat.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.14.3
