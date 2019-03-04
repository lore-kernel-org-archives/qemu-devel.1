Received: from eggs.gnu.org ([209.51.188.92]:37646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0rhS-0000xe-6W
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0rhR-00014G-AT
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:48:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0rhR-000132-14
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:48:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id w17so6521131wrn.12
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 09:48:24 -0800 (PST)
References: <20190304151827.1813-1-davidkiarie4@gmail.com>
	<20190304151827.1813-2-davidkiarie4@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <50ec8aca-252e-792f-9a9a-a5dc606eca9c@redhat.com>
Date: Mon, 4 Mar 2019 18:48:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190304151827.1813-2-davidkiarie4@gmail.com>
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
To: David Kiarie <davidkiarie4@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, jan.kiszka@siemens.com, peterx@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On 3/4/19 4:18 PM, David Kiarie wrote:
> Signed-off-by: David Kiarie <davidkiarie4@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/i386/amd_iommu.c | 2 +-
>  hw/i386/amd_iommu.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 8ad707a..6eabdf9 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -2,7 +2,7 @@
>   * QEMU emulation of AMD IOMMU (AMD-Vi)
>   *
>   * Copyright (C) 2011 Eduard - Gabriel Munteanu
> - * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
> + * Copyright (C) 2015, 2016 David Kiarie Kahurani
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index c52886f..0ff9095 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -2,7 +2,7 @@
>   * QEMU emulation of an AMD IOMMU (AMD-Vi)
>   *
>   * Copyright (C) 2011 Eduard - Gabriel Munteanu
> - * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
> + * Copyright (C) 2015, 2016 David Kiarie Kahurani
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> 
