Received: from eggs.gnu.org ([2001:4830:134:3::10]:50955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOf1-0001ot-Lp
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOew-0007NT-Pb
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:30:39 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euOew-0007N6-Eq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:30:34 -0500
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-7-lukeshu@lukeshu.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <cd6a8d5f-638f-2c47-7487-71bb87670ec7@vivier.eu>
Date: Fri, 9 Mar 2018 21:30:23 +0100
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-7-lukeshu@lukeshu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/10] linux-user: init_guest_commpage: Add
 a comment about size check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>, qemu-devel@nongnu.org
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>

Le 28/12/2017 à 19:08, Luke Shumaker a écrit :
> From: Luke Shumaker <lukeshu@parabola.nu>
> 
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
