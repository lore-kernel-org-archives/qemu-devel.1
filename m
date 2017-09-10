Received: from eggs.gnu.org ([2001:4830:134:3::10]:40389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dr4w8-0004dz-Fk
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dr4w4-0002ZQ-G0
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:18:20 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:61829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dr4w4-0002Z8-7l
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:18:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 10 Sep 2017 18:18:10 +0200
Message-Id: <20170910161811.21413-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/1] M68k for 2.11 patches
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

The following changes since commit fcea73709b966a7ded9efa7b106ea50c7fe9025c:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-09-08 16:04:42 +0100)

are available in the git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.11-pull-request

for you to fetch changes up to 6fa9ba09dbf4eb8b52bcb47d6820957f1b77ee0b:

  target/m68k: Switch fpu_rom from make_floatx80() to make_floatx80_init() (2017-09-10 18:07:40 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Kamil Rytarowski (1):
  target/m68k: Switch fpu_rom from make_floatx80() to
    make_floatx80_init()

 target/m68k/fpu_helper.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

-- 
2.13.5
