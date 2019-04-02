Received: from eggs.gnu.org ([209.51.188.92]:60864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBKRH-00052x-2b
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBKRF-0001ZN-UV
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:30:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:36710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hBKRF-0001Us-Mh
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:30:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hBKRC-0008D8-1Z
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 14:30:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 44AB22E86BB
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 14:30:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2019 14:24:09 -0000
From: Jayshree Phulare <1822798@bugs.launchpad.net>
Reply-To: Bug 1822798 <1822798@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155421416733.11748.993612847677239700.malonedeb@soybean.canonical.com>
Message-Id: <155421504952.8016.10425764691661147188.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1822798] Re: The hover of " Full list of releases
 " is not effective even not visible.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The hover button color is changed so that is it effectively visible.
line number 307

.button:hover
	{
	=

		background: #8f1b1b;
		text-decoration: none;
	}

** Attachment added: "The hover button color is changed so that is it effec=
tively visible.  line number 307"
   https://bugs.launchpad.net/qemu/+bug/1822798/+attachment/5252071/+files/=
qemu_style.css

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1822798

Title:
  The hover of " Full list of releases " is not effective even not
  visible.

Status in QEMU:
  New

Bug description:
  The hover effect of "Full list of releases " on QEMU website that is
  https://www.qemu.org/ is not visible and hence effective so made it
  the issue on git hub and even committed it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1822798/+subscriptions
