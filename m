Received: from eggs.gnu.org ([2001:4830:134:3::10]:43760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejKEa-0004Ly-Sh
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejKEX-00086g-PC
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:33:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50822 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ejKEX-000867-K9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:33:33 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  7 Feb 2018 08:33:24 +0100
Message-Id: <1517988804-15597-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [qemu-web PATCH v2] Add a blog post with the
 presentations from DevConf and FOSDEM 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Otubo <otubo@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Pankaj Gupta <pagupta@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

Let's provide some links to the videos from FOSDEM and DevConf.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eduardo Otubo <otubo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2:
 - Added link to the virtio 1.1 talk
 - Added links to the schedules of the virtualization tracks

 _posts/2018-02-06-devconf-fosdem.md | 46 +++++++++++++++++++++++++++++++=
++++++
 1 file changed, 46 insertions(+)
 create mode 100644 _posts/2018-02-06-devconf-fosdem.md

diff --git a/_posts/2018-02-06-devconf-fosdem.md b/_posts/2018-02-06-devc=
onf-fosdem.md
new file mode 100644
index 0000000..74f7eb4
--- /dev/null
+++ b/_posts/2018-02-06-devconf-fosdem.md
@@ -0,0 +1,46 @@
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
+* [What's new in Virtio 1.1](https://fosdem.org/2018/schedule/event/virt=
io/)
+  by Jens Freimann
+
+* [Live Block Device Operations in
+  QEMU](https://fosdem.org/2018/schedule/event/vai_qemu_live_dev_operati=
ons/)
+  by Kashyap Chamarthy
+
+* [Vectors Meet
+  Virtualization](https://fosdem.org/2018/schedule/event/vai_vectors_mee=
t_virtualization/)
+  by Alex Benn=C3=A9e
+
+* [Finding your way through the QEMU parameter
+  jungle](https://fosdem.org/2018/schedule/event/vai_qemu_jungle/)
+  by Thomas Huth
+
+More virtualization related talks can be found in the [schedule from
+the DevConf](https://devconfcz2018.sched.com/type/virtualization) and
+in the [schedule from the
+FOSDEM](https://fosdem.org/2018/schedule/track/virtualization_and_iaas/)=
.
--=20
1.8.3.1
