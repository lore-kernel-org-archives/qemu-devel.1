Received: from eggs.gnu.org ([2001:4830:134:3::10]:53442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cpXQ4-0001en-P3
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 05:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cpXQ1-0006Fc-0v
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 05:46:36 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cpXQ0-0006FH-RB
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 05:46:32 -0400
Received: by mail-wm0-x243.google.com with SMTP id x124so9711069wmf.3
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 02:46:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 19 Mar 2017 10:46:31 +0100
Message-Id: <20170319094631.17298-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [qemu-web PATCH] New blog post: "QEMU in the blogs:
 February 2017"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com

Just an idea... If this is useful, we can do it every month.  It only
takes ten minutes to skim planet.virt-tools.org and compile the list.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../2017-03-19-qemu-in-the-blogs-february-2017.md  | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 _posts/2017-03-19-qemu-in-the-blogs-february-2017.md

diff --git a/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md b/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md
new file mode 100644
index 0000000..dd080f1
--- /dev/null
+++ b/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md
@@ -0,0 +1,33 @@
+---
+layout: post
+title:  "QEMU in the blogs: February 2017"
+date:   2017-03-19 10:30:00 +0100
+author: Paolo Bonzini
+categories: blog posts
+---
+Here is a short list of articles and blog posts about QEMU
+and KVM, that were posted last month.
+
+* [QEMU and the qcow2 metadata
+  checks](https://blogs.igalia.com/berto/2017/02/08/qemu-and-the-qcow2-metadata-checks/)
+  by Alberto Garcia
+
+* [Running Hyper-V in a QEMU/KVM
+  Guest](https://ladipro.wordpress.com/2017/02/24/running-hyperv-in-kvm-guest/)
+  by Ladislav Prošek
+
+* [Setting up a nested KVM guest for developing & testing PCI device assignment
+  with NUMA](https://www.berrange.com/posts/2017/02/16/setting-up-a-nested-kvm-guest-for-developing-testing-pci-device-assignment-with-numa/)
+  by Daniel P. Berrangé
+
+* [Testing SMM with QEMU, KVM and
+  libvirt](https://github.com/tianocore/tianocore.github.io/wiki/Testing-SMM-with-QEMU,-KVM-and-libvirt)
+  by László Eršek
+
+* [The surprisingly complicated world of disk image
+  sizes](https://www.berrange.com/posts/2017/02/10/the-surprisingly-complicated-world-of-disk-image-sizes/)
+  by Daniel P. Berrangé
+
+
+In other news, QEMU is now in hard freeze for release 2.9.0.  The preliminary
+list of features is on the [wiki](http://wiki.qemu-project.org/ChangeLog/2.9).
-- 
2.9.3
