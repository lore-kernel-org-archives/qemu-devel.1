Received: from eggs.gnu.org ([2001:4830:134:3::10]:42658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fEpwT-0001Vn-1M
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fEpwS-00053Z-DF
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:41:09 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fEpwS-00053N-7W
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:41:08 -0400
Received: by mail-pf0-x242.google.com with SMTP id o76so18982499pfi.5
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 22:41:08 -0700 (PDT)
Date: Sat, 5 May 2018 14:41:05 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180505054105.GL4501@lianli.shorne-pla.net>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
	<20180504054030.24527-12-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504054030.24527-12-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 11/13] target/openrisc: Convert dec_compi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Thu, May 03, 2018 at 10:40:28PM -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  target/openrisc/translate.c  | 116 +++++++++++++++++++++----------------------
>  target/openrisc/insns.decode |  12 +++++
>  2 files changed, 70 insertions(+), 58 deletions(-)
> 
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
 
