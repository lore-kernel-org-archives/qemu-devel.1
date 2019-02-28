Received: from eggs.gnu.org ([209.51.188.92]:55477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gzGeI-0004MB-80
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:02:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gzGeE-0008Bh-GM
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:02:33 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:55764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gzGeD-00089k-8D
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:02:30 -0500
References: <20190228052432.32571-1-richard.henderson@linaro.org>
	<20190228052432.32571-3-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <51f75752-5f46-9ee4-1afa-d9eb619aa182@mail.uni-paderborn.de>
Date: Thu, 28 Feb 2019 09:01:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190228052432.32571-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/8] decodetree: Move documentation to
 docs/devel/decodetree.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org

On 2/28/19 6:24 AM, Richard Henderson wrote:
> One great big block comment isn't the best way to document
> the syntax of a language.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   MAINTAINERS               |   1 +
>   docs/devel/decodetree.rst | 156 ++++++++++++++++++++++++++++++++++++++
>   scripts/decodetree.py     | 134 +-------------------------------
>   3 files changed, 158 insertions(+), 133 deletions(-)
>   create mode 100644 docs/devel/decodetree.rst

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,

Bastian
