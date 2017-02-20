Received: from eggs.gnu.org ([2001:4830:134:3::10]:38260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfo6R-0007kv-Uf
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfo6O-00031m-1F
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:34:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cfo6N-0002zM-SJ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:34:03 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B11E061D2D
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 13:34:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1KDY02O010321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 08:34:01 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Feb 2017 14:33:56 +0100
Message-Id: <1487597638-28323-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] QAPI patches for 2017-02-20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit d514cfd763b271b4e97a9fc6adaabc8fd50084=
ab:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-02-20 09:53:59 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-02-20

for you to fetch changes up to fea346f569d4132296f7c26367374fcace80e096:

  Makefile: Put VERSION info into version.texi rather than using -D (2017=
-02-20 14:11:07 +0100)

----------------------------------------------------------------
QAPI patches for 2017-02-20

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      qapi2texi: replace quotation by bold section name

Peter Maydell (1):
      Makefile: Put VERSION info into version.texi rather than using -D

 .gitignore             |  1 +
 Makefile               | 17 ++++++++++-------
 docs/qemu-ga-ref.texi  |  2 ++
 docs/qemu-qmp-ref.texi |  2 ++
 scripts/qapi2texi.py   | 10 ++++------
 5 files changed, 19 insertions(+), 13 deletions(-)

Marc-Andr=C3=A9 Lureau (1):
  qapi2texi: replace quotation by bold section name

Peter Maydell (1):
  Makefile: Put VERSION info into version.texi rather than using -D

 .gitignore             |  1 +
 Makefile               | 17 ++++++++++-------
 docs/qemu-ga-ref.texi  |  2 ++
 docs/qemu-qmp-ref.texi |  2 ++
 scripts/qapi2texi.py   | 10 ++++------
 5 files changed, 19 insertions(+), 13 deletions(-)

--=20
2.7.4
