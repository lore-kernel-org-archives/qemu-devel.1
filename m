Received: from eggs.gnu.org ([2001:4830:134:3::10]:40870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBeUO-0005Zs-At
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBeUN-0002yn-JV
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:51:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:33008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBeUN-0002yH-D3
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:50:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBeUL-0004RR-4C
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:50:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D1C202E81AE
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:50:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Apr 2018 10:38:46 -0000
From: Thomas Huth <1714538@bugs.launchpad.net>
Reply-To: Bug 1714538 <1714538@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150427875291.17031.5249448331290490011.malonedeb@gac.canonical.com>
Message-Id: <152473912775.22103.2877589612035331792.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1714538] Re: Support for Raspberry Pi 3 Model B
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1714538

Title:
  Support for Raspberry Pi 3 Model B

Status in QEMU:
  Fix Released

Bug description:
  The raspberry pi 3 B uses a 64-bit instruction set. It would be useful
  if qemu could emulate the boardn

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1714538/+subscriptions
