Received: from eggs.gnu.org ([2001:4830:134:3::10]:35721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eieCr-0006V7-6o
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eieCo-0001bn-4D
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:41:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:44676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eieCn-0001a7-T8
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:40:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eieCm-0008LF-N4
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 10:40:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ACCF52E80C8
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 10:40:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Feb 2018 10:27:09 -0000
From: Toomas Soome <tsoome@me.com>
Reply-To: Bug 1747393 <1747393@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151782642980.10198.17726074601611845094.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1747393] [NEW] nvme is missing support for
 NVME_ADM_CMD_ASYNC_EV_REQ
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

NVME_ADM_CMD_ASYNC_EV_REQ is required by specification but apparently we
will be responded by error when this command is used.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1747393

Title:
  nvme is missing support for NVME_ADM_CMD_ASYNC_EV_REQ

Status in QEMU:
  New

Bug description:
  NVME_ADM_CMD_ASYNC_EV_REQ is required by specification but apparently
  we will be responded by error when this command is used.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1747393/+subscriptions
