Received: from eggs.gnu.org ([2001:4830:134:3::10]:58842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk12B-0005G3-LH
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk12A-0001wu-Ng
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:43:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dk12A-0001wY-HW
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:43:22 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 22 Aug 2017 12:41:54 +0800
Message-Id: <20170822044155.2451-10-famz@redhat.com>
In-Reply-To: <20170822044155.2451-1-famz@redhat.com>
References: <20170822044155.2451-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/10] MAINTAINERS: Add tests/vm entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ccee28b12d..0ed607d003 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1881,6 +1881,7 @@ S: Maintained
 F: .travis.yml
 F: .shippable.yml
 F: tests/docker/
+F: tests/vm/
 W: https://travis-ci.org/qemu/qemu
 W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
-- 
2.13.5
