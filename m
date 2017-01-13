Received: from eggs.gnu.org ([2001:4830:134:3::10]:40205)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cRzLd-00008Z-Vk
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cRzLa-0002gd-Us
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:44:42 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:41484 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cRzLa-0002fD-KY
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:44:38 -0500
Message-ID: <5878AF90.8020709@kamp.de>
Date: Fri, 13 Jan 2017 11:44:32 +0100
From: Peter Lieven <pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Data corruption in Qemu 2.7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: qemu-stable@nongnu.org

Hi,

i currently facing a problem in our testing environment where I see file system corruption with 2.7.1 on iSCSI and Local Storage (LVM).
Trying to bisect, but has anyone observed this before?

Thanks,
Peter
