Received: from eggs.gnu.org ([209.51.188.92]:36745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ijc@hellion.org.uk>) id 1hEqtx-00069J-C1
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ijc@hellion.org.uk>) id 1hEqtv-0005vm-9V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:47:08 -0400
Message-ID: <c6a72245aba41195916bf45c515486491167099e.camel@hellion.org.uk>
From: Ian Campbell <ijc@hellion.org.uk>
Date: Fri, 12 Apr 2019 08:46:52 +0100
In-Reply-To: <CAKmqyKO779w8sYXcwtnJyCZN0TuKOAjUjd_xca4k2wff4vfEHQ@mail.gmail.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<9043c3a6bc54faa98ed9fedc0c6c929c993a0bf9.1554937288.git.alistair.francis@wdc.com>
	<20190411140629.3a672b39@redhat.com>
	<CAFEAcA-oOfZD=tas4QP3SeSOJJ+eM_9o=v05U=scsc78Z4p3FQ@mail.gmail.com>
	<CAKmqyKO779w8sYXcwtnJyCZN0TuKOAjUjd_xca4k2wff4vfEHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3 6/6] riscv: Add a generic spike
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>, "palmer@sifive.com" <palmer@sifive.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, 2019-04-11 at 13:35 -0700, Alistair Francis wrote:
> > > > +    if (!qtest_enabled()) {
> > > > +        info_report("The Spike v1.09.1 machine has been
> > > > depreceated. "
> > > > +                    "Please use the deneric spike machine and
> > > > specify the ISA "
> > 
> > "generic"

Also "deprecated" not "depreceated".

Ian.
