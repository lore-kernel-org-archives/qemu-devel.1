Received: from eggs.gnu.org ([2001:4830:134:3::10]:33957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO8zM-00071O-DH
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO8zJ-0001W5-B6
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:50:36 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:40603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fO8zI-0001VQ-Uo
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:50:33 -0400
Received: by mail-pl0-x242.google.com with SMTP id t12-v6so11884348plo.7
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 14:50:32 -0700 (PDT)
References: <20180529194207.31503-1-laurent@vivier.eu>
	<20180529194207.31503-3-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e6429d58-385c-4183-ff76-42486968e603@linaro.org>
Date: Wed, 30 May 2018 14:50:29 -0700
MIME-Version: 1.0
In-Reply-To: <20180529194207.31503-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/15] linux-user: move alpha fcntl
 definitions to alpha/target_fcntl.h
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
>  linux-user/alpha/target_fcntl.h | 29 +++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h       | 32 ++------------------------------
>  2 files changed, 31 insertions(+), 30 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
