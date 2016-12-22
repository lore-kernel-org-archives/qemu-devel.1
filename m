Received: from eggs.gnu.org ([2001:4830:134:3::10]:50332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gteodori@gmail.com>) id 1cK24H-0000qx-FF
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gteodori@gmail.com>) id 1cK24G-0003EN-Qt
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:01:53 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:34840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gteodori@gmail.com>) id 1cK24G-0003EF-MW
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:01:52 -0500
Received: by mail-oi0-x22d.google.com with SMTP id b126so239707041oia.2
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 04:01:52 -0800 (PST)
MIME-Version: 1.0
From: giancarlo teodori <gteodori@gmail.com>
Date: Thu, 22 Dec 2016 13:01:11 +0100
Message-ID: <CAP086mP+iK_CwJ0oq1-gPEDCx88BA9PoncROXsoBYD5xEoGSkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] QEMU for RISC6000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, I'm working to emulate aix SO on RISC6000 environment using qemu
emulator.
I tried to import related patch ([RFC,2/6] prep: add IBM RS/6000 7248 (43p)
machine emulation), but this operation give me an error.
I'm using a wrong release of qemu code?

Do you know a version of qemu already integrated for emulate risc6000?
Otherwise, at which version of qemu I can apply the patch above?

Many thanks and best regards

Giancarlo
