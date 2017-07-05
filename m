Received: from eggs.gnu.org ([2001:4830:134:3::10]:45009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSgBa-0004Ro-3a
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSgBV-0000ym-Ab
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:01:26 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dSgBV-0000yh-1e
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:01:21 -0400
Received: by mail-wm0-x242.google.com with SMTP id j85so30982879wmj.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 02:01:20 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed,  5 Jul 2017 12:01:12 +0300
Message-Id: <20170705090113.7036-1-sameeh@daynix.com>
Subject: [Qemu-devel] [Qemu-GA-Win PATCH v3] qemu-ga-win localization fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

This version doesn't differ from v2 at all, v2 have been waiting too
long for a review, so I'm resending it again.

Daniel Rempel (1):
  qga-win: fix installation on localized windows

 qga/vss-win32/install.cpp | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

-- 
2.9.4
