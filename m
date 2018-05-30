Received: from eggs.gnu.org ([2001:4830:134:3::10]:34379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO91T-0008DF-Ht
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO91Q-0002bR-HV
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:52:47 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fO91Q-0002b3-BU
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:52:44 -0400
Received: by mail-pg0-x242.google.com with SMTP id 15-v6so8408749pge.2
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 14:52:44 -0700 (PDT)
References: <20180529194207.31503-1-laurent@vivier.eu>
	<20180529194207.31503-5-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8c027a5d-92e8-b04b-f91b-5f9b051a969e@linaro.org>
Date: Wed, 30 May 2018 14:52:40 -0700
MIME-Version: 1.0
In-Reply-To: <20180529194207.31503-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/15] linux-user: move arm/aarch64/m68k
 fcntl definitions to [arm|aarch64|m68k]/target_fcntl.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 05/29/2018 12:41 PM, Laurent Vivier wrote:
> No code change.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/aarch64/target_fcntl.h | 5 +++++
>  linux-user/arm/target_fcntl.h     | 6 ++++++
>  linux-user/m68k/target_fcntl.h    | 6 ++++++
>  linux-user/syscall_defs.h         | 7 +------
>  4 files changed, 18 insertions(+), 6 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
