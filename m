Received: from eggs.gnu.org ([2001:4830:134:3::10]:34301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYpPI-0002gN-Oy
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 03:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYpPF-0007f3-Gr
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 03:37:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eYpPF-0007ej-Ac
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 03:37:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 618F6780F1
	for <qemu-devel@nongnu.org>; Tue,  9 Jan 2018 08:37:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 Jan 2018 09:37:04 +0100
Message-Id: <20180109083704.24075-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] spectre blog post: I accidentally a
 verb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

Reported-by: Fam Zheng <famz@redhat.com>
---
 _posts/2018-01-04-spectre.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/_posts/2018-01-04-spectre.md b/_posts/2018-01-04-spectre.md
index 353ac7c..aa0f5e4 100644
--- a/_posts/2018-01-04-spectre.md
+++ b/_posts/2018-01-04-spectre.md
@@ -60,7 +60,7 @@ Because the virtual CPU has to be changed to one with the new CPUID bits,
 the guest will have to be restarted.
 
 As of today, the QEMU project is not aware of whether similar changes will
-be required for non-x86 processors.  If so, they will also posted to the
+be required for non-x86 processors.  If so, they will also be posted to the
 mailing list and backported to recent stable releases.
 
 For more information on the vulnerabilities, please refer to the [Google Security
-- 
2.14.3
