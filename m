Received: from eggs.gnu.org ([2001:4830:134:3::10]:55646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtt8-0004Yr-At
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtt5-0002nm-Kf
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:22 -0400
Received: from mail-yw0-x22a.google.com ([2607:f8b0:4002:c05::22a]:35061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtt5-0002nY-GZ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:19 -0400
Received: by mail-yw0-x22a.google.com with SMTP id v7so21741952ywc.2
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 09:14:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Jun 2017 13:13:34 -0300
Message-Id: <20170616161334.7492-12-f4bug@amsat.org>
In-Reply-To: <20170616161334.7492-1-f4bug@amsat.org>
References: <20170616161334.7492-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/11] MAINTAINERS: self-appoint me as reviewer
 in build/test automation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 120788d8fb..e62cbc439a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1858,6 +1858,7 @@ Build and test automation
 -------------------------
 M: Alex Bennée <alex.bennee@linaro.org>
 M: Fam Zheng <famz@redhat.com>
+R: Philippe Mathieu-Daudé <f4bug@amsat.org>
 L: qemu-devel@nongnu.org
 S: Maintained
 F: .travis.yml
-- 
2.11.0
