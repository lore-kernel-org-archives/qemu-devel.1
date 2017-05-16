Received: from eggs.gnu.org ([2001:4830:134:3::10]:60813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dAe58-00072t-Q6
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dAe55-0001cv-Hw
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:08:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dAe55-0001bz-Bq
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:08:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03DC47D4E6
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 15:07:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 16 May 2017 17:07:57 +0200
Message-Id: <1494947277-26158-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] Add a blog post with links to the
 presentations from the DevConf 2017
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This post provides links to the talks from the virtualization
track at the DevConf 2017 in Brno.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: I've added links to all presentations from the virtualization
 track ... not all of them are really related to QEMU, so not sure
 whether this is appropriate for the QEMU blog ... but I thought it
 would be nice to have a collection with all links, so I included all
 of them here.

 _posts/2017-05-16-devconf-presentations.md | 47 ++++++++++++++++++++++++=
++++++
 1 file changed, 47 insertions(+)
 create mode 100644 _posts/2017-05-16-devconf-presentations.md

diff --git a/_posts/2017-05-16-devconf-presentations.md b/_posts/2017-05-=
16-devconf-presentations.md
new file mode 100644
index 0000000..1c67bd5
--- /dev/null
+++ b/_posts/2017-05-16-devconf-presentations.md
@@ -0,0 +1,47 @@
+---
+layout: post
+title:  "Presentations from DevConf 2017"
+date:   2017-05-16 16:00:00 +0200
+author: Thomas Huth
+categories: presentations
+---
+There were a couple of QEMU / virtualization related talks at the
+[DevConf 2017](https://devconf.cz/2017/) conference that took place at t=
he
+end of January already, but so far we missed to gather the links to the
+recordings of these talks. So here is now the list:
+
+* [How to write a legacy storage device
+   emulator](https://www.youtube.com/watch?v=3DnnMso6RmiOU&t=3D258)
+  by John Snow
+
+* [GPU Passthrough using GNOME
+   Boxes](https://www.youtube.com/watch?v=3DO33s1paYuYg&t=3D75)
+  by Felipe Borges
+
+* [Self-virtualizing Linux on
+   x86](https://www.youtube.com/watch?v=3DGn7Bdq9_cUA&t=3D118)
+  by Radim Kr=C4=8Dm=C3=A1=C5=99=20
+
+* [New ways to remote desktops with GStreamer
+   integration](https://www.youtube.com/watch?v=3DC5ox_M-k63w)
+  by Victor Toso de Carvalho and Pavel Grunt
+
+* [Can VMs networking benefit from
+   DPDK](https://www.youtube.com/watch?v=3Dcbm30mPp0hE&t=3D210)
+  by Maxime Coquelin and Victor Kaplansky
+
+* [Windows VMs on KVM: The Good, the Bad and the
+   Ugly](https://www.youtube.com/watch?v=3Do3TBT68xCm8&t=3D92)
+  by Ladi Prosek
+
+* [Pet VMs in Kubernetes?
+   WTH](https://www.youtube.com/watch?v=3D_w4roI9T7VE&t=3D85)
+  by Fabian Deutsch
+
+* [Virtualization development improved with
+   Lago](https://www.youtube.com/watch?v=3DChtZaG_60AQ&t=3D48)
+  by Rafael Martins
+
+* [An ARMful of guests: virtualization on 64-bit
+   ARM](https://www.youtube.com/watch?v=3Dx1a_f_2IMG8)
+  by Andrea Bolognani
--=20
1.8.3.1
