Received: from eggs.gnu.org ([2001:4830:134:3::10]:47987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eoAH2-0001X3-Pw
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eoAGy-0003zn-8m
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:56:08 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:57426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1eoAGy-0003zP-26
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:56:04 -0500
References: <20180219061827.2112-1-david.brenken@efs-auto.org>
	<20180219061827.2112-3-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <398fa3a7-4a6f-2bc4-9c18-355d898d3fb6@mail.uni-paderborn.de>
Date: Tue, 20 Feb 2018 16:53:15 +0100
MIME-Version: 1.0
In-Reply-To: <20180219061827.2112-3-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] tricore: added CORE_ID
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

On 02/19/2018 07:18 AM, David Brenken wrote:
> From: David Brenken <david.brenken@efs-auto.de>
> 
> Signed-off-by: David Brenken <david.brenken@efs-auto.de>
> Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
> Signed-off-by: Florian Artmeier <florian.artmeier@efs-auto.de>
> ---
>  target/tricore/cpu.h    | 1 +
>  target/tricore/csfr.def | 1 +
>  2 files changed, 2 insertions(+)
>


Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
