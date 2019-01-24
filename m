Received: from eggs.gnu.org ([209.51.188.92]:41040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmcNX-0007Tf-EQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmcNW-00081b-EX
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:36:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmcNW-0007zz-8E
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:36:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E66EA12FD
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 10:36:57 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 11:36:50 +0100
Message-Id: <20190124103651.26227-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Ui 20190124 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

The following changes since commit f6b06fcceef465de0cf2514c9f76fe0192896781:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190121-pull-request' into staging (2019-01-23 17:57:47 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20190124-pull-request

for you to fetch changes up to 2657846fb2e47e8ba847b5ef6fe742466414c745:

  input-linux: customizable grab toggle keys (2019-01-24 10:42:38 +0100)

----------------------------------------------------------------
input-linux: customizable grab toggle keys

----------------------------------------------------------------

Ryan El Kochta (1):
  input-linux: customizable grab toggle keys

 ui/input-linux.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 qapi/ui.json     | 10 +++++++++
 2 files changed, 73 insertions(+), 3 deletions(-)

-- 
2.9.3
