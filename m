Received: from eggs.gnu.org ([2001:4830:134:3::10]:60184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEdUq-0005TP-3y
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEdUn-00016o-2R
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:47:00 -0500
Received: from mail-ua0-f176.google.com ([209.85.217.176]:36535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEdUm-00016Y-MY
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:46:56 -0500
Received: by mail-ua0-f176.google.com with SMTP id b35so416409628uaa.3
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 06:46:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161207125130.5184-1-fziglio@redhat.com>
References: <20161207125130.5184-1-fziglio@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Dec 2016 14:45:35 +0000
Message-ID: <CAFEAcA-p1Ly=XQh4NqiHSt8YOvZn1OA_C638uPZd1ry+S8yb7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] egl-helpers: Change file licensing to LGPL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: Cole Robinson <crobinso@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 7 December 2016 at 12:51, Frediano Ziglio <fziglio@redhat.com> wrote:
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> ---
>  ui/egl-helpers.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 79cee05..cd24568 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -1,3 +1,19 @@
> +/*
> + * Copyright (C) 2015-2016 Gerd Hoffmann <kraxel@redhat.com>

This looks a bit odd. Is the code copyright Gerd as an
individual, or Red Hat as a company?

thanks
-- PMM
