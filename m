Received: from eggs.gnu.org ([2001:4830:134:3::10]:51187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ffMTT-0004Rp-1b
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ffMTP-0007pX-V0
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:40:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:57230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ffMTP-0007or-Nl
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:40:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ffMTO-00035d-1x
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 09:40:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 09C942E80C7
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 09:40:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jul 2018 09:29:49 -0000
From: Nadav Ruskin <1782107@bugs.launchpad.net>
Reply-To: Bug 1782107 <1782107@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153181978967.32137.15387354948382398538.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1782107] [NEW] Random errors when emulating armv7
 and using dh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Howdy,
I'm encountering random errors when using qemu to cross-package my project =
using dh. In previous iterations of my project it would only fail once ever=
y two attempts. Now it fails every time.

Example error included.


If you'd like to try and replicate this error, a version of my project is p=
ublicly available with simple instructions on how to package it (using qemu=
) here:
https://github.com/Nadav-Ruskin/configsite

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: dh error

** Attachment added: "myerror.txt"
   https://bugs.launchpad.net/bugs/1782107/+attachment/5164433/+files/myerr=
or.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1782107

Title:
  Random errors when emulating armv7 and using dh

Status in QEMU:
  New

Bug description:
  Howdy,
  I'm encountering random errors when using qemu to cross-package my projec=
t using dh. In previous iterations of my project it would only fail once ev=
ery two attempts. Now it fails every time.

  Example error included.


  If you'd like to try and replicate this error, a version of my project is=
 publicly available with simple instructions on how to package it (using qe=
mu) here:
  https://github.com/Nadav-Ruskin/configsite

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1782107/+subscriptions
