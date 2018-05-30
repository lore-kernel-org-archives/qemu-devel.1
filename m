Received: from eggs.gnu.org ([2001:4830:134:3::10]:35539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO97e-0001v7-07
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO97a-0007RX-V2
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:59:10 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fO97a-0007Qq-Ln
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:59:06 -0400
Received: by mail-pg0-x244.google.com with SMTP id a13-v6so8733369pgu.4
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 14:59:06 -0700 (PDT)
References: <20180529194207.31503-1-laurent@vivier.eu>
	<20180529194207.31503-9-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c5abf470-3407-c13a-156d-310bd8f4908a@linaro.org>
Date: Wed, 30 May 2018 14:59:01 -0700
MIME-Version: 1.0
In-Reply-To: <20180529194207.31503-9-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/15] linux-user: move
 get_sp_from_cpustate() to target_cpu.h
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

On 05/29/2018 12:42 PM, Laurent Vivier wrote:
> Remove useless includes
> Fix HPPA include guard.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
