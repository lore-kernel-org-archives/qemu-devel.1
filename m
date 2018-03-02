Received: from eggs.gnu.org ([2001:4830:134:3::10]:38656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eriDu-0002dk-Nx
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:47:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eriDr-0001si-Cx
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:47:34 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:47270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1eriDr-0001sP-5P
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:47:31 -0500
References: <20180301155619.8640-1-david.brenken@efs-auto.org>
	<20180301155619.8640-2-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <23022a84-0948-b6a2-1b11-857504838338@mail.uni-paderborn.de>
Date: Fri, 2 Mar 2018 11:47:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180301155619.8640-2-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] tricore: added some missing cpu
 instructions
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
>  target/tricore/translate.c       | 27 +++++++++++++++++++++++++++
>  target/tricore/tricore-opcodes.h |  3 +++
>  2 files changed, 30 insertions(+)

A more descriptive commit message would be nice. Which instructions have
been added?

Cheers,
Bastian
