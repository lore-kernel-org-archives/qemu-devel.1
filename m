Received: from eggs.gnu.org ([2001:4830:134:3::10]:60916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e6aju-0000UV-Kc
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e6ajt-0004Lq-HU
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:17:50 -0400
MIME-Version: 1.0
In-Reply-To: <20171023051819.GD17374@lemon>
References: <1508678882-4327-1-git-send-email-sundeep.lkml@gmail.com>
	<150868113318.482.11705826106714639873@b58463cdfd5f>
	<CALHRZuqhSJC9t3Xrc6-yd3EKcaNUp3NyR+i3FW=i4C7Y16acxA@mail.gmail.com>
	<20171023051819.GD17374@lemon>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Mon, 23 Oct 2017 16:47:48 +0530
Message-ID: <CALHRZuqRKq6iooYTUQfi4ju6bFaszTWZmJs7rt0sjjT5MbjtCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel v3 PATCH] msf2: Remove dead code
 reported by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Darren Kenny <darren.kenny@oracle.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>

Hi Fam,

On Mon, Oct 23, 2017 at 10:48 AM, Fam Zheng <famz@redhat.com> wrote:

> On Mon, 10/23 08:59, sundeep subbaraya wrote:
> > > Cloning into '/var/tmp/patchew-tester-tmp-egubaaoc/src/dtc'...
> > > fatal: Could not read from remote repository.
> > >
> > > Please make sure you have the correct access rights
> > > and the repository exists.
> > > fatal: clone of 'git://git.qemu-project.org/dtc.git' into submodule
> path
> > > '/var/tmp/patchew-tester-tmp-egubaaoc/src/dtc' failed
> > > Failed to clone 'dtc' a second time, aborting
> > > === OUTPUT END ===
> > >
> > > Test command exited with code: 1
> > >
> >
> > I did not understand. Is the error related to my patch?
>
> Nope, there is something wrong with the testing bot.
>

Ok.

Thanks,
Sundeep

>
> Fam
>
