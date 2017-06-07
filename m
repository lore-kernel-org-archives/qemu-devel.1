Received: from eggs.gnu.org ([2001:4830:134:3::10]:50701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIScR-0001Wp-Ml
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIScQ-0007TW-Im
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:30:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:49192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dIScQ-0007Sd-1p
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:30:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dIScO-0003wf-2n
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 04:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4CCCE2E81A4
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 04:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2017 04:17:35 -0000
From: Launchpad Bug Tracker <1089005@bugs.launchpad.net>
Reply-To: Bug 1089005 <1089005@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121211164752.19821.67677.malonedeb@wampee.canonical.com>
Message-Id: <149680905529.16952.4097431725407522248.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1089005] Re: Qemu does not shutdown with vnc
 enabled on OS X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1089005

Title:
  Qemu does not shutdown with vnc enabled on OS X

Status in QEMU:
  Expired

Bug description:
  I am running OS X 10.8.2 and Qemu 1.3.50 from your git repository.

  Running

      qemu-system-i386 <image>

  works fine. I can quit the process using ctrl-c.

  When I try to use

       qemu-system-i386 -vnc :<port> <image>

  ctrl-c does nothing and I have to kill the process trough the activity mo=
nitor.
  Furthermore terminating the process from my java program does not work ei=
ther. =

  I have also posted a question on Stackoverflow: http://stackoverflow.com/=
questions/13798367/qemu-does-not-shutdown-with-vnc-enabled-on-os-x

  Thanks
  Leander

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1089005/+subscriptions
