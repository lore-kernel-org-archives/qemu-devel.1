Received: from eggs.gnu.org ([2001:4830:134:3::10]:43661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eq94r-0001va-Md
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 22:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eq94o-000326-JN
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 22:03:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eq94o-00031d-Fp
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 22:03:42 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon, 26 Feb 2018 11:03:24 +0800
Message-Id: <20180226030326.20219-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/2] Add git-publish config file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, f4bug@amsat.org, stefanha@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

v4: Fix prefixes. [Stefan]
    Keep rich profiles. [Paolo]

v3: Fix trivial hunk placement. [Michael]
    Fix PPC sub-list. [Michael]

v2: Add README paragraph [Marc-Andr=C3=A9, Stefan]
    Fix 'trivial' profile [Marc-Andr=C3=A9]
    Rename profiles [Stefan]

Fam Zheng (2):
  Add a git-publish configuration file
  README: Document 'git-publish' workflow

 .gitpublish | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 README      | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 .gitpublish

--=20
2.14.3
