Received: from eggs.gnu.org ([2001:4830:134:3::10]:48963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anand.indukala@gmail.com>) id 1d3Qdo-0007XK-Uo
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anand.indukala@gmail.com>) id 1d3Qdo-0004mQ-22
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:22:12 -0400
MIME-Version: 1.0
From: Anand J <anand.indukala@gmail.com>
Date: Wed, 26 Apr 2017 22:52:07 +0530
Message-ID: <CANDALvka-DzZeLGDRjv6jeqeUrxA0DsJU9JG_1FeHPOh28K0DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] SVM processor state flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-discuss@nongnu.org
Cc: qemu-devel@nongnu.org

Hi All,

Is there any register flag in SVM enabled processors to figure out the
running mode of that processor in order to differentiate between hypervisor
execution and guest OS execution?

Also can context switch happen while a processor executes KVM code? If yes,
how is the state of the hypervisor saved including the hidden states?

Thanks,
Anand
