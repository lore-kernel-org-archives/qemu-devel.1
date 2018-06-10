Received: from eggs.gnu.org ([2001:4830:134:3::10]:44523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRysu-0004Vc-NN
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 07:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRysr-0002yQ-Lg
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 07:51:48 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fRysr-0002y7-BG
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 07:51:45 -0400
References: <20180610030220.3777-1-richard.henderson@linaro.org>
	<20180610030220.3777-2-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ba7edc18-2cbb-17e0-27d5-ea6bb7452c58@vivier.eu>
Date: Sun, 10 Jun 2018 13:51:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180610030220.3777-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 001/108] linux-user: Remove DEBUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 10/06/2018 à 05:00, Richard Henderson a écrit :
> This is redundant with both -strace and actual tracing.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 10 ----------
>  1 file changed, 10 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
