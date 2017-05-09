Received: from eggs.gnu.org ([2001:4830:134:3::10]:36230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d81e0-0001CZ-8k
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d81dw-0001WU-BK
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:41:24 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 11:41:14 +0200
Message-Id: <1494322876-28843-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] docs: Minor updates around ide-drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "thuth@redhat.comthuth"@redhat.com

Markus Armbruster (2):
  docs qemu-doc: Avoid ide-drive, it's deprecated
  docs/qdev-device-use.txt: update section Default Devices

 docs/bootindex.txt       |  2 +-
 docs/qdev-device-use.txt | 13 +++++++------
 qemu-options.hx          |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.7.4
