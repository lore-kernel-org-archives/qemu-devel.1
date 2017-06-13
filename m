Received: from eggs.gnu.org ([2001:4830:134:3::10]:49067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlyt-0002mi-FF
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlyq-0001Eo-Dh
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:35:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dKlyq-0001EP-8D
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:35:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Jun 2017 14:35:29 +0100
Message-Id: <20170613133531.24671-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 9746211baa6ff1275e9c726c6f3a3bcfe4b1f8bd:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-20170609' into staging (2017-06-13 11:56:00 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to b097efc0027e36fd15a4fc2e415e780611024757:

  monitor: resurrect handle_qmp_command trace event (2017-06-13 14:35:11 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (2):
  monitor: add handle_hmp_command trace event
  monitor: resurrect handle_qmp_command trace event

 monitor.c    | 7 +++++++
 trace-events | 2 ++
 2 files changed, 9 insertions(+)

-- 
2.9.4
