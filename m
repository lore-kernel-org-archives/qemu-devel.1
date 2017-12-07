Received: from eggs.gnu.org ([2001:4830:134:3::10]:44904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3kT-0005Yd-7k
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3kS-0001xA-3e
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:29 -0500
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:43176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3kR-0001wX-Uj
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:28 -0500
Received: by mail-pg0-x234.google.com with SMTP id b18so5356514pgv.10
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:30:27 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
	by smtp.gmail.com with ESMTPSA id
	l21sm10912775pfg.156.2017.12.07.13.30.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Dec 2017 13:30:23 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
	by serve.minyard.net (Postfix) with ESMTPA id 8A37C901
	for <qemu-devel@nongnu.org>; Thu,  7 Dec 2017 15:30:20 -0600 (CST)
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:30:05 -0600
Message-Id: <1512682213-4354-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 0/8] Small IPMI (and other) fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These are some fixes I've had for a while (mostly).  They are small
fixes and additions for various things.  It would be nice to be able
to get at least some of these into the upcoming release, but it's
probably too late.

I also add myself as the maintainer for the IPMI code, since that
seemed appropriate.
