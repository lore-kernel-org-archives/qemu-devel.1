Received: from eggs.gnu.org ([2001:4830:134:3::10]:44122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prem.mallappa@gmail.com>) id 1dyD8d-00074B-IA
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 04:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prem.mallappa@gmail.com>) id 1dyD8c-0003rI-HM
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 04:28:43 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8k4nAjqJ_Mu5ZZ8ygMMJikX17BCB3M0ZkbQBsKVLt5TQ@mail.gmail.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-2-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8k4nAjqJ_Mu5ZZ8ygMMJikX17BCB3M0ZkbQBsKVLt5TQ@mail.gmail.com>
From: Prem Mallappa <prem.mallappa@gmail.com>
Date: Sat, 30 Sep 2017 13:58:17 +0530
Message-ID: <CADD6c-iohAZO7DLsYfh+sRz0SWyxWW0ja_tdFhdemgWJafHJjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 01/20] hw/arm/smmu-common: smmu base
 device and datatypes
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com
List-ID: <qemu-devel.nongnu.org>

All,

I am no longer associated with Broadcom, so can't help much here I guess.

If there is anything else I can do; please let me know.

Cheers,
/Prem



--
Prem

On Wed, Sep 27, 2017 at 11:08 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 1 September 2017 at 10:21, Eric Auger <eric.auger@redhat.com> wrote:
> > The patch introduces the smmu base device and class for the ARM
> > smmu. Devices for specific versions will be derived from this
> > base device.
> >
> > We also introduce some important datatypes.
> >
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
>
> > +/*
> > + * Copyright (C) 2014-2016 Broadcom Corporation
> > + * Copyright (c) 2017 Red Hat, Inc.
> > + * Written by Prem Mallappa, Eric Auger
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
>
> Really GPL-2-only ?
>
> Unless there's a good reason, you should probably fix this (including
> getting an ack from Prem/Broadcom where it applies to code that came
> from him).
>
> thanks
> -- PMM
>
