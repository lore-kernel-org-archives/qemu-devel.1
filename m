Received: from eggs.gnu.org ([2001:4830:134:3::10]:41818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djBUD-0000DX-BH
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 17:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djBUA-0007Ds-9t
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 17:40:53 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:36258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1djBUA-00076Q-4S
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 17:40:50 -0400
Received: by mail-pf0-x22f.google.com with SMTP id c28so14681365pfe.3
	for <qemu-devel@nongnu.org>; Sat, 19 Aug 2017 14:40:48 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Sat, 19 Aug 2017 16:40:37 -0500
Message-Id: <1503178840-21512-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 0/3] ipmi: Fix some minor issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

I ran into these testing some stuff in the IPMI driver.  Nothing big,
but they need to be fixed.

-corey
