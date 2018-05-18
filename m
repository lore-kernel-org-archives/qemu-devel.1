Received: from eggs.gnu.org ([2001:4830:134:3::10]:35915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1fJlQP-0000Tk-Qv
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1fJlQL-0000Xp-95
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:52:25 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:45047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1fJlQL-0000XX-28
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:52:21 -0400
References: <cover.1526671191.git.julian@codesourcery.com>
	<845fc301f4a7725c239708c58876e3ae4d858fd9.1526671191.git.julian@codesourcery.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <805fc7b5-03f0-56d4-abfd-ed010d4fa769@denx.de>
Date: Fri, 18 May 2018 21:52:04 +0200
MIME-Version: 1.0
In-Reply-To: <845fc301f4a7725c239708c58876e3ae4d858fd9.1526671191.git.julian@codesourcery.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] Add Nios II semihosting support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>, qemu-devel@nongnu.org
Cc: Sandra Loosemore <sandra@codesourcery.com>, Chris Wulff <crwulff@gmail.com>, Andrew Jenner <Andrew_Jenner@mentor.com>

On 05/18/2018 09:23 PM, Julian Brown wrote:
> This patch (by Sandra Loosemore, mildly rebased) adds support for
> semihosting for Nios II bare-metal emulation.
> 
> Signed-off-by: Julian Brown <julian@codesourcery.com>
> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>

Is there some documentation for this stuff ? It looks interesting, but
how can I try it here ?

[...]

-- 
Best regards,
Marek Vasut
