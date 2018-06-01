Received: from eggs.gnu.org ([2001:4830:134:3::10]:39918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOr43-0004Op-TT
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOr40-0008Dc-RO
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:54:23 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fOr40-0008Bl-Hj
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:54:20 -0400
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-5-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f965398d-a510-0a5d-af50-a79334226cb4@vivier.eu>
Date: Fri, 1 Jun 2018 22:54:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180531224911.23725-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/6] linux-user: Check contains_hostfd in
 select syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, evgreen@chromium.org

Le 01/06/2018 à 00:49, Richard Henderson a écrit :
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
