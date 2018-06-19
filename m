Received: from eggs.gnu.org ([2001:4830:134:3::10]:52731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fVMSY-0001ig-N5
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fVMSV-0002u0-I4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:38:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Jun 2018 21:38:24 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <20180619043631.GC11674@umbus.fritz.box>
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
Message-ID: <c6eb77d6f062728d33331b1cbbc48d92@sebastianbauer.info>
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
Cc: qemu-devel@nongnu.org, thuth@redhat.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org

Hello David,

Am 2018-06-19 06:36, schrieb David Gibson:
> Ok.  However, your patch doesn't apply against the ppc-for-3.0 tree.
> It looks like you've made it against a tree including some of BALATON
> Zoltan's proposed but not yet merged patches.
> 
> Please make sure your patches are against the current ppc-for-3.0 tree
> before posting.

Okay, I'm sorry for the wrong timing. It is okay to wait for Zoltan's 
patch queue to be applied before applying this patch as I don't want to 
introduce new conflicts in those patches.

Bye
Sebastian
