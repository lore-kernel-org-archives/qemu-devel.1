Received: from eggs.gnu.org ([2001:4830:134:3::10]:49437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fkRCl-0001WK-Uu
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fkRCl-0003YY-8H
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:44:35 -0400
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:46250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1fkRCl-0003Xv-27
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:44:35 -0400
Received: by mail-ua0-x22e.google.com with SMTP id u11-v6so5122816uan.13
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 02:44:34 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Tue, 31 Jul 2018 17:44:33 +0800
Message-ID: <CAB3eZfuTdzecv2ParQmbiO6sjrUJ7tpV0HEo_2=2cYC890mOCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Any tutorial to read/write in qcow2 format by
 programming way?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

As titled

I learn some info about qcow2 and tried to write some data and make it
qualified for qcow2 format.

I do it and mount through qemu-nbd successfully.

But I don't know how taking snapshot and backing file works in programming
way.

Can someone tell me some tutorial to know or code snippets to learn?

thx
