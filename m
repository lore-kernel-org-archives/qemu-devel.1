Received: from eggs.gnu.org ([209.51.188.92]:41296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gygNF-0000Pr-Fc
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gygN9-0003DP-TT
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:18:32 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gygN4-000375-6g
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:18:26 -0500
Received: by mail-pg1-x529.google.com with SMTP id q206so6518291pgq.4
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:18:20 -0800 (PST)
References: <155119086741.1037569.12734854713022304642.stgit@bahia.lan>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6559ab4e-abc1-5c48-80a9-3787ae95fda1@linaro.org>
Date: Tue, 26 Feb 2019 09:18:16 -0800
MIME-Version: 1.0
In-Reply-To: <155119086741.1037569.12734854713022304642.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] bswap: Fix accessors syntax in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>

On 2/26/19 6:21 AM, Greg Kurz wrote:
> All accessors that have an endian infix DO have an underscore between
> {size} and {endian}.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  include/qemu/bswap.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
