Received: from eggs.gnu.org ([2001:4830:134:3::10]:42524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dfmCZ-0001W6-RY
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dfmCY-00047b-Uw
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:04:35 -0400
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Thu, 10 Aug 2017 20:04:32 +0800
Message-ID: <CAOE=1Z0s6Z8c_Nd4_ZO+6E3PfK7mODRFVL5LbFr3cPvXcHmLDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How to detect qga socket available?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

Hi all,

I want to send command through qga socket, but sometimes it will hanged
there. So I want to test qga socket available first, then send qga command.

So my question is how to test qga socket available, which is not taken by
others? By timeout?

Thank you~
