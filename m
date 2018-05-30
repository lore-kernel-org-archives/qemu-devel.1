Received: from eggs.gnu.org ([2001:4830:134:3::10]:34179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO90Q-0007Wm-JC
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO90N-00021H-ID
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:51:42 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fO90N-000213-Ay
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:51:39 -0400
Received: by mail-pl0-x244.google.com with SMTP id ay10-v6so11895080plb.1
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 14:51:39 -0700 (PDT)
References: <20180529194207.31503-1-laurent@vivier.eu>
	<20180529194207.31503-4-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5f19ae69-808c-e13c-a064-98f2c621cef5@linaro.org>
Date: Wed, 30 May 2018 14:51:35 -0700
MIME-Version: 1.0
In-Reply-To: <20180529194207.31503-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/15] linux-user: move hppa fcntl
 definitions to hppa/target_fcntl.h
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
>  linux-user/hppa/target_fcntl.h | 31 +++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h      | 34 +---------------------------------
>  2 files changed, 32 insertions(+), 33 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
