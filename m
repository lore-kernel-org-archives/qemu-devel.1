Received: from eggs.gnu.org ([2001:4830:134:3::10]:34393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1flRyn-0002Vx-KM
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 00:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1flRym-0002zz-Ut
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 00:46:21 -0400
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:38473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1flRym-0002zS-O6
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 00:46:20 -0400
Received: by mail-ua0-x22d.google.com with SMTP id o11-v6so3001163uak.5
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 21:46:20 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Fri, 3 Aug 2018 12:46:19 +0800
Message-ID: <CAB3eZfudS9D3G-JSNcaeZO_vWYBQytSbSLzDSLd+abGU9mLeoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Can I create img more thant 16TB?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

There's file size maximum in ext4 and it's 16TB

Can I create qcow2 ex:32TB and write more than 16TB?

thx
