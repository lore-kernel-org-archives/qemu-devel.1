Received: from eggs.gnu.org ([2001:4830:134:3::10]:53753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNP1S-0005do-Qh
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNP1O-0004rU-Rh
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:17:58 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Nov 2018 15:17:50 -0600
Message-Id: <20181115211752.1295571-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] typedefs.h cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com

Prompted by my review of xiezhide's work.  No semantic change, but
not technically a bug fix, so I don't care if it goes in 3.1 or
waits for 4.0.

Eric Blake (2):
  typedefs: (Re-)sort entries alphabetically
  numa: Match struct to typedef name

 include/qemu/typedefs.h | 12 ++++++------
 include/sysemu/numa.h   |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.17.2
