Received: from eggs.gnu.org ([2001:4830:134:3::10]:42255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cc8TW-0005Az-3e
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cc8TR-0000wY-DM
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:30:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cc8TQ-0000wS-Vp
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:30:41 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25D6C80489
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 10:30:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 10 Feb 2017 11:30:39 +0100
Message-Id: <1486722639-6586-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Add a blog post with the presentations from
 the FOSDEM 2017
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

The videos are now available online, so here's a blog post
that contains the links to the QEMU-related videos.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 _posts/2017-02-10-fosdem-presentations.md | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 _posts/2017-02-10-fosdem-presentations.md

diff --git a/_posts/2017-02-10-fosdem-presentations.md b/_posts/2017-02-10-fosdem-presentations.md
new file mode 100644
index 0000000..707d5c7
--- /dev/null
+++ b/_posts/2017-02-10-fosdem-presentations.md
@@ -0,0 +1,30 @@
+---
+layout: post
+title:  "Presentations from the FOSDEM 2017"
+date:   2017-02-10 11:30:00 +0100
+author: Thomas Huth
+categories: presentations
+---
+During last weekend, on February 4th and 5th, the
+[FOSDEM 2017](https://fosdem.org/2017/) conference took place in Brussels,
+which featured a [Virtualisation and IaaS
+track](https://fosdem.org/2017/schedule/track/virtualisation_and_iaas/).
+
+Some people of the QEMU community attended, and the videos of the
+presenters are now available online, too:
+
+* [Incremental Backups -- Good things come in small
+   packages!](https://fosdem.org/2017/schedule/event/backup_dr_incr_backups/)
+  by John Snow
+
+* [Internal APIs and conflicting world views -- How abstractions inside QEMU
+  (don't) work together](https://fosdem.org/2017/schedule/event/iaas_qemintapi/)
+  by Eduardo Habkost
+
+* [Network Block Device -- how, what,
+   why](https://fosdem.org/2017/schedule/event/iaas_netblodev/)
+  by Wouter Verhelst
+
+* [Using NVDIMM under KVM -- Applications of persistent memory in
+   virtualization](https://fosdem.org/2017/schedule/event/iaas_usinvdund/)
+  by Stefan Hajnoczi
-- 
1.8.3.1
