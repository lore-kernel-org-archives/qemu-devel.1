Received: from eggs.gnu.org ([2001:4830:134:3::10]:38809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTfMW-0006jC-4R
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 21:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTfMV-0004RJ-HU
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 21:53:04 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue, 26 Dec 2017 10:52:45 +0800
Message-Id: <20171226025247.11082-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/2] qemu-img: Document --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>

v5: Clean up the @table @var section first. [Kevin, Peter]

Fam Zheng (2):
  qemu-img.texi: Clean up parameter list
  qemu-img: Document --force-share / -U

 qemu-img.texi | 75 ++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 27 deletions(-)

-- 
2.14.3
