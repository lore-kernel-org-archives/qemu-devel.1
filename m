Received: from eggs.gnu.org ([2001:4830:134:3::10]:46929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ehchX-00083Z-3w
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ehchT-0007eW-5M
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:52:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ehchS-0007dX-UA
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:52:23 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  2 Feb 2018 14:34:10 +0800
Message-Id: <20180202063412.22466-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] Add git-publish config file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, stefanha@redhat.com

v2: Add README paragraph [Marc-Andr=C3=A9, Stefan]
    Fix 'trivial' profile [Marc-Andr=C3=A9]
    Rename profiles [Stefan]

Fam Zheng (2):
  Add a git-publish configuration file
  README: Document 'git-publish' workflow

 .gitpublish | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 README      | 30 +++++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 .gitpublish

--=20
2.14.3
