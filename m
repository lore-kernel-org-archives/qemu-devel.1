Received: from eggs.gnu.org ([2001:4830:134:3::10]:51258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHpd9-0001MV-10
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHpd4-00013h-8J
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:29:50 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gHpd3-00012c-Tp
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:29:46 -0400
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-21-cota@braap.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <892248af-a338-7f86-925c-c98fb6c6ed42@vivier.eu>
Date: Wed, 31 Oct 2018 13:29:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-21-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 21/71] m68k: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On 25/10/2018 16:45, Emilio G. Cota wrote:
> Cc: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/m68k/op_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
