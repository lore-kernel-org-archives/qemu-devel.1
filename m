Received: from eggs.gnu.org ([2001:4830:134:3::10]:45223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coSoq-00007I-Jn
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coSop-0007vg-LA
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:39:44 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coSop-0007vU-Ed
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:39:43 -0400
Received: by mail-wr0-x231.google.com with SMTP id g10so28841601wrg.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 03:39:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170316092030.1685-2-iwona260909@gmail.com>
References: <20170316092030.1685-1-iwona260909@gmail.com>
	<20170316092030.1685-2-iwona260909@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 10:39:21 +0000
Message-ID: <CAFEAcA9oRHtpTfdddcj3bQRjn1eL6vQKjiWRCPohhdZHeaHVbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Dead Code Removal: removing support for
 DEPTH != 32.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: iwona260909@gmail.com
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 March 2017 at 09:20,  <iwona260909@gmail.com> wrote:
> From: Iwona Kotlarska <iwona260909@gmail.com>
>
> Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>
> ---
>  hw/display/sm501.c          | 37 -------------------------------------
>  hw/display/sm501_template.h |  8 +-------
>  2 files changed, 1 insertion(+), 44 deletions(-)

Hi; thanks for this patch. Unfortunately Gerd already
sent a patchset a couple of weeks ago to do this for this
device:
http://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg01172.html

thanks
-- PMM
