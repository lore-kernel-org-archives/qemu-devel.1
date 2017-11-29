Received: from eggs.gnu.org ([2001:4830:134:3::10]:56099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK4Kc-0006er-LO
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK4KZ-0000ra-FB
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:31:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eK4KZ-0000rI-8W
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:31:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 635D38047F
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 15:31:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 29 Nov 2017 09:31:16 -0600
Message-Id: <20171129153116.26243-1-eblake@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] Mention website maintainence under
 Contribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com

Web (and other doc) updates are also valid contributions.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 contribute.md | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contribute.md b/contribute.md
index bf4a55d..88baee6 100644
--- a/contribute.md
+++ b/contribute.md
@@ -12,4 +12,6 @@ permalink: /contribute/
 * Chat with the developers on IRC: irc.oftc.net, channel #qemu

 * Read developer documentation: &ldquo;[Getting started for developers](https://wiki.qemu.org/Documentation/GettingStartedDevelopers)&rdquo;,
-  &ldquo;[Contributor FAQ](https://wiki.qemu.org/Contribute/FAQ)&rdquo;, &ldquo;[How to submit a patch](https://wiki.qemu.org/Contribute/SubmitAPatch)&rdquo;
+  &ldquo;[Contributor FAQ](https://wiki.qemu.org/Contribute/FAQ)&rdquo;,
+  &ldquo;[How to submit a patch](https://wiki.qemu.org/Contribute/SubmitAPatch)&rdquo;,
+  &ldquo;[Improve the website](https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/)&rdquo;
-- 
2.14.3
