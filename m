Received: from eggs.gnu.org ([2001:4830:134:3::10]:37440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fU9t5-0004wf-Qk
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 08:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fU9t0-0006r6-Ct
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 08:00:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:48732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fU9t0-0006qZ-6o
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 08:00:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fU9sz-0000C5-2G
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 12:00:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 026A62E802E
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 12:00:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Jun 2018 11:50:59 -0000
From: Shimi Gersner <gersner@gmail.com>
Reply-To: Bug 1777235 <1777235@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152914985958.7724.174010690226549747.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777235] [NEW] NVME is missing support for Get
 Log Page command
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

"Get Log Page" is a mandatory admin command by the specification (NVMe
1.2, Section 5, Figure 40) currently not implemented by device.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777235

Title:
  NVME is missing support for Get Log Page command

Status in QEMU:
  New

Bug description:
  "Get Log Page" is a mandatory admin command by the specification (NVMe
  1.2, Section 5, Figure 40) currently not implemented by device.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777235/+subscriptions
