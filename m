Received: from eggs.gnu.org ([2001:4830:134:3::10]:39223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eriFs-00044v-TK
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eriFp-0003co-Og
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:49:36 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:33448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1eriFp-0003cG-Hd
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:49:33 -0500
References: <20180301155619.8640-1-david.brenken@efs-auto.org>
	<20180301155619.8640-3-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <77873453-cc68-2ded-d7c7-6ef73aff615e@mail.uni-paderborn.de>
Date: Fri, 2 Mar 2018 11:49:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180301155619.8640-3-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] tricore: added CORE_ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Brenken <david.brenken@efs-auto.org>, qemu-devel@nongnu.org
Cc: Florian Artmeier <florian.artmeier@efs-auto.de>, David Brenken <david.brenken@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

On 03/01/2018 04:56 PM, David Brenken wrote:
> From: David Brenken <david.brenken@efs-auto.de>
> 
> Signed-off-by: David Brenken <david.brenken@efs-auto.de>
> Signed-off-by: Florian Artmeier <florian.artmeier@efs-auto.de>
> Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
> ---
>  target/tricore/cpu.h    | 1 +
>  target/tricore/csfr.def | 1 +
>  2 files changed, 2 insertions(+)
> 

I gave you a Reviewed-by for this patch. If you get one of those please
add it to the next patchset's commit message.

Cheers,
Bastian
