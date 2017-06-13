Received: from eggs.gnu.org ([2001:4830:134:3::10]:43419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKqXY-0006ru-Mb
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKqXW-0005LA-VE
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:33889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dKqXW-0005Kw-Pa
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dKqXV-00042b-Ig
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 18:27:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8C6D22E8197
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 18:27:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 18:10:03 -0000
From: Thomas Huth <1042654@bugs.launchpad.net>
Reply-To: Bug 1042654 <1042654@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120828092908.6948.63420.malonedeb@gac.canonical.com>
Message-Id: <149737740307.2153.17362860063240879088.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1042654] Re: Floppy disks and network not working
 on NT 3.1 on Qemu 1.2 rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Unfortunately the URL from comment #7 is dead nowadays ... has this fix
been committed to the QEMU repository?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1042654

Title:
  Floppy disks and network not working on NT 3.1 on Qemu 1.2 rc1

Status in QEMU:
  Incomplete

Bug description:
  When I try to put Floppy IMG/IMA/VFD images on NT 3.1 when it is running =
on Qemu 1.2 rc, they are not recognized and the network is not working even=
 though I set it correctly (especially the AMD PCnet adapter)
  Here's some screenshot of the floppy error:
  http://i49.tinypic.com/j77wcw.png

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1042654/+subscriptions
