Received: from eggs.gnu.org ([2001:4830:134:3::10]:49027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1euMk4-0001mq-Ut
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:27:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1euMk0-0003Y0-V5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:27:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1euMk0-0003Wc-Np
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:27:40 -0500
Date: Fri, 9 Mar 2018 18:27:32 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180309182732.GB2787@redhat.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<20180305084111.GM2450@redhat.com>
	<CAFEAcA8=fizLvBxVCby4jsGGK8RyXQs0FmeXxA=ZWXT+er-4ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8=fizLvBxVCby4jsGGK8RyXQs0FmeXxA=ZWXT+er-4ag@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Fri, Mar 09, 2018 at 04:43:34PM +0000, Peter Maydell wrote:
> On 5 March 2018 at 08:41, Richard W.M. Jones <rjones@redhat.com> wrote:
> >
> > The attached patch is also needed to avoid crashes during various
> > math-heavy test suites.
> 
> Applied to master, thanks.
> 
> FYI, sending patches as attachments in the middle of a long
> thread on something else is a good way to cause them to get
> lost. Luckily Michael ran into the same bug again and that
> reminded me to fish this one out.

Yup sorry I thought that the patch had been separately submitted,
but apparently it never was.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
