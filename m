Received: from eggs.gnu.org ([2001:4830:134:3::10]:37194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8RBK-0001vz-2J
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8R8R-0004xr-1z
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:31:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8R8Q-0004vu-Qv
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:31:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so13779968wrt.10
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 07:31:18 -0700 (PDT)
References: <1538656491-22950-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <25cc757f-f73e-807f-3209-3fbd981e7a46@redhat.com>
Date: Fri, 5 Oct 2018 16:31:16 +0200
MIME-Version: 1.0
In-Reply-To: <1538656491-22950-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] Misc MIPS fixes and improvements for
 October 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: dnikolic@wavecomp.com, smarkovic@wavecomp.com, richard.henderson@linaro.org, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, aurelien@aurel32.net

Hi Aleksandar,

On 04/10/2018 14:34, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> This series contains support for DSP R3 availability control and
> emulation of nanoMIPS EVA instructions.
> 
> Dimitrije Nikolic (2):
>   target/mips: Add opcodes for nanoMIPS EVA instructions
>   target/mips: Implement emulation of nanoMIPS EVA instructions
> 
> Stefan Markovic (2):
>   target/mips: Add bit definitions for DSP R3 ASE
>   target/mips: Add availability control for DSP R3 ASE

It seems all these patches miss their author Signed-off-by tag.

Regards,

Phil.
