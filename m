Received: from eggs.gnu.org ([2001:4830:134:3::10]:42696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrh-00043z-DD
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNre-0006yJ-Ca
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:25 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNre-0006y8-8M
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:22 -0400
Received: by mail-qt0-x244.google.com with SMTP id m54so7059376qtb.1
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 18:03:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 28 Jun 2017 22:02:55 -0300
Message-Id: <20170629010300.2848-4-f4bug@amsat.org>
In-Reply-To: <20170629010300.2848-1-f4bug@amsat.org>
References: <20170629010300.2848-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/8] MAINTAINERS: update Xen entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Anthony Xu <anthony.xu@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

moved in 56e2cd24..28b99f47 to accel/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86a08c5aac..530293044b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -323,7 +323,6 @@ M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony Perard <anthony.perard@citrix.com>
 L: xen-devel@lists.xenproject.org
 S: Supported
-F: xen-*
 F: */xen*
 F: hw/9pfs/xen-9p-backend.c
 F: hw/char/xen_console.c
-- 
2.13.1
