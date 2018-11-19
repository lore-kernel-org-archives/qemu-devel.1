Received: from eggs.gnu.org ([2001:4830:134:3::10]:45125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gOohG-00071b-Kx
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gOohB-00056R-Kl
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:54:58 -0500
Received: from dschgrazlin2.univ.trieste.it ([140.105.55.81]:50220
	helo=dschgrazlin2.units.it) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gOohB-00053Z-A7
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:54:53 -0500
From: balducci@units.it
In-reply-to: Your message of "Mon, 19 Nov 2018 18:35:05 +0000."
	<20181119183343.GD2365@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13232.1542653690.1@dschgrazlin2.units.it>
Date: Mon, 19 Nov 2018 19:54:26 +0100
Message-ID: <13233.1542653690@dschgrazlin2.units.it>
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

> A colleague has confirmed this on his FX-8320 on Fedora 29 with the
> virt-next repo;  so it's nothing that's special about your machine;
> it's 3.1 that really doesn't like the old AMDs.

ouch! does this mean that I must stop upgrading qemu or do you think
that some development work will be directed towards this "back
compatibility" issue?

(apologies for being totally unable to help with patches/code...I know
zero about all the qemu business)

thanks a lot
ciao
-gabriele
