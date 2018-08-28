Received: from eggs.gnu.org ([2001:4830:134:3::10]:33469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuco1-0005KP-JS
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fucmZ-0008Qq-08
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:07:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fucmY-0008QY-Re
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:07:38 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Aug 2018 14:07:34 +0200
Message-Id: <20180828120736.32323-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qapi: A whitespace touch-up,
 and a doc update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, eblake@redhat.com

Markus Armbruster (2):
  qapi: Emit a blank line before dummy declaration
  qapi: Update docs for generator changes since commit 9ee86b85267

 docs/devel/qapi-code-gen.txt | 131 ++++++++++++++++++++++++++---------
 scripts/qapi/common.py       |   1 +
 2 files changed, 101 insertions(+), 31 deletions(-)

-- 
2.17.1
