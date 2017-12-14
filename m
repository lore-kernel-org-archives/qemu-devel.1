Received: from eggs.gnu.org ([2001:4830:134:3::10]:55213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePa1U-0001yl-Aq
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 15:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePa1R-0006ev-Mg
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 15:22:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePa1R-0006e7-GU
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 15:22:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F8E4883A4
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 20:22:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 14 Dec 2017 20:22:18 +0000
Message-Id: <20171214202220.20379-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] vhost-user: document memory accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

These patches document how memory accesses work and fix indentation in the
vhost-user protocol specification.

Stefan Hajnoczi (2):
  vhost-user: fix indentation in protocol specification
  vhost-user: document memory accesses

 docs/interop/vhost-user.txt | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

-- 
2.14.3
