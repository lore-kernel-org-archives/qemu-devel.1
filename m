Received: from eggs.gnu.org ([2001:4830:134:3::10]:39593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIAdl-0000jv-BF
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIAdk-0005fy-65
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:55:53 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIAdi-0005cq-4f
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:55:51 -0400
Received: by mail-ot1-x344.google.com with SMTP id k9so17322699otl.10
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 03:55:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030183424.609-1-jcmvbkbc@gmail.com>
References: <20181030183424.609-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 10:55:22 +0000
Message-ID: <CAFEAcA_15eXjdbRZ5zH=ZSHJyApoW1LV+r77z+PQUaQHmefCjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] target/xtensa updates for 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 October 2018 at 18:34, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following series that adds bFLT binaries support for
> target/xtensa.
>
> The following changes since commit 3892f1f1a963e59dfe012cd9d461d33b2986fa3b:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/libfdt-20181002' into staging (2018-10-02 09:54:44 +0100)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20181030-xtensa
>
> for you to fetch changes up to 5c76d652ab567a230f2ef0022b7ea5acb693e19c:
>
>   linux-user/flatload: fix initial stack pointer alignment (2018-10-30 11:23:32 -0700)
>
> ----------------------------------------------------------------
> target/xtensa: support for bFLT binaries
>
> - add support for bFLT binaries for target/xtensa
> - fix per-architecture target_flat.h customization
> - fix initial stack pointer for bFLT
>
> ----------------------------------------------------------------
> Max Filippov (2):
>       linux-user: xtensa: enable bFLT support
>       linux-user/flatload: fix initial stack pointer alignment

Applied, thanks.

-- PMM
