Received: from eggs.gnu.org ([2001:4830:134:3::10]:42710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNri-00044b-95
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrh-000700-Da
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:26 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrh-0006zi-Aq
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:25 -0400
Received: by mail-qt0-x242.google.com with SMTP id c20so9576430qte.0
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 18:03:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 28 Jun 2017 22:02:56 -0300
Message-Id: <20170629010300.2848-5-f4bug@amsat.org>
In-Reply-To: <20170629010300.2848-1-f4bug@amsat.org>
References: <20170629010300.2848-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/8] MAINTAINERS: update TCI entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Yang Zhong <yang.zhong@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

moved in 244f1441 to tcg/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 530293044b..9bad523060 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1654,7 +1654,7 @@ TCI target
 M: Stefan Weil <sw@weilnetz.de>
 S: Maintained
 F: tcg/tci/
-F: tci.c
+F: tcg/tci.c
 F: disas/tci.c
 
 Block drivers
-- 
2.13.1
