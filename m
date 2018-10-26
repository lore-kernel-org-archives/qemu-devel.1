Received: from eggs.gnu.org ([2001:4830:134:3::10]:43380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFwW7-0000gf-G7
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFwW3-00027K-Gf
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:26:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gFwW3-00026T-3P
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:26:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id 189-v6so428045wmw.2
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 00:26:42 -0700 (PDT)
References: <20181023203710.GA2239@sx9>
	<9aea2b05-24d7-f845-d899-0c6fec033672@linaro.org>
	<20181025170128.GA2309@sx9>
	<alpine.LFD.2.21.1810251839110.19280@eddie.linux-mips.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a6a9b9eb-3bb3-eeba-84c2-65097185cea4@linaro.org>
Date: Fri, 26 Oct 2018 08:26:38 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1810251839110.19280@eddie.linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maciej W. Rozycki" <macro@linux-mips.org>, Fredrik Noring <noring@nocrew.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

On 10/25/18 7:03 PM, Maciej W. Rozycki wrote:
> Overall this source file is clearly a modified copy of an ancient version 
> of the opcode table included with the opcodes library from binutils and I 
> think it would benefit from a refresh.

You can't do that because of GPL v3, sadly.


r~
