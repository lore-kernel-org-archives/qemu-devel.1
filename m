Received: from eggs.gnu.org ([2001:4830:134:3::10]:47562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJ8l-0007En-FW
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJ8k-0004LM-Nc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:46:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebJ8k-0004Ki-HL
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:46:26 -0500
Date: Tue, 16 Jan 2018 06:46:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516077852-7974-2-git-send-email-mst@redhat.com>
References: <1516077852-7974-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516077852-7974-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 01/33] MAINTAINERS: Add myself as maintainer to
 X86 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4770f10..753e799 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -852,6 +852,7 @@ X86 Machines
 ------------
 PC
 M: Michael S. Tsirkin <mst@redhat.com>
+M: Marcel Apfelbaum <marcel@redhat.com>
 S: Supported
 F: include/hw/i386/
 F: hw/i386/
-- 
MST
