Received: from eggs.gnu.org ([2001:4830:134:3::10]:36992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fL4iB-0000oW-Hs
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fL4iA-0004ih-C4
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:40:11 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:40:00 +0100
Message-Id: <20180522104000.9044-6-peter.maydell@linaro.org>
In-Reply-To: <20180522104000.9044-1-peter.maydell@linaro.org>
References: <20180522104000.9044-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 5/5] qemu-doc.texi: Rename references to 2.13
 to 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

Update references to 2.13 to read 3.0, since that's the
number we're using for the next release.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-doc.texi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 0e0e0ae72b..cac1c3b39e 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2917,7 +2917,7 @@ The @code{-localtime} option has been replaced by @code{-rtc base=localtime}.
 
 The @code{-startdate} option has been replaced by @code{-rtc base=@var{date}}.
 
-@subsection -virtioconsole (since 2.13.0)
+@subsection -virtioconsole (since 3.0.0)
 
 Option @option{-virtioconsole} has been replaced by
 @option{-device virtconsole}.
@@ -2940,7 +2940,7 @@ from qcow2 images.
 
 The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
 
-@subsection query-cpus-fast "arch" output member (since 2.13.0)
+@subsection query-cpus-fast "arch" output member (since 3.0.0)
 
 The ``arch'' output member of the ``query-cpus-fast'' command is
 replaced by the ``target'' output member.
-- 
2.17.0
