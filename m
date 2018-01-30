Received: from eggs.gnu.org ([2001:4830:134:3::10]:46238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1egPVN-0000Dz-Ag
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1egPVJ-0002g3-MG
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:34:53 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue, 30 Jan 2018 14:34:31 +0800
Message-Id: <20180130063433.11605-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/2] qemu-img: Document --force-share / -U
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

v6: Tweak wording ("concurrent writers"). [Max]

Fam Zheng (2):
  qemu-img.texi: Clean up parameter list
  qemu-img: Document --force-share / -U

 qemu-img.texi | 73 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 27 deletions(-)

-- 
2.14.3
