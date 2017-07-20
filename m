Received: from eggs.gnu.org ([2001:4830:134:3::10]:47366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY5qe-0000lH-9u
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY5qZ-0005pq-NV
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:26:12 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:33710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dY5qZ-0005pY-It
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:26:07 -0400
Received: by mail-qk0-x22e.google.com with SMTP id p126so10285494qkf.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 00:26:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-19-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d6785718-f828-61ab-7043-a23327b4bdfc@twiddle.net>
Date: Wed, 19 Jul 2017 21:26:00 -1000
MIME-Version: 1.0
In-Reply-To: <1500520169-23367-19-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 18/43] target/sh4: check CF_PARALLEL
 instead of parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/19/2017 05:09 PM, Emilio G. Cota wrote:
> Thereby decoupling the resulting translated code from the current state
> of the system.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   target/sh4/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
