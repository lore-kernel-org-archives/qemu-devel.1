Received: from eggs.gnu.org ([2001:4830:134:3::10]:48023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cecGU-0000i9-PE
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 01:43:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cecGR-0002pb-Nr
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 01:43:34 -0500
Date: Fri, 17 Feb 2017 14:43:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170217064327.GB21716@lemon.lan>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chad Joan <chadjoan@gmail.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Thu, 02/16 12:47, Chad Joan wrote:
> I am glad others are chiming in and might provide better solutions.
> 
> Honestly, following the instructions at
> http://wiki.qemu-project.org/Contribute/SubmitAPatch to-the-letter is quite
> daunting to me, just to get one line of code changed.  It might help if
> that page had some kind of dead-simple example for trivial patches;
> something like:
> $ cd <QEMU directory>
> $ git format-patch blah blah blah
> $ maybe-some-other-command
> $ # Now copy the contents of file xyz.patch into your email client and send
> to qemu-devel@nongnu.org and qemu-trivial@nongnu.org

Makes sense in general except for the sending part - email clients tend to
damage the patch when you copy and paste by wrapping long lines or messing up
other things. But your point is taken, we should make the first (or a one-shot)
contribution as easy as possible.

Fam
