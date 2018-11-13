Received: from eggs.gnu.org ([2001:4830:134:3::10]:46526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMi87-0006JD-OK
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMi84-0004C4-Kw
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:29:59 -0500
Date: Wed, 14 Nov 2018 00:29:18 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181113232918.GE23562@caravaggio.hotspot.internet-for-guests.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-2-sameo@linux.intel.com>
	<CAFEAcA-npVS1Q0=or=p-kjP0Nf4h1n+qUL7y8+yYCdtuHa7Fxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-npVS1Q0=or=p-kjP0Nf4h1n+qUL7y8+yYCdtuHa7Fxg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 01/13] target: arm: Add copyright
 boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Nov 13, 2018 at 04:58:40PM +0000, Peter Maydell wrote:
> On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote:
> > From: Philippe Mathieu-Daudé <philmd@redhat.com>
> >
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> > Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>
> > ---
> >  target/arm/helper.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 0da1424f72..3d4e9c5c8a 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -1,3 +1,10 @@
> > +/*
> > + * ARM generic helpers.
> > + *
> > + * This code is licensed under the GNU GPL v2.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> 
> The human readable text says "v2", but the SPDX tag says
> "v2 or later". Which is right? (The top level LICENSE file says
> source files with no specific license are 2-or-later).
Fixed in my
https://github.com/intel/nemu/tree/topic/upstream/arm-tcg-disable
branch, thanks.

Cheers,
Samuel.
