Received: from eggs.gnu.org ([2001:4830:134:3::10]:44972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dhEaC-0000Of-U9
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dhEa8-0000eC-HU
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:35:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dhEa8-0000dZ-Ah
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:34:56 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2017 20:34:49 +0800
Message-Id: <1502714090-5629-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V3] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: cohuck@redhat.com, Jason Wang <jasowang@redhat.com>

The following changes since commit 9db6ffc76676731a25a5538ab71e8ca6ac234f80:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-08-11 15:11:50 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to bd7adc84492e8e31a48917f515b8a5f598d84544:

  qemu-doc: Mention host_net_add/-remove in the deprecation chapter (2017-08-14 20:29:48 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Thomas Huth (1):
      qemu-doc: Mention host_net_add/-remove in the deprecation chapter

 qemu-doc.texi | 8 ++++++++
 1 file changed, 8 insertions(+)
