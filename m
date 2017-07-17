Received: from eggs.gnu.org ([2001:4830:134:3::10]:51101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2Vn-0000i5-Eq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2Vj-0001hS-HX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:40:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX2Vj-0001gh-CA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:40:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6038985376
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:40:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:40:10 +0200
Message-Id: <20170717094011.15905-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Usb 20170717 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 6e2c46334385c7e295ac883c801c81b4925fb54f:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170711' into staging (2017-07-13 10:47:10 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20170717-pull-request

for you to fetch changes up to 2a7f2630684ee556a394a354d64159a4470c0151:

  ehci: add sanity check for maxframes (2017-07-17 11:39:08 +0200)

----------------------------------------------------------------
ehci fix for 2.10

----------------------------------------------------------------

Gerd Hoffmann (1):
  ehci: add sanity check for maxframes

 hw/usb/hcd-ehci.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.9.3
