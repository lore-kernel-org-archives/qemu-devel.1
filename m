Received: from eggs.gnu.org ([2001:4830:134:3::10]:55739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQhSN-0000Ys-C6
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQhSM-0002si-Pu
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:03:07 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed,  6 Jun 2018 19:02:55 -0400
Message-Id: <20180606230257.9038-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] jobs: minor doc fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

One is from my manual completion series,
the other is from the recent refactor.

John Snow (2):
  jobs: fix stale wording
  jobs: fix verb references in docs

 qapi/job.json | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.14.3
