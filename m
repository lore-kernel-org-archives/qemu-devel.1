Received: from eggs.gnu.org ([2001:4830:134:3::10]:59403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1cEdRo-0004Li-Ey
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1cEdRj-0000QL-QB
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:43:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1cEdRj-0000QA-Ks
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:43:47 -0500
References: <20161207125130.5184-1-fziglio@redhat.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <aaa44380-14f1-1b4f-2b88-68f85566b2db@redhat.com>
Date: Wed, 7 Dec 2016 09:43:44 -0500
MIME-Version: 1.0
In-Reply-To: <20161207125130.5184-1-fziglio@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] egl-helpers: Change file licensing to LGPL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 12/07/2016 07:51 AM, Frediano Ziglio wrote:
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
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
>  #include "qemu/osdep.h"
>  #include <glob.h>
>  #include <dirent.h>
> 

ACK, I'm fine with relicensing my changes

- Cole
