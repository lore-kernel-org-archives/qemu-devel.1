Received: from eggs.gnu.org ([2001:4830:134:3::10]:35782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFg1E-0008V1-DP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFg19-0001wx-79
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:49:48 -0400
References: <1540376314-5727-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9c924931-beed-3a3b-d033-87a7fa4863f1@vivier.eu>
Date: Thu, 25 Oct 2018 14:49:30 +0100
MIME-Version: 1.0
In-Reply-To: <1540376314-5727-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] configs/alpha: Remove
 unused CONFIG_PARALLEL_ISA switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 24/10/2018 11:18, Thomas Huth wrote:
> We don't use CONFIG_PARALLEL_ISA in any of our Makefiles, so this
> is just a dead config option which can be removed.
> 
> Fixes: a4cb773928e047b137c6998209cf2eec857fac6b
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/alpha-softmmu.mak | 1 -
>  1 file changed, 1 deletion(-)

Applied

Thanks,
Laurent
