Received: from eggs.gnu.org ([2001:4830:134:3::10]:46771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fZtUG-00063s-3v
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 03:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fZtUC-0003tV-6k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 03:43:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Jul 2018 09:42:49 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <20180702052202.GY3422@umbus.fritz.box>
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
	<607559ef0fd95f557b5001a5db29883f@sebastianbauer.info>
	<20180630061443.GP3422@umbus.fritz.box>
	<alpine.BSF.2.21.1806301325320.13465@zero.eik.bme.hu>
	<20180702040239.GS3422@umbus.fritz.box>
	<20180702052202.GY3422@umbus.fritz.box>
Message-ID: <2fdb7495b7979040f40a361d78d35d85@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, thuth@redhat.com, qemu-ppc@nongnu.org

Am 2018-07-02 07:22, schrieb David Gibson:
> And now unapplied, since it breaks make check all over the place for
> ppc64-softmmu.
> 
> Please folks, running an all-targets make check is really the
> *minimum* bar for testing before posting a patch for inclusion.

Okay, will do next time. Sorry for the inconvenience.

But I can't find anything about this procedure in the Wiki. Maybe it 
would be a good idea to add this info for people that are new, or if it 
is written somewhere it should be linked from here: 
https://wiki.qemu.org/Contribute/SubmitAPatch as this is most likely the 
starting point for new contributors.

Bye
Sebastian
