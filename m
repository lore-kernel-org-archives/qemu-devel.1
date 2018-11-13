Received: from eggs.gnu.org ([2001:4830:134:3::10]:44472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMXsD-0005vq-B9
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMXsC-0006VL-41
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:32:52 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:36401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMXsB-0006IS-Jz
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:32:51 -0500
Received: by mail-oi1-x235.google.com with SMTP id r127-v6so10126300oie.3
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 04:32:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181112204929.12625-1-laurent@vivier.eu>
References: <20181112204929.12625-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 12:32:17 +0000
Message-ID: <CAFEAcA9ZNdn+gxTbjiY-j_V4cRPHUMp5cDpF4+v=3GiVAo0jqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Linux user for 3.1 patches
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

On 12 November 2018 at 20:49, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit b4c0595446cda9252d2c7bc84f3c02f3e591935a:
>
>   docker: use HTTPS git URL for virglrenderer (2018-11-12 11:26:02 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request
>
> for you to fetch changes up to 113a9dd73f6377941e0a4bfd7aea5370728b1c28:
>
>   linux-user: Add support for SO_REUSEPORT (2018-11-12 16:38:26 +0100)
>
> ----------------------------------------------------------------
> - gdb signal handling fix
> - add SO_REUSEPORT
> - remove dead-code
>
> ----------------------------------------------------------------


Applied, thanks.

-- PMM
