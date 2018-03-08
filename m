Received: from eggs.gnu.org ([2001:4830:134:3::10]:41468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrIc-0001Em-D4
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrIb-0008G9-LL
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:53:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49714 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etrIb-0008G1-Go
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:53:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2CD2D142D
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 08:53:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Mar 2018 09:52:59 +0100
Message-Id: <20180308085301.8875-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] modules: two fixes
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



Gerd Hoffmann (2):
  modules: use gmodule-export
  modules: workaround buggy glib builds

 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--=20
2.9.3
