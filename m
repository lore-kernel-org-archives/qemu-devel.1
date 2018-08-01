Received: from eggs.gnu.org ([2001:4830:134:3::10]:57731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkojH-0001hT-3o
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkojE-0000Dx-00
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:51:43 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:32868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkojD-0000Dh-QL
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:51:39 -0400
Received: by mail-vk0-x244.google.com with SMTP id y70-v6so9058389vkc.0
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 03:51:39 -0700 (PDT)
References: <20180801102944.23457-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f49ff122-3e96-71f1-1424-b6ceda8248f0@linaro.org>
Date: Wed, 1 Aug 2018 06:51:34 -0400
MIME-Version: 1.0
In-Reply-To: <20180801102944.23457-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: add x86_64 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Tom A <agentlecomputer@gmail.com>, Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>

On 08/01/2018 06:29 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  scripts/qemu-binfmt-conf.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
