Received: from eggs.gnu.org ([2001:4830:134:3::10]:42286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cJcVS-0001BK-Bz
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cJcVR-00018j-Hi
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:44:14 -0500
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:35433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1cJcVR-00016Q-9r
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:44:13 -0500
Received: by mail-lf0-x235.google.com with SMTP id b14so92998986lfg.2
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 00:44:11 -0800 (PST)
MIME-Version: 1.0
From: Bob Chen <a175818323@gmail.com>
Date: Wed, 21 Dec 2016 16:44:08 +0800
Message-ID: <CAMxP3BREAp7wm8B8=z0d1qAcG18Pv19UpU7RrSikGBunScNNOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] QEMU -smp paramater: Will multiplue threads and cores
 improve performance?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

-smp 16

-smp cores=4,threads=4,sockets=1


Which one has better performance? The scenario is guest VMs running on
cloud server.


-Bob
