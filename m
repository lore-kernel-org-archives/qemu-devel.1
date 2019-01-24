Received: from eggs.gnu.org ([209.51.188.92]:44221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmeSF-00013e-Pg
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmeSF-00011w-27
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:49:59 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 24 Jan 2019 13:49:03 +0100
Message-Id: <20190124124906.16653-3-laurent@vivier.eu>
In-Reply-To: <20190124124906.16653-1-laurent@vivier.eu>
References: <20190124124906.16653-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/5] contrib/gitdm: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Typo comes from upstream git://git.lwn.net/gitdm.git.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190111155555.8270-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 contrib/gitdm/filetypes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
index 15d6f803b9..165b71b3f9 100644
--- a/contrib/gitdm/filetypes.txt
+++ b/contrib/gitdm/filetypes.txt
@@ -4,7 +4,7 @@
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
-# (at your option  any later version.
+# (at your option) any later version.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.20.1
