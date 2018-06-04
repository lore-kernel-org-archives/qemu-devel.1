Received: from eggs.gnu.org ([2001:4830:134:3::10]:48604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvUu-0001PQ-AJ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvUq-0007KC-D5
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:50:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPvUq-0007IX-33
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:50:28 -0400
References: <20180601073050.8054-1-richard.henderson@linaro.org>
	<20180601073050.8054-9-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2a5c1e49-4867-d0af-1026-386f1c6bce5c@vivier.eu>
Date: Mon, 4 Jun 2018 21:50:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180601073050.8054-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/33] linux-user: Make syscall number
 unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 01/06/2018 à 09:30, Richard Henderson a écrit :
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/qemu.h    |  2 +-
>  linux-user/syscall.c | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
