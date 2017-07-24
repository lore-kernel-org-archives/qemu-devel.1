Received: from eggs.gnu.org ([2001:4830:134:3::10]:38581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZdvp-0003aM-NE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZdvl-0006VV-Jc
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dZdvl-0006UB-E3
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B0A7C00574B
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:01:52 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-48.rdu2.redhat.com [10.10.121.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0ABC6F97E
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:01:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 24 Jul 2017 09:01:47 -0500
Message-Id: <20170724140149.1933-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.10 0/2] NBD patches for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit cf44d31d35df3de9d4f49339254050195f777f=
3e:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-18-=
v2' into staging (2017-07-24 13:21:33 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-07-24

for you to fetch changes up to c2a3d7dad2e153668b5a004e4f8336da92c476e1:

  maint: Reorder include directives for qemu-{nbd, io} (2017-07-24 08:53:=
08 -0500)

----------------------------------------------------------------
nbd patches for 2017-07-24

- Eric Blake: [0/2] Update qemu-nbd version

----------------------------------------------------------------
Eric Blake (2):
      qemu-nbd: Update version string
      maint: Reorder include directives for qemu-{nbd, io}

 qemu-img.c |  3 ++-
 qemu-nbd.c | 13 +++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

--=20
2.13.3
