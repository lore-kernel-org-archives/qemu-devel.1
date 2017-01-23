Received: from eggs.gnu.org ([2001:4830:134:3::10]:38231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo24-0003OP-5H
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo23-00068s-4P
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVo22-00067z-VF
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:15 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 21:27:34 -0200
Message-Id: <20170123232738.20796-10-ehabkost@redhat.com>
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 09/13] MAINTAINERS: Add an entry for
 hw/core/null-machine.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The "Machine core" section sounds like a good match for this file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1485150895-19753-1-git-send-email-thuth@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad1000415d..57bd0276e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -813,6 +813,7 @@ M: Eduardo Habkost <ehabkost@redhat.com>
 M: Marcel Apfelbaum <marcel@redhat.com>
 S: Supported
 F: hw/core/machine.c
+F: hw/core/null-machine.c
 F: include/hw/boards.h
 
 Xtensa Machines
-- 
2.11.0.259.g40922b1
