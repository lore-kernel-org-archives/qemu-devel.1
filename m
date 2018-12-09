Received: from eggs.gnu.org ([2001:4830:134:3::10]:45960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gW1Uy-0003xl-CS
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 11:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gW1Ut-0007gp-DG
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 11:00:04 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:25691)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gW1Ut-0007d9-5p
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 10:59:59 -0500
Date: Sun, 9 Dec 2018 16:59:35 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1812091654210.8180@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] qdev documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Hello,

I was searching for some good summary on how to implement new devices and 
machines in QEMU for those who might want to start working on it but not 
much seems to be available. I've found this which seems to be useful:

https://lists.nongnu.org/archive/html/qemu-devel/2011-07/msg00842.html

What happened to this? Was it ever finished? It does not seem to be in 
docs, only qdev-device-use.txt is there. (Maybe this qdev-for-programmers 
doc could be in docs/devel.)

Thank you,
BALATON Zoltan
