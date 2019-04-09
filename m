Received: from eggs.gnu.org ([209.51.188.92]:42238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDuDS-0001gP-Bh
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDuDQ-0006Z1-O1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:07:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hDuDP-0006VO-D1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:07:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id p10so21914325wrq.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 10:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
	<fbe81e69-01f1-4755-49a8-e25df108a196@redhat.com>
In-Reply-To: <fbe81e69-01f1-4755-49a8-e25df108a196@redhat.com>
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Tue, 9 Apr 2019 22:37:05 +0530
Message-ID: <CAH95U0j5Ph_OZS+ZY2juM6UxvESGO=dv+cYV6uLiNAOpHVS7mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Header cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Thanks!

On Tue, Apr 9, 2019 at 10:36 PM, Thomas Huth <thuth@redhat.com> wrote:

> On 09/04/2019 17.56, Aruna Jayasena wrote:
> > Removed unwanted includes from cpu-common.h
> > This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
> >
> > Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> >
> > ---
> >  include/exec/cpu-common.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> > index cef8b88a2a..a3594f3f50 100644
> > --- a/include/exec/cpu-common.h
> > +++ b/include/exec/cpu-common.h
> > @@ -7,8 +7,6 @@
> >  #include "exec/hwaddr.h"
> >  #endif
> >
> > -#include "qemu/bswap.h"
> > -#include "qemu/queue.h"
> >  #include "qemu/fprintf-fn.h"
> >
> >  /**
> >
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
--=20
*Aruna* Jayasena
Embedded Systems and Computer Science Engineering Undergraduate
University of Moratuwa
*=E2=9C=86 **+94719872152 *
=E2=9C=89 <aruna.15@cse.mrt.ac.lk> =E2=8C=A8 <http://archfx.github.io> in
<https://www.linkedin.com/in/arunajayasena/>
