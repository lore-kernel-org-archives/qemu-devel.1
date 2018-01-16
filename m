Received: from eggs.gnu.org ([2001:4830:134:3::10]:40407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRXT-0008Qh-8J
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRXS-0001PB-DG
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebRXS-0001Om-7m
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:30 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 16 Jan 2018 13:42:15 +0000
Message-Id: <20180116134217.8725-13-berrange@redhat.com>
In-Reply-To: <20180116134217.8725-1-berrange@redhat.com>
References: <20180116134217.8725-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 12/14] ui: update keycodemapdb to get py3
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/keycodemapdb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/keycodemapdb b/ui/keycodemapdb
index 05dad417e9..6b3d716e2b 160000
--- a/ui/keycodemapdb
+++ b/ui/keycodemapdb
@@ -1 +1 @@
-Subproject commit 05dad417e9d0b37ee1fba33056d91a6b734b3357
+Subproject commit 6b3d716e2b6472eb7189d3220552280ef3d832ce
-- 
2.14.3
