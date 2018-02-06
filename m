Received: from eggs.gnu.org ([2001:4830:134:3::10]:58451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ej6Ev-0003DK-A4
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ej6Es-00034j-NM
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:37:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ej6Es-00034S-Ho
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:36:58 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  6 Feb 2018 17:36:48 +0100
Message-Id: <1517935008-4702-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [qemu-web PATCH] Add a blog post with the
 presentations from DevConf and FOSDEM 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Otubo <otubo@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Pankaj Gupta <pagupta@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

Let's provide some links to the videos from DevConf and FOSDEM.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 I've tried my best to find all talks that are related to QEMU, not sure
 whether I've correctly identified all of them. If you are aware of any
 other talk that should be in the list here, please let me know.

 _posts/2018-02-06-devconf-fosdem.md | 37 +++++++++++++++++++++++++++++++=
++++++
 1 file changed, 37 insertions(+)
 create mode 100644 _posts/2018-02-06-devconf-fosdem.md

diff --git a/_posts/2018-02-06-devconf-fosdem.md b/_posts/2018-02-06-devc=
onf-fosdem.md
new file mode 100644
index 0000000..48eb7bf
--- /dev/null
+++ b/_posts/2018-02-06-devconf-fosdem.md
@@ -0,0 +1,37 @@
+---
+layout: post
+title:  "Presentations from DevConf and FOSDEM 2018"
+date:   2018-02-06 17:00:00 +0100
+author: Thomas Huth
+categories: [presentations, conferences]
+---
+During the past two weeks, there were two important conferences for Open
+Source developers in Europe, where you could also enjoy some QEMU relate=
d
+presentations. The following QEMU-related talks were held at the
+[DevConf 2018](https://devconf.cz/cz/2018) conference in Brno:
+
+* [Eliminating guest page cache](https://www.youtube.com/watch?v=3DNG0n5=
MTXOa4)
+  by Pankaj Gupta
+
+* [Anatomy of KVM Guest](https://www.youtube.com/watch?v=3Dt-MSukwDqeM)
+  by Prasad J Pandit
+
+* [QEMU Sandboxing for dummies](https://www.youtube.com/watch?v=3D_7yGia=
fZdVc)
+  by Eduardo Otubo
+
+And at the [FOSDEM 2018](https://fosdem.org/2018/) in Brussels, you coul=
d
+listen to the following QEMU related talks:
+
+* [QEMU in UEFI](https://fosdem.org/2018/schedule/event/vai_qemu_in_uefi=
/)
+  by Alexander Graf
+
+* [Live Block Device Operations in
+   QEMU](https://fosdem.org/2018/schedule/event/vai_qemu_live_dev_operat=
ions/)
+  by Kashyap Chamarthy
+
+* [Vectors Meet
+   Virtualization](https://fosdem.org/2018/schedule/event/vai_vectors_me=
et_virtualization/)
+  by Alex Benn=C3=A9e
+
+* [Finding your way through the QEMU parameter
+  jungle](https://fosdem.org/2018/schedule/event/vai_qemu_jungle/)
--=20
1.8.3.1
