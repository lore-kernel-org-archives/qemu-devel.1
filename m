Received: from eggs.gnu.org ([2001:4830:134:3::10]:45456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvEA-0002y8-6g
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvE7-0006aT-3O
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:33:14 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47619)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPvE6-0006Zz-Q3
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:33:11 -0400
References: <20180601073050.8054-1-richard.henderson@linaro.org>
	<20180601073050.8054-4-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4c38dda9-1563-f226-734a-1aaa53064f79@vivier.eu>
Date: Mon, 4 Jun 2018 21:33:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180601073050.8054-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/33] linux-user: Propagate goto ebadf to
 return
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
>  linux-user/syscall.c | 187 +++++++++++++++++++++----------------------
>  1 file changed, 92 insertions(+), 95 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
