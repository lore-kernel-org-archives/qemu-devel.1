Received: from eggs.gnu.org ([2001:4830:134:3::10]:47239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evLH1-0006GV-Eq
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evLGw-00024y-KV
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:05:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evLGw-00023s-FV
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:05:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E70474068056
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:05:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 12:05:31 +0100
Message-Id: <20180312110532.30967-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Usb 20180312 patches
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

The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca76:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-03-09 17:28:16 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20180312-pull-request

for you to fetch changes up to c7ac1ab0201d47d12b75e1c98d79869bcdad5732:

  usbredir: reorder fields in USBRedirDevice to reduce padding (2018-03-12 11:43:49 +0100)

----------------------------------------------------------------
usbredir: reorder fields in USBRedirDevice to reduce padding

----------------------------------------------------------------

zhenwei.pi (1):
  usbredir: reorder fields in USBRedirDevice to reduce padding

 hw/usb/redirect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.9.3
