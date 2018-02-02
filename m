Received: from eggs.gnu.org ([2001:4830:134:3::10]:36188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fdtsaid@gmail.com>) id 1ehcX7-00072Y-Q5
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fdtsaid@gmail.com>) id 1ehcX7-0000zA-55
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:41:41 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:37429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fdtsaid@gmail.com>) id 1ehcX6-0000yi-WC
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:41:41 -0500
Received: by mail-oi0-x22a.google.com with SMTP id t78so16183969oih.4
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 06:41:40 -0800 (PST)
MIME-Version: 1.0
From: Fangda Cai <fdtsaid@gmail.com>
Date: Fri, 2 Feb 2018 16:26:33 +0800
Message-ID: <CAE+d=qYwHiguvVD4+akOvQ2NYx=OQgSUGv14S6tFsb6bFfCBsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How to make memory mapped controller receive data?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, I have built a virtual arm board that includes onboard memory-mapped
SPI controller and CAN controller. I also built a bare metal program that
can run on the virtual arm board. Is it possible to make the SPI/CAN
receive data during the bare-metal program running on the board? I don't
know how to achieve it, any ideas?
