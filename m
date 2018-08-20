Received: from eggs.gnu.org ([2001:4830:134:3::10]:55535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fro58-00041D-BQ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fro56-0008VD-Fg
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:35:09 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fro55-0008Ua-FI
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:35:08 -0400
Received: by mail-oi0-x243.google.com with SMTP id w126-v6so27228434oie.7
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 10:35:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180820171557.7734-5-laurent@vivier.eu>
References: <20180820171557.7734-1-laurent@vivier.eu>
	<20180820171557.7734-5-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 18:34:46 +0100
Message-ID: <CAFEAcA8y7XcuH9U0Kqw0-j669yJDudY4G0KF8==+LVXs-Dx4kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] linux-user: add QEMU_IFLA_INFO_KIND
 nested type for tun
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 20 August 2018 at 18:15, Laurent Vivier <laurent@vivier.eu> wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
