Received: from eggs.gnu.org ([2001:4830:134:3::10]:34597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eLu7V-0004Gq-Os
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eLu7Q-0008En-2V
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:01:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  4 Dec 2017 18:01:01 +0100
Message-Id: <20171204170103.13973-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Block layer patch for 2.11.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, berto@igalia.com, qemu-devel@nongnu.org

The following changes since commit 495566ec38817e6625294e6909cffb4de040c8e7:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171204' into staging (2017-12-04 11:27:53 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 3d5d319e1221082974711af1d09d82f0755c1698:

  blockjob: Make block_job_pause_all() keep a reference to the jobs (2017-12-04 17:44:51 +0100)

----------------------------------------------------------------
Block layer patches for 2.11.0-rc4

----------------------------------------------------------------
Alberto Garcia (1):
      blockjob: Make block_job_pause_all() keep a reference to the jobs

 blockjob.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
