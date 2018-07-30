Received: from eggs.gnu.org ([2001:4830:134:3::10]:45674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkBUU-0004lL-MS
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkBUR-0006kf-Vv
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:57:50 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fkBUR-0006kO-KL
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:57:47 -0400
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-9-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0306c5c6-d7bf-9018-8679-be11970420ad@vivier.eu>
Date: Mon, 30 Jul 2018 18:56:37 +0200
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-9-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 08/76] elf: Add ELF flags for MIPS
 machine variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

Le 30/07/2018 à 18:11, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Add MIPS machine variants ELF flags so that the emulation behavior
> can be adjusted if needed.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/elf.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
