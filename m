Received: from eggs.gnu.org ([2001:4830:134:3::10]:33951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eM7Yi-00006Y-L3
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eM7Yf-0000ib-En
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:22:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eM7Yf-0000iX-8Q
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:22:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 645623680B
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 07:22:24 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Dec 2017 15:22:20 +0800
Message-Id: <20171205072220.885-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] MAITAINERS: List Fam Zheng as reviewer for
 SCSI patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Just so that I notice those patches more easily.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0255113470..64a138c380 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1000,6 +1000,7 @@ T: git git://github.com/jasowang/qemu.git net
 
 SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
+R: Fam Zheng <famz@redhat.com>
 S: Supported
 F: include/hw/scsi/*
 F: hw/scsi/*
@@ -1260,6 +1261,7 @@ T: git git://github.com/stefanha/qemu.git block
 
 Block SCSI subsystem
 M: Paolo Bonzini <pbonzini@redhat.com>
+R: Fam Zheng <famz@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: include/scsi/*
-- 
2.14.3
