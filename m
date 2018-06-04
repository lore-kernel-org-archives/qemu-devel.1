Received: from eggs.gnu.org ([2001:4830:134:3::10]:45775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvGq-00049c-EM
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvGl-00085K-GF
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:36:00 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPvGl-00084x-5v
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:35:55 -0400
References: <20180601073050.8054-1-richard.henderson@linaro.org>
	<20180601073050.8054-5-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8ebe1cef-e8b9-21d7-192d-8883b9f9aa64@vivier.eu>
Date: Mon, 4 Jun 2018 21:35:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180601073050.8054-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/33] linux-user: Propagate goto efault to
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
>  linux-user/syscall.c | 311 +++++++++++++++++++++----------------------
>  1 file changed, 154 insertions(+), 157 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
