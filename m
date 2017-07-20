Received: from eggs.gnu.org ([2001:4830:134:3::10]:46591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dY9I4-0005Pi-6z
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dY9I3-0007Eq-5M
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:06:44 -0400
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:36259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1dY9I2-0007Eb-T3
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:06:43 -0400
Received: by mail-ua0-x22a.google.com with SMTP id 35so20275417uax.3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 04:06:42 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Date: Thu, 20 Jul 2017 19:06:41 +0800
Message-ID: <CAB3eZfs8E0xsBAFH_4U=M4LsVpRs73aPdFk5qy_ZUKqMom9P8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] unrecognized option --object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I build qemu from the https://github.com/qemu/qemu, and it didn't show any
errors.

I tried qemu-nbd --object secret,id=sec0...
but it shows unrecognized option '--object '

how to solve it?
