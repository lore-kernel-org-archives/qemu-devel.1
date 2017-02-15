Received: from eggs.gnu.org ([2001:4830:134:3::10]:35540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ce0nG-0004Y2-U5
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ce0nC-000076-E5
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:42:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ce0nC-000060-8q
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:42:50 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 15 Feb 2017 14:42:46 +0000
Message-Id: <20170215144246.17756-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH qemu-web] Add Andrea's virtual memory FOSDEM
 presentation to blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>

From: Stefan Hajnoczi <stefanha@gmail.com>

Andrea's presentation touches on Transparent Huge Pages and post-copy
live migration using userfaultfd for virtualization use cases.

Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
---
I don't know jekyll or how the blog is set up.  Perhaps timestamps need
to be updated in the post file.  Please fix up when applying.
---
 _posts/2017-02-10-fosdem-presentations.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/_posts/2017-02-10-fosdem-presentations.md b/_posts/2017-02-10-fosdem-presentations.md
index 7a0840f..d297c5f 100644
--- a/_posts/2017-02-10-fosdem-presentations.md
+++ b/_posts/2017-02-10-fosdem-presentations.md
@@ -27,3 +27,7 @@ and the videos of their presentations are now available online, too:
 * [Using NVDIMM under KVM -- Applications of persistent memory in
    virtualization](https://fosdem.org/2017/schedule/event/iaas_usinvdund/)
   by Stefan Hajnoczi
+
+* [20 years of Linux Virtual Memory -- From simple server workloads to cloud
+   virtualization](https://fosdem.org/2017/schedule/event/iaas_20yealin/)
+  by Andrea Arcangeli
-- 
2.9.3
