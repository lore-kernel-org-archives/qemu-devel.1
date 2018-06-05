Received: from eggs.gnu.org ([2001:4830:134:3::10]:40591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQCoH-0005OK-Da
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQCoG-0002to-NU
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:19:41 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  5 Jun 2018 10:19:31 -0400
Message-Id: <20180605141933.30169-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com

The following changes since commit 41feb5b955f0d7c9d071b2c5adbc404ae2895c=
7a:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-p=
ull-request' into staging (2018-06-05 10:38:33 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 68acc99f143b60ec4faa2903065b187d4d3c4bf3:

  sheepdog: remove huge BSS object (2018-06-05 10:15:12 -0400)

----------------------------------------------------------------
Sheepdog patches
----------------------------------------------------------------

Paolo Bonzini (2):
  sheepdog: cleanup repeated expression
  sheepdog: remove huge BSS object

 block/sheepdog.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--=20
2.13.6
