Received: from eggs.gnu.org ([209.51.188.92]:47150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0tmZ-0004ia-H1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0tmY-0005nW-Iz
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:01:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0tmY-0005ms-Ay
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:01:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so368972wmg.4
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 12:01:50 -0800 (PST)
References: <20190304151827.1813-1-davidkiarie4@gmail.com>
	<20190304151827.1813-2-davidkiarie4@gmail.com>
	<50ec8aca-252e-792f-9a9a-a5dc606eca9c@redhat.com>
	<CABdVeAAZXbC-5tPJd1ziAeKBVo+Bqt8We-hHDv_6bRd99YXmrg@mail.gmail.com>
	<CABdVeADyxZ9Fpr0=ZqDJhH3hnBJ8F3RpoBuqk7ywKwT6WF4BGQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5659a8f6-d9d1-53b7-5be4-7460590c65d9@redhat.com>
Date: Mon, 4 Mar 2019 21:01:47 +0100
MIME-Version: 1.0
In-Reply-To: <CABdVeADyxZ9Fpr0=ZqDJhH3hnBJ8F3RpoBuqk7ywKwT6WF4BGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/1] update copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Kiarie <davidkiarie4@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi David,

On 3/4/19 8:29 PM, David Kiarie wrote:
> 
> 
> On Mon, Mar 4, 2019 at 10:20 PM David Kiarie <davidkiarie4@gmail.com
> <mailto:davidkiarie4@gmail.com>> wrote:
> 
> 
> 
>     On Mon, Mar 4, 2019 at 8:48 PM Philippe Mathieu-Daudé
>     <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> 
>         On 3/4/19 4:18 PM, David Kiarie wrote:
>         > Signed-off-by: David Kiarie <davidkiarie4@gmail.com
>         <mailto:davidkiarie4@gmail.com>>
> 
>         Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
>         <mailto:philmd@redhat.com>>
> 
> 
>     would i be wrong to say this patch received unwarranted scrutiny
>     from you, Philippe?
> 
> 
> i mean, given you have never been involved in any IOMMU work, i wouldn't
> expect that you're in a position to asking questions about the copyright.

IANAL and I have no knowledge of IOMMU indeed.
I noticed first this patch is sent from the same email used in this
copyright notice, then the patch content merged in commit d29a09ca684
was accepted in 2016 with a copyright date of 2015, hence your copyright
modification looks correct to me.

Regards,

Philippe.

>  
> 
> 
> 
>         > ---
>         >  hw/i386/amd_iommu.c | 2 +-
>         >  hw/i386/amd_iommu.h | 2 +-
>         >  2 files changed, 2 insertions(+), 2 deletions(-)
>         >
>         > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>         > index 8ad707a..6eabdf9 100644
>         > --- a/hw/i386/amd_iommu.c
>         > +++ b/hw/i386/amd_iommu.c
>         > @@ -2,7 +2,7 @@
>         >   * QEMU emulation of AMD IOMMU (AMD-Vi)
>         >   *
>         >   * Copyright (C) 2011 Eduard - Gabriel Munteanu
>         > - * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com
>         <mailto:davidkiarie4@gmail.com>>
>         > + * Copyright (C) 2015, 2016 David Kiarie Kahurani
>         >   *
>         >   * This program is free software; you can redistribute it
>         and/or modify
>         >   * it under the terms of the GNU General Public License as
>         published by
>         > diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>         > index c52886f..0ff9095 100644
>         > --- a/hw/i386/amd_iommu.h
>         > +++ b/hw/i386/amd_iommu.h
>         > @@ -2,7 +2,7 @@
>         >   * QEMU emulation of an AMD IOMMU (AMD-Vi)
>         >   *
>         >   * Copyright (C) 2011 Eduard - Gabriel Munteanu
>         > - * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com
>         <mailto:davidkiarie4@gmail.com>>
>         > + * Copyright (C) 2015, 2016 David Kiarie Kahurani
>         >   *
>         >   * This program is free software; you can redistribute it
>         and/or modify
>         >   * it under the terms of the GNU General Public License as
>         published by
>         >
> 
