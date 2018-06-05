Received: from eggs.gnu.org ([2001:4830:134:3::10]:54849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQEZT-0004nl-Ud
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQEZS-00024l-5b
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:12:31 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:43992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQEZS-00024B-0w
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:12:30 -0400
Received: by mail-oi0-x244.google.com with SMTP id t133-v6so2587656oif.10
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 09:12:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605160958.5434-1-laurent@vivier.eu>
References: <20180605160958.5434-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 17:12:08 +0100
Message-ID: <CAFEAcA9-+gZjQNLM9bqutg=PG62nCzwrVbSye3+eeyGoYXJLZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: disable qemu-bridge-helper
 and socket_scm_helper build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On 5 June 2018 at 17:09, Laurent Vivier <laurent@vivier.eu> wrote:
> linux-user targets don't need them, and if we ask to build statically
> linked binaries, some static libraries they need are not available.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
