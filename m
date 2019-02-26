Received: from eggs.gnu.org ([209.51.188.92]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyfqv-00041S-5R
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyfqs-0004Th-3F
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:09 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyfqr-0004QN-Bh
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:05 -0500
Received: by mail-wr1-x42e.google.com with SMTP id o17so14732472wrw.3
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 08:45:04 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 26 Feb 2019 16:44:57 +0000
Message-Id: <20190226164500.8080-4-alex.bennee@linaro.org>
In-Reply-To: <20190226164500.8080-1-alex.bennee@linaro.org>
References: <20190226164500.8080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/6] contrib: gitdm: add some more people
 academic group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>

I'm basing this on email addresses or published employment. Please
confirm if this is correct or you want to be under (None).

Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/group-map-academics | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-academics
index 08f9d81d13..a2a43fcc05 100644
--- a/contrib/gitdm/group-map-academics
+++ b/contrib/gitdm/group-map-academics
@@ -12,3 +12,12 @@ ispras.ru
 # Columbia University
 cs.columbia.edu
 cota@braap.org
+
+# École normale supérieure de Lyon
+samuel.thibault@ens-lyon.org
+
+# Centre de Recherche Astrophysique de Lyon
+aurelien@aurel32.net
+
+# Budapest University of Technology and Economics
+balaton@eik.bme.hu
-- 
2.20.1
