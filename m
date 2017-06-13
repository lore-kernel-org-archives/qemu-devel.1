Received: from eggs.gnu.org ([2001:4830:134:3::10]:36876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKq2L-0007cz-99
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKq2G-00045v-Dz
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:55:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:49906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dKq2G-00045l-8O
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:55:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dKq2F-0006YZ-0M
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 17:55:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F32BE2E8194
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 17:55:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 17:38:07 -0000
From: Thomas Huth <1042084@bugs.launchpad.net>
Reply-To: Bug 1042084 <1042084@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120827065403.31731.73342.malonedeb@wampee.canonical.com>
Message-Id: <149737548745.9620.3661871445341668754.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1042084] Re: Windows 7 guest cannot boot after
 seabios updated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing, according to comment #5.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1042084

Title:
  Windows 7 guest cannot boot after seabios updated

Status in QEMU:
  Invalid

Bug description:
  Hi,

  I can no longer boot my Windows 7 guest after this commit (update
  seabios to latest master)

  http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D01afdadc92e71e29700e=
64f3a5f42c1c543e3cf9

  When I tried to boot Windows, it BSOD and said "The BIOS in this
  system is not fully ACPI compliant. Please contact your system vendor
  for an updated  BIOS". Reverting this commit will fix the issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1042084/+subscriptions
