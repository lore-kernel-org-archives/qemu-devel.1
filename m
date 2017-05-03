Received: from eggs.gnu.org ([2001:4830:134:3::10]:37462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1d5v9J-0003Fo-UA
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1d5v9G-0004Y0-NZ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:21:01 -0400
Received: from nm5-vm4.bullet.mail.ir2.yahoo.com ([212.82.96.111]:58126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1d5v9G-0004W7-DI
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:20:58 -0400
Date: Wed, 3 May 2017 14:20:55 +0000 (UTC)
From: John Bradley <flypie@rocketmail.com>
Reply-To: John Bradley <flypie1@yahoo.com>
Message-ID: <1618105799.2706822.1493821255206@mail.yahoo.com>
MIME-Version: 1.0
References: <1618105799.2706822.1493821255206.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Dummy Panel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi
I have created a new fork on GitHub https://github.com/flypie/flypie-pi-qemu and an associated project https://github.com/flypie/GDummyPanel the idea as well as getting the Original PI emulation working is to add some facility for simulated IO. This is a demonstration of the latest version, running the QEMU demo from https://github.com/rsta2/circle. I took the idea from an implementation for the BIFFboard but only the socket number is left, the commuications is all via IP. The code is only really Alpha level at the moment and needs some refing to reduce bandwidth. I could also extend the code so that the connection can be to a remote machine rather than via the local host.

I intend to generalise the code, to work with several different boards other than the PI, could anyone suggest a board that would benefit from such an add on.
Is this a worth while addon? 
John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge Hill Liverpool L7 7AF
