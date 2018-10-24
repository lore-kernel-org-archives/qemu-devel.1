Received: from eggs.gnu.org ([2001:4830:134:3::10]:41624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHBM-0003nP-H2
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHBH-00083f-0i
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:18:36 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gFHBF-0007yE-7z
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:18:30 -0400
Received: by mail-wr1-x433.google.com with SMTP id w5-v6so5155587wrt.2
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 04:18:26 -0700 (PDT)
References: <1540376314-5727-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <04d22eb7-ee97-2362-6bd0-7583fa910c43@linaro.org>
Date: Wed, 24 Oct 2018 12:18:22 +0100
MIME-Version: 1.0
In-Reply-To: <1540376314-5727-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configs/alpha: Remove unused
 CONFIG_PARALLEL_ISA switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

On 10/24/18 11:18 AM, Thomas Huth wrote:
> We don't use CONFIG_PARALLEL_ISA in any of our Makefiles, so this
> is just a dead config option which can be removed.
> 
> Fixes: a4cb773928e047b137c6998209cf2eec857fac6b
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/alpha-softmmu.mak | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
