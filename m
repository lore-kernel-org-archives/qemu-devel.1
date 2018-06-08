Received: from eggs.gnu.org ([2001:4830:134:3::10]:54159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRIUi-0003BM-CP
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRIUf-00085R-Eo
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:36:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:55290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fRIUf-000844-7m
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:35:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fRIUe-0006o1-46
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 14:35:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1B14D2E80C7
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 14:35:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Jun 2018 14:18:42 -0000
From: Thomas Huth <1463812@bugs.launchpad.net>
Reply-To: Bug 1463812 <1463812@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150610121234.13038.87729.malonedeb@wampee.canonical.com>
Message-Id: <152846752227.21307.159330233193934569.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1463812] Re: qemu-system-ppc64 V2.30 cause
 RHEL5.9 disk corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1463812

Title:
  qemu-system-ppc64 V2.30 cause RHEL5.9 disk corruption

Status in QEMU:
  Incomplete

Bug description:
  copied the RHEL5.9 power disk image from qemu 1.5.3, run it under qemu 2.=
3.0, corrupted; copied again, run, corrupted again.
  Run the image on qemu 1.5.3, no problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1463812/+subscriptions
