Received: from eggs.gnu.org ([2001:4830:134:3::10]:52258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1Bfh-00039t-5D
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1Bfe-00035k-MW
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:58:51 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1Bfe-00034l-GZ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:58:50 -0400
Received: by mail-wr0-x229.google.com with SMTP id o21so35029414wrb.2
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 05:58:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170415180316.2694-1-shah.suramya@gmail.com>
References: <20170415180316.2694-1-shah.suramya@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 13:58:28 +0100
Message-ID: <CAFEAcA9rHB4zJo3zYa_-i+PC5ozRkJnRcTNq9bGZzug6X3nz=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Qomify pxa2xx.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suramya Shah <shah.suramya@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>

On 15 April 2017 at 19:03, Suramya Shah <shah.suramya@gmail.com> wrote:
> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> ---
>  hw/arm/pxa2xx.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Thanks for this patch -- I have applied it to the target-arm.next branch.

-- PMM
