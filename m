Received: from eggs.gnu.org ([2001:4830:134:3::10]:38709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cxuqj-0003L7-Vz
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cxuqg-0002oZ-Q4
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:24:45 -0400
Received: from mail-ua0-x232.google.com ([2607:f8b0:400c:c08::232]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cxuqg-0002oN-JR
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:24:42 -0400
Received: by mail-ua0-x232.google.com with SMTP id u103so56885219uau.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 05:24:42 -0700 (PDT)
MIME-Version: 1.0
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 11 Apr 2017 15:24:41 +0300
Message-ID: <CAKPgXcHPZ6MyJ7wM78C+QNb0fL+L5es04KsH5Ok1KW-rHZU1kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Windows 10 IoT Core Raspberry Pi 2 on top of Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Yan Vugenfirer <yan@daynix.com>

Hi all,

I am trying to run Windows 10 IoT Core for Raspberry Pi 2 on top of Qemu
with no luck. I am using this repository https://github.com/0xabu/qemu, and
I am using a newer build of Windows IoT core (1607) as earlier versions
aren't available to download from Microsoft.

The first core is stuck in an infinite loop and the other cores are halted!
Anyone else faced this issue? Is there any version of Windows 10 IoT Core
ARM that can run on top of Qemu?


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
