Received: from eggs.gnu.org ([2001:4830:134:3::10]:40177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cTFjL-0002CM-IX
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cTFjI-0007xh-F4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:26:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:51864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cTFjI-0007xW-8Y
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:26:20 -0500
References: <20161231132226.9595-1-marex@denx.de>
	<20161231132226.9595-3-marex@denx.de>
From: Alexander Graf <agraf@suse.de>
Message-ID: <fd8fa57f-290b-70c8-b49c-bb830847e219@suse.de>
Date: Mon, 16 Jan 2017 23:26:17 +0100
MIME-Version: 1.0
In-Reply-To: <20161231132226.9595-3-marex@denx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 3/7] nios2: Add usermode binaries
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org
Cc: Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Ley Foon Tan <lftan@altera.com>



On 31/12/2016 14:22, Marek Vasut wrote:
> Add missing bits for qemu-user required for emulating Altera Nios2
> userspace binaries.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Jeff Da Silva <jdasilva@altera.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Sandra Loosemore <sandra@codesourcery.com>
> Cc: Yves Vandervennet <yvanderv@altera.com>
> ---
> V3: Checkpatch cleanup
> V4: Rebase on top of qemu/master

LGTM

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
