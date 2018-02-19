Received: from eggs.gnu.org ([2001:4830:134:3::10]:52568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ennEp-00038m-8A
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ennEo-0008Uc-Ce
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:20:19 -0500
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 19 Feb 2018 09:20:04 -0600
Message-Id: <1519053606-9817-1-git-send-email-minyard@acm.org>
In-Reply-To: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
References: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] Move the bus class to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

This is a couple of changes I have because I have a bus mux emulator
and a multi-master bus mux emulator.  Others need this change, too,
so get it out there.

-corey
