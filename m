Received: from eggs.gnu.org ([2001:4830:134:3::10]:32900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctuKR-00062y-Fd
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctuKN-0005qp-De
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:02:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctuKN-0005qD-8N
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:02:47 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 31 Mar 2017 12:02:43 +0100
Message-Id: <20170331110244.9439-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: iwona260909@gmail.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 05a6f451eb0e3224a8e6d98089379f20ec06c787:

  Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2017-03-30-tag' into staging (2017-03-31 11:09:51 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20170331

for you to fetch changes up to fd5d23babf9838c1b099a9e8020e778aac0ebb4d:

  hmp: fix "dump-quest-memory" segfault (2017-03-31 11:53:42 +0100)

----------------------------------------------------------------
HMP pull (one bugfix)

----------------------------------------------------------------
Iwona Kotlarska (1):
      hmp: fix "dump-quest-memory" segfault

 target/i386/arch_dump.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
