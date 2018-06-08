Received: from eggs.gnu.org ([2001:4830:134:3::10]:47490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRR4X-0005h2-3x
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 19:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRR4S-0007fJ-8C
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 19:45:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:46576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fRR4S-0007e5-0h
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 19:45:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fRR4P-0004xB-4A
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 23:45:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F2BF82E80CB
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 23:45:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Jun 2018 23:32:55 -0000
From: wzis <wzis@hotmail.com>
Reply-To: Bug 1463812 <1463812@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150610121234.13038.87729.malonedeb@wampee.canonical.com>
	<152846752227.21307.159330233193934569.malone@gac.canonical.com>
Message-Id: <KL1PR0401MB1992BDF3D46B7F6772DBC2BFD87B0@KL1PR0401MB1992.apcprd04.prod.outlook.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1463812] Re: qemu-system-ppc64 V2.30 cause
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

It seems to me that no one has really looked into the matter, I can't
find any comments,that this issue has been worked on.

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
