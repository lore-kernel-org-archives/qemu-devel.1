Received: from eggs.gnu.org ([208.118.235.92]:56173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gcdjx-0006aQ-JE
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gcdju-0008Ph-Et
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:02:53 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gcdjs-00083k-GC
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:02:49 -0500
Received: by mail-ed1-x543.google.com with SMTP id h15so16240199edb.4
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 14:02:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1545916380-12816-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ffea8de2-2bc7-da9f-61d0-62c6baa90efc@amsat.org>
Date: Thu, 27 Dec 2018 23:02:33 +0100
MIME-Version: 1.0
In-Reply-To: <1545916380-12816-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] tests: Reorganize MIPS TCG directories
 and files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: noring@nocrew.org, smarkovic@wavecomp.com, arikalo@wavecomp.com, amarkovic@wavecomp.com, alex.bennee@linaro.org, aurelien@aurel32.net

Hi Aleksandar,

On 12/27/18 2:12 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Reorganize MIPS TCG directories and files. The file movement is done
> using "git mv" command, so "git blame" will still display the original
> information, regardles of the new names and locations of involved
> files.
> 
> Aleksandar Markovic (2):
>   tests: tcg: mips: Move source files to new location
>   tests: tcg: mips: Remove old directories after reorganization

It seems the list ate your patch 1/2...

See https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg06009.html

Regards,

Phil.
