Received: from eggs.gnu.org ([2001:4830:134:3::10]:57214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eQtIO-000379-Re
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eQtIO-0007ZV-1y
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:09:20 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:23914 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1eQtIN-0007Z0-NI
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:09:20 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 18 Dec 2017 14:09:06 +0300
Message-Id: <1513595351-5899-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 0/5] preparation for Parallels Disk xml driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, Klim Kireev <klim.kireev@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

Parallels Desktop and Parallels Cloud Server uses images glued with the
bundle description in XML format. This series contains very basic
description of this XML files and makes preparations for actual
implementation to be followed.

Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
