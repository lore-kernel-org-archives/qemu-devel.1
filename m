Received: from eggs.gnu.org ([2001:4830:134:3::10]:39466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dwGUm-0003o1-Pr
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 19:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dwGUl-0003bd-El
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 19:39:32 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0CHhQwA-zjsEseA8D==iz401G6CrwGoN33Nwp7GV+ew@mail.gmail.com>
References: <20170920201737.25723-1-f4bug@amsat.org>
	<CAFEAcA_0CHhQwA-zjsEseA8D==iz401G6CrwGoN33Nwp7GV+ew@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Mon, 25 Sep 2017 05:09:28 +0530
Message-ID: <CALHRZupWabascx0jJ0wJyotcaK0_KHthEvu80kpzcPFSOK_iiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 0/5] Add support for Smartfusion2 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

Thanks Peter, Philippe and Alistair :)
Sundeep

On Thu, Sep 21, 2017 at 10:03 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 20 September 2017 at 21:17, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
> wrote:
> > Hi Peter,
> >
> > Now than Igor's patch landed, I respin Sundeep's series updating it to
> work
> > after the "arm: drop intermediate cpu_model -> cpu type parsing and use
> cpu
> > type directly" patch.
> >
> > v11:
> > - msf2-soc.c: add a check for null m3clk
> > - msf2-soc.c, msf2-som.c: drop cpu_model to directly use cpu type
> >
> > --
>
> Applied to target-arm.next.
>
> Thanks to Sundeep for being so patient with our code review process,
> and to Philippe and Alistair for doing the review and shepherding
> the series through it.
>
> thank
> -- PMM
>
