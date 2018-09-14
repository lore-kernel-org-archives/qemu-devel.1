Received: from eggs.gnu.org ([2001:4830:134:3::10]:54882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0fdT-0007PU-Uk
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 00:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0fdT-0004B5-6x
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 00:23:15 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29]:46102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1g0fdS-00048a-Sg
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 00:23:15 -0400
Received: by mail-vs1-xe29.google.com with SMTP id h23-v6so71456vsk.13
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 21:23:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180912074402.GB11164@lemon.usersys.redhat.com>
References: <CAB3eZfvRJRR1k0X1MQivPMcLRNZR07yv1ZxBiDAkF3qOryK0UQ@mail.gmail.com>
	<20180912074402.GB11164@lemon.usersys.redhat.com>
From: lampahome <pahome.chen@mirlab.org>
Date: Fri, 14 Sep 2018 12:23:13 +0800
Message-ID: <CAB3eZfsGcWP2WdZXocQ6wdztBbRofgXOVi+N=W3FEPxH0N1hyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Can I convert backing file to internal snapshot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Can I convert from internap snapshot to external snapshot?
If there's 3 snapshots in one qcow2, can I convert them all to external
snapshots?
