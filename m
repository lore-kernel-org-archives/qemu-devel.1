Received: from eggs.gnu.org ([2001:4830:134:3::10]:54363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evj46-0004TB-Qb
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evj45-0003mD-VB
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:30:02 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 13 Mar 2018 08:29:55 -0400
Message-Id: <20180313122956.21442-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

The following changes since commit 834eddf22ec762839b724538c7be1d1d3b2d9d=
3b:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2018-03-13 10:49:02 +0000)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 44acd46f60ce6f16d369cd443e77949deca56a2c:

  block: include original filename when reporting invalid URIs (2018-03-1=
3 08:06:55 -0400)

----------------------------------------------------------------
Block patch
----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (1):
  block: include original filename when reporting invalid URIs

 block/gluster.c  | 2 +-
 block/sheepdog.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--=20
2.13.6
