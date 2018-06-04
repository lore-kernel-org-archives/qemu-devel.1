Received: from eggs.gnu.org ([2001:4830:134:3::10]:49448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPva0-0002rD-KK
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvZw-0002Kb-NK
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:55:48 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPvZw-0002Hu-8y
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:55:44 -0400
References: <20180601073050.8054-1-richard.henderson@linaro.org>
	<20180601073050.8054-10-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7e1bb673-afc1-b716-106a-33f2efa71f15@vivier.eu>
Date: Mon, 4 Jun 2018 21:55:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180601073050.8054-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/33] linux-user: Set up infrastructure
 for table-izing syscalls
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
>  linux-user/syscall.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
