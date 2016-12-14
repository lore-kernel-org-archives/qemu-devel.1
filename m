Received: from eggs.gnu.org ([2001:4830:134:3::10]:36369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHBby-00039P-MM
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHBbu-00044K-Pp
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:36:54 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHBbu-0003vy-Bv
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:36:50 -0500
Received: by mail-vk0-f48.google.com with SMTP id x186so33046747vkd.1
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 07:36:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161208104539.3045-1-fziglio@redhat.com>
References: <20161208104539.3045-1-fziglio@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Dec 2016 15:28:48 +0000
Message-ID: <CAFEAcA_qOFap4j82iXOHf9xHoJsbB83Pi08PLs+mj8UZPRH8jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] egl-helpers: Change file licensing to
 LGPLv2
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

On 8 December 2016 at 10:45, Frediano Ziglio <fziglio@redhat.com> wrote:
> The relicense permits sharing the code with Spice which
> is LGPL.
>
> All people listed below have agreed to the
> relicense:
> - Arei Gonglei;
> - Cole Robinson;
> - Gerd Hoffmann;
> - Peter Maydell.
>
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> Acked-by: Cole Robinson <crobinso@redhat.com>

Acked-by: Peter Maydell <peter.maydell@linaro.org>

(Linaro's only change to this file was to add the #include "qemu/osdep.h"
line, which was done by running an automated script.)

thanks
-- PMM
