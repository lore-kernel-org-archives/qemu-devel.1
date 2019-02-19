Received: from eggs.gnu.org ([209.51.188.92]:51252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0tv-00009o-6L
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0tu-0004Ad-IH
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gw0tu-0004AK-BU
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92E2379712
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:37:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Feb 2019 09:36:50 +0100
Message-Id: <1550565421-10944-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1550565421-10944-1-git-send-email-thuth@redhat.com>
References: <1550565421-10944-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/14] MAINTAINERS: Add missing entries for the
 PC machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index feb9095..2cc112c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1181,6 +1181,10 @@ F: hw/acpi/ich9.c
 F: include/hw/acpi/ich9.h
 F: include/hw/acpi/piix4.h
 F: hw/misc/sga.c
+F: hw/isa/apm.c
+F: include/hw/isa/apm.h
+F: tests/test-x86-cpuid.c
+F: tests/test-x86-cpuid-compat.c
=20
 PC Chipset
 M: Michael S. Tsirkin <mst@redhat.com>
--=20
1.8.3.1
