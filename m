Received: from eggs.gnu.org ([2001:4830:134:3::10]:46192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdKZ3-0001x5-Oi
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdKZ0-0003VX-Gy
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:14:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdKZ0-0003VR-CS
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:14:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D5808182D20
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 19:14:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-125.ams2.redhat.com
	[10.36.116.125])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D720410FFE4D
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 19:14:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 11 Jul 2018 21:14:07 +0200
Message-Id: <20180711191408.2438-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Monitor patches for 2018-07-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit c447afd5783b9237fa51b7a85777007d8d568b=
fc:

  Update version for v3.0.0-rc0 release (2018-07-10 18:19:50 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-07-11

for you to fetch changes up to 42eab8dbec2f3fd4a14bd63ab01aa155ce5724a3:

  monitor: fix double-free of request error (2018-07-11 21:11:15 +0200)

----------------------------------------------------------------
Monitor patches for 2018-07-11

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      monitor: fix double-free of request error

 monitor.c | 1 +
 1 file changed, 1 insertion(+)

Marc-Andr=C3=A9 Lureau (1):
  monitor: fix double-free of request error

 monitor.c | 1 +
 1 file changed, 1 insertion(+)

--=20
2.17.1
