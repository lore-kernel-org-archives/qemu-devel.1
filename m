Received: from eggs.gnu.org ([2001:4830:134:3::10]:32930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ceWon-0003u6-Ck
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ceWom-0001qb-Co
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:54:37 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1ceWom-0001qA-7v
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:54:36 -0500
Received: by mail-qt0-x241.google.com with SMTP id w20so4309328qtb.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 16:54:36 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 16 Feb 2017 19:54:31 -0500
Message-Id: <20170217005431.4016-3-bobby.prani@gmail.com>
In-Reply-To: <20170217005431.4016-1-bobby.prani@gmail.com>
References: <20170217005431.4016-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] Create README.md as a symlink to README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org, berrange@redhat.com, eblake@redhat.com

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 README.md

diff --git a/README.md b/README.md
new file mode 120000
index 0000000000..100b93820a
--- /dev/null
+++ b/README.md
@@ -0,0 +1 @@
+README
\ No newline at end of file
-- 
2.11.0
